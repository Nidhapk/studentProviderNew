import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentprovider/model/student_model.dart';
import 'package:studentprovider/provider/theme_provider.dart';
import 'package:studentprovider/widgets/detail_row.dart';
import 'package:studentprovider/widgets/divider.dart';
import 'package:studentprovider/widgets/photo_container.dart';

class StudentDetails extends StatelessWidget {
  final StudentModel student;
  const StudentDetails({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor:
          provider.isDarkMode ? Colors.transparent : Colors.blue[50],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              PhotoContainer(
                  assetpath: 'lib/assets/ea829acc861a7c3f81182ad2929a5242.jpg',
                  filepath: student.photo!,
                  condition: student.photo == null),
              const SizedBox(
                height: 50,
              ),
              DetailRow(title: 'Name', details: student.studentName ?? ''),
           const   Kdivider(),
              DetailRow(title: 'Age', details: student.age ?? ''),
             const   Kdivider(),
              DetailRow(title: 'Place', details: student.place ?? ''),
             const   Kdivider(),
              DetailRow(title: 'Phone no.', details: student.phoneNo ?? ''),
            ],
          ),
        ),
      ),
    );
  }
}
