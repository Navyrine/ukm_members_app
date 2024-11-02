import 'package:flutter/material.dart';
import 'package:ukm_members_app/screens/add_student_screen.dart';
import 'package:ukm_members_app/widgets/students/students_list.dart';

class StudentScreen extends StatelessWidget {
  const StudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Students"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const AddStudentScreen(),
                ),
              );
            },
          )
        ],
      ),
      body: const StudentsList(),
    );
  }
}
