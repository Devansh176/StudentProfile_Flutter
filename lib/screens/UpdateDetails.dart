import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:student_profile/Model/StudentModel.dart';
import 'package:student_profile/screens/registerStudent.dart';


class UpdateDetails extends StatefulWidget {
  const UpdateDetails(StudentModel stm, BuildContext context, {super.key});

  @override
  State<UpdateDetails> createState() => _UpdateDetailsState();

  Future<bool> updateStudentDetails(StudentModel student) async {
    try {
      var url = Uri.parse('http://172.16.162.174:8080/UpdateStudentName');
      var response = await http.put(url,
          headers: <String, String>{"Content-Type": "application/json"},
          body: jsonEncode(student));

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception("Error updating student: ${response.statusCode}");
      }
    } catch (error) {
      throw Exception("Error updating student: $error");
    }
  }

}

class _UpdateDetailsState extends State<UpdateDetails> {

  late StudentModel student;
  late TextEditingController studentId;
  bool is_enabled = false;
  late TextEditingController firstController;
  late TextEditingController lastController;
  late FutureBuilder<List<StudentModel>> students;

  updateDetailState(student) async {
    firstController = TextEditingController(text: this.student.firstname);
    lastController = TextEditingController(text: this.student.lastname);
  }

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.titleMedium;

    return Scaffold(
      appBar: AppBar(
        title: Text("Update Details"),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => studentDrawer()));
          },
        ),
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(
                    top: 3.0,
                    bottom: 3.0
                    ),
                    child: TextFormField(
                    style: textStyle,
                    controller: studentId,
                    enabled: is_enabled,
                    validator: (String? value){
                      if(value == null || value.isEmpty){
                      return 'Please Enter Your Id';}else{
                      return null;}
                      },
                      decoration: InputDecoration(
                      labelText: 'Student Id',
                      hintText: 'Enter Student Id',
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        )
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 3.0,
                      bottom: 3.0
                      ),
                      child: TextFormField(
                        style: textStyle,
                        controller: firstController,
                        validator: (String? value){
                          if(value == null || value.isEmpty){
                          return 'Please Enter Your First Name';}else{
                          return null;}
                          },
                          decoration: InputDecoration(
                            labelText: 'First Name',
                            hintText: 'Enter your First Name',
                            labelStyle: textStyle,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            )
                          ),
                      ),
                  ),
                ),
                Container(
                  width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                            top: 4.0,
                            bottom: 4.0
                            ),
                            child: TextFormField(
                              style: textStyle,
                              controller: lastController,
                              validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                  return 'Please Enter Your Last Name';
                                  }
                                  return null; // Return null when input is valid
                              },
                              decoration: InputDecoration(
                                labelText: 'Last Name',
                                hintText: 'Enter your last name',
                                labelStyle: textStyle,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                           ),
                          ),
                          ElevatedButton(
                            child: const Text('Update Details'),
                            onPressed: () async {
                              String firstname = firstController.text;
                              String lastname = lastController.text;
                              StudentModel stm = StudentModel(
                                  studentId: student.studentId,
                                  firstname: firstname,
                                  lastname: lastname);
                              try {
                                StudentModel students = (await UpdateDetails(
                                    stm, context)) as StudentModel;
                                setState(() {
                                  student = students;
                                });
                              } catch (error) {};
                            }
                          ),
                        ],
                      )
                    )
                 )
                ]
            )
        )
      )
    );
  }

  studentDrawer() {}
}
