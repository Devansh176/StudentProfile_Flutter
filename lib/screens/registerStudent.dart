import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class registerStudent extends StatefulWidget {
  const registerStudent({super.key});

  @override
  State<registerStudent> createState() => _registerStudentState();
}

class _registerStudentState extends State<registerStudent> {
  TextEditingController firstController = TextEditingController();
  TextEditingController lastController = TextEditingController();

  Future<void> _registerStudent(String FirstName, String Lastname, BuildContext context) async {
    try {
      print("First name: "  + FirstName);
      print("Last name: " + Lastname);
      var url = "http://192.168.1.13:8080/postStudent";
      var response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          "Content-Type": "application/json"
        },
        body: jsonEncode(<String, String>{
          "firstname": FirstName,
          "lastname": Lastname
        }),
      );

      if (response.statusCode == 200) {
        showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext dialogContext) {
            return MyAlertDialog(
              title: 'Successful Registration',
              content: response.body,
            );
          },
        );
      }
    }on Exception catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.titleMedium;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register "),
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
                    bottom: 3.0,
                  ),
                  child: TextFormField(
                    style: textStyle,
                    controller: firstController,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Your Name';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'First Name',
                      hintText: 'Enter your first name',
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
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
                          bottom: 4.0,
                        ),
                        child: TextFormField(
                          style: textStyle,
                          controller: lastController,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Your Name';
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
                        child: const Text("Submit"),
                        onPressed: () {
                          String firstName = firstController.text;
                          String lastName = lastController.text;
                          _registerStudent(firstName, lastName, context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyAlertDialog extends StatelessWidget {
  const MyAlertDialog({super.key, required this.title, required this.content, this.actions = const []});
  final String title;
  final String content;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        this.title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      actions: this.actions,
      content: Text(
        this.content,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
