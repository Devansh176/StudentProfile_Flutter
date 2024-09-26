import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:student_profile/Model/StudentModel.dart';
import 'package:student_profile/screens/DeleteStudent.dart';
import 'package:student_profile/screens/UpdateDetails.dart';
import 'package:student_profile/screens/studentDrawer.dart';
import 'package:http/http.dart' as http;

class GetStudent extends StatefulWidget {
  const GetStudent({super.key});

  @override
  State<GetStudent> createState() => _GetStudentState();
}

class _GetStudentState extends State<GetStudent> {

  Future<List<StudentModel>> getStudent() async{
    print('INSIDE GET STUDENT');
    var data = await http.get(Uri.parse('http://192.168.1.13:8080/getStudents'));
    var jsonData = json.decode(data.body);

    List<StudentModel> student = [];
    for(var s in jsonData){
      if(s['studentId'] == null){
        continue;
      }

      StudentModel students = StudentModel(
        studentId : s["studentId"],
        firstname : s["firstname"],
        lastname : s["lastname"],
      );
      student.add(students);
    }
    return student;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Details"),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => studentProfile()));
          },
        ),
      ),
      body: Container(
        child: FutureBuilder(
            future: getStudent(),
            builder: (BuildContext context,AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Container(
                    child: const Center(
                        child: Icon(Icons.error)
                    )
                );
              }
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    if(snapshot.hasData) {
                      return ListTile(
                        title: const Text(
                            'ID FirstName LastName'
                        ),
                        subtitle: Text(
                            '${snapshot.data[index].studentId}' " "'${snapshot.data[index].firstname}' " " '${snapshot.data[index].lastname}'
                        ),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (
                              context) => DetailPage(snapshot.data[index])));
                        },
                      );
                    }
                  }
              );
            }
        ),
      ),
    );
  }
}

class DetailPage extends StatefulWidget{
  StudentModel student;
  DetailPage(this.student);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  deleteStudent1(StudentModel stud)async{
    final url = Uri.parse('http://192.168.1.13:8080/deleteStudent');
    final request = http.Request("DELETE",url);
    request.headers.addAll(<String ,String>{
      "content-type" : "application/json"
    });
    request.body = jsonEncode(stud);
    final response = await request.send();
  }

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.student.firstname),
        actions: <Widget>[
          IconButton(
            onPressed: (){
              Navigator.push(
                  context, MaterialPageRoute(
                  builder: (context) => UpdateDetails(widget.student, context)));
            }, icon: const Icon(
            Icons.edit,
            color: Colors.white,
          ),
          ),
        ],
      ),
      body: Container(
        child: Text("FirstName ${widget.student.firstname} " " \n LastName ${widget.student.lastname} " ""),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          deleteStudent1(widget.student);
          Navigator.push(context, MaterialPageRoute(builder: (context) => const GetStudent()));
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.delete),
      ),
    );
  }
}