// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:studentprovider/model/student_model.dart';
import 'package:studentprovider/provider/student_provider.dart';
import 'package:studentprovider/provider/theme_provider.dart';
import 'package:studentprovider/widgets/custom_textform.dart';

class EditScreen extends StatelessWidget {
  final StudentModel student;

  EditScreen({super.key, required this.student});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context);
    final imageprovider = Provider.of<EditImageprovider>(context);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (imageprovider.imagePath != student.photo) {
        imageprovider.initializeImagePath(student.photo ?? '');
      }
    });
    final nameController = TextEditingController(text: student.studentName);
    final ageController = TextEditingController(text: student.age);
    final placeController = TextEditingController(text: student.place);
    final phoneController = TextEditingController(text: student.phoneNo);

    return Scaffold(
      backgroundColor:
          provider.isDarkMode ? Colors.transparent : Colors.blue[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Add'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            decoration: BoxDecoration(
                color: provider.isDarkMode ? Colors.grey[850] : Colors.white),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () async {
                      await pickImage(context);
                    },
                    child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.withOpacity(0.5),
                        ),
                        child: Consumer<EditImageprovider>(
                            builder: (context, imageProvider, _) {
                          return imageProvider._imagePath != null &&
                                  imageProvider._imagePath!.isNotEmpty
                              ? ClipOval(
                                  child: Image.file(
                                  File(imageProvider.imagePath!),
                                  fit: BoxFit.cover,
                                ))
                              : const Icon(
                                  Icons.add_photo_alternate,
                                  size: 60,
                                  color: Colors.white,
                                );
                        })),
                  ),
                  CustomTextForm(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a name';
                        }
                        return null;
                      },
                      hintext: 'Name',
                      labeltext: "Enter your name",
                      controller: nameController),
                  CustomTextForm(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your age';
                        }
                        return null;
                      },
                      hintext: 'Age',
                      labeltext: "Enter your age",
                      controller: ageController),
                  CustomTextForm(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your place';
                        }
                        return null;
                      },
                      hintext: 'Place',
                      labeltext: "Enter your place",
                      controller: placeController),
                  CustomTextForm(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone no.';
                        }
                        return null;
                      },
                      hintext: 'Phone no.',
                      labeltext: "Enter your phone no.",
                      controller: phoneController),
                  ElevatedButton(
                      onPressed: () async {
                        await editStudent(
                            context,
                            nameController.text.trim(),
                            ageController.text.trim(),
                            placeController.text.trim(),
                            phoneController.text.trim());
                      },
                      child: const Text('Add'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  editStudent(BuildContext context, String name, String age, String place,
      String phone) async {
    if (formKey.currentState!.validate()) {
      student.studentName = name;
      student.place = place;
      student.phoneNo = phone;
      student.photo =
          Provider.of<EditImageprovider>(context, listen: false).imagePath ??
              '';
      student.age = age;

      Provider.of<StudentProvider>(context, listen: false)
          .updateStudent(student);
      Navigator.of(context).pop();
    }
  }

  Future<void> pickImage(BuildContext context) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      Provider.of<EditImageprovider>(context, listen: false)
          .setImagePath(pickedFile.path);
    }
  }
}

class EditImageprovider extends ChangeNotifier {
  String? _imagePath;

  String? get imagePath => _imagePath;

  void setImagePath(String? path) {
    _imagePath = path;
    notifyListeners();
  }

  void initializeImagePath(String path) {
    _imagePath = path;
    notifyListeners();
  }
}
