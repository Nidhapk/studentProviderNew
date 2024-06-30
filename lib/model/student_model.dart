import 'package:hive/hive.dart';

part 'student_model.g.dart';

@HiveType(typeId: 0)
class StudentModel extends HiveObject {
  @HiveField(0)
  String? studentName;

  @HiveField(1)
  String? place;

  @HiveField(2)
  String? phoneNo;

  @HiveField(3)
  String? photo;

  @HiveField(4)
  String? age;

  StudentModel({
    required this.studentName,
    required this.place,
    required this.phoneNo,
    required this.photo,
    required this.age,
  });
}