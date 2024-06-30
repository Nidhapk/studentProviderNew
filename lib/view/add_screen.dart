// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:studentprovider/model/student_model.dart';
import 'package:studentprovider/provider/student_provider.dart';
import 'package:studentprovider/provider/theme_provider.dart';
import 'package:studentprovider/view/edit_screen.dart';
import 'package:studentprovider/widgets/custom_textform.dart';

class AddScreen extends StatelessWidget {
  AddScreen({super.key});

  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final placeController = TextEditingController();
  final phoneController = TextEditingController();
  String? imagePath;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context);
    final imageProvider = Provider.of<Imageprovider>(context);
    // imageProvider.setImagePath(null);

    return Scaffold(
      backgroundColor:
          provider.isDarkMode ? Colors.transparent : Colors.blue[50],
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Provider.of<Imageprovider>(context, listen: false)
                  .setImagePath(null);
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios_new_rounded)),
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
                        child: Consumer<Imageprovider>(
                            builder: (context, imageprovider, _) {
                          return imageprovider.imagePath != null
                              ? ClipOval(
                                  child: Image.file(
                                  File(imageprovider.imagePath!),
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
                        await addStudent(context);
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

  addStudent(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      final StudentModel student = StudentModel(
        studentName: nameController.text,
        place: placeController.text,
        phoneNo: phoneController.text,
        photo:
            Provider.of<Imageprovider>(context, listen: false).imagePath ?? '',
        age: ageController.text,
      );
      Provider.of<StudentProvider>(context, listen: false).addStudent(student);
      Provider.of<Imageprovider>(context, listen: false).setImagePath(null);
      Navigator.of(context).pop();
    }
  }

  Future<void> pickImage(BuildContext context) async {
    // Provider.of<Imageprovider>(context, listen: false).setImagePath(null);
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      Provider.of<Imageprovider>(context, listen: false)
          .setImagePath(pickedFile.path);
    }
  }
}

class Imageprovider extends ChangeNotifier {
  String? _imagePath;

  String? get imagePath => _imagePath;

  void setImagePath(String? path) {
    _imagePath = path;
    notifyListeners();
  }
}
