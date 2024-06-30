import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentprovider/model/student_model.dart';
import 'package:studentprovider/provider/student_provider.dart';
import 'package:studentprovider/provider/theme_provider.dart';
import 'package:studentprovider/view/add_screen.dart';
import 'package:studentprovider/view/detail_screen.dart';
import 'package:studentprovider/view/edit_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context);
    final studentProvider = Provider.of<StudentProvider>(context);
    return Scaffold(
      backgroundColor:
          provider.isDarkMode ? Colors.transparent : Colors.blue[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
              onPressed: () {
                provider.togglerChange();
              },
              icon: Icon(
                provider.isDarkMode
                    ? Icons.nightlight_round_outlined
                    : Icons.sunny,
                color:
                    provider.isDarkMode ? Colors.blue[100] : Colors.indigo[500],
              ))
        ],
      ),
      body: ListView.builder(
          itemCount: studentProvider.students.length,
          itemBuilder: (context, index) {
            final StudentModel student = studentProvider.students[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => StudentDetails(
                            student: student,
                          )));
                },
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: provider.isDarkMode
                            ? Colors.transparent
                            : Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: const Offset(0, 3),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                    color:
                        provider.isDarkMode ? Colors.grey[850] : Colors.white,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: student.photo == null
                          ? const AssetImage(
                              'lib/assets/ea829acc861a7c3f81182ad2929a5242.jpg')
                          : FileImage(File(student.photo!)),
                      maxRadius: 30,
                    ),
                    title: Text(student.studentName!),
                    subtitle: Text(student.age!),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => EditScreen(
                                      student: student,
                                    )));
                          },
                        ),
                        IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Delete'),
                                    content: const Text(
                                        'Are you sure you want to delete this student?'),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Cancel')),
                                      TextButton(
                                          onPressed: () {
                                            studentProvider
                                                .deleteStudent(student);
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Delete'))
                                    ],
                                  );
                                },
                              );
                            })
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddScreen()));
        },
        child: Icon(Icons.person_add_sharp),
        foregroundColor: provider.isDarkMode
            ? Color.fromARGB(255, 215, 235, 236)
            : Color.fromARGB(255, 70, 89, 103),
        backgroundColor: provider.isDarkMode
            ? Color.fromARGB(255, 70, 89, 103)
            : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0), // Adjust as per your needs
        ),
      ),
    );
  }
}
