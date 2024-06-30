import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:studentprovider/model/student_model.dart';


class StudentProvider extends ChangeNotifier {
  final Box<StudentModel> _studentBox = Hive.box<StudentModel>('studentBox');

  List<StudentModel> get students => _studentBox.values.toList();

  void addStudent(StudentModel student) {
    _studentBox.add(student);
    notifyListeners();
  }

  void deleteStudent(StudentModel student) {
    int index=  _studentBox.values.toList().indexOf(student);
    _studentBox.deleteAt(index);
    notifyListeners();
  }

  void updateStudent( StudentModel student) {
  int index=  _studentBox.values.toList().indexOf(student);
  
    _studentBox.putAt(index, student);
    notifyListeners();
  }
}