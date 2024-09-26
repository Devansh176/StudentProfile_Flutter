import 'package:flutter/material.dart';

class DeleteStudent extends StatefulWidget {
  const DeleteStudent({super.key});

  @override
  State<DeleteStudent> createState() => _DeleteStudentState();
}

class _DeleteStudentState extends State<DeleteStudent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Delete Student"),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: (){},
        ),
      ),
    );
  }
}
