import 'dart:convert';

class StudentModel{
  int studentId;
  String firstname;
  String lastname;

  StudentModel({required this.studentId,required this.firstname,required this.lastname});

  factory StudentModel.fromJson(Map<String, dynamic> json) =>
      StudentModel(
        studentId: json["studentId"], firstname: json["firstname"], lastname: json["lastname"]
      );

  Map<String,dynamic> toJson() =>
  {
    "studentId":studentId,
    "firstname": firstname,
    "lastname": lastname,
  };

  StudentModel studentModelJson(String str) => StudentModel.fromJson(json.decode(str));

  String studentModelToJson(StudentModel data) => json.encode(data.toJson());
}