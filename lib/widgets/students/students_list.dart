import 'package:flutter/material.dart';
import 'package:ukm_members_app/widgets/students/student_item.dart';

class StudentsList extends StatelessWidget {
  const StudentsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (ctx, index) => const StudentItem()
    );
  }
}
