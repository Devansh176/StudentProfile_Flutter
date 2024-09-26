import 'package:flutter/material.dart';
import 'package:student_profile/screens/GetStudent.dart';
import 'package:student_profile/screens/registerStudent.dart';

class studentProfile extends StatefulWidget {
  const studentProfile({super.key});

  @override
  State<studentProfile> createState() => _studentProfileState();
}

class _studentProfileState extends State<studentProfile> {
  final minPadding = 5.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 27.0
          ),
        ),
        centerTitle: true,
      ),
      body: const Center(
        child: (
          Text("Welcome")
        ),
      ),
      drawer: Drawer(
        child:   ListView(
          padding: const EdgeInsets.only(top: 2,bottom: 2),
          children: <Widget>[
              const SizedBox(
                width: 100,
                height: 100,
                child: DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: Center(
                        child: Text(
                            'Student Profile',
                          style:TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 23.0
                          ),
                        ),
                    ),
                ),
              ),
            ListTile(
              title: const Text("Register Student"),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => registerStudent()
                  )
                );
              },
            ),
            ListTile(
              title: const Text("Get Student"),
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GetStudent()
                    )
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
