import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ukm_members_app/provider/students_provider.dart';
import 'package:ukm_members_app/widgets/students/student_item.dart';

class StudentsList extends ConsumerWidget {
  const StudentsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final studentValue = ref.watch(studentProvider);

    return studentValue.when(
      data: (students) {
        if (students.isEmpty) {
          return const Center(child: Text("No students available"));
        }
        return ListView.builder(
          itemCount: students.length,
          shrinkWrap: true,
          itemBuilder: (ctx, index) => Dismissible(
            key: ValueKey(students[index].id),
            child: StudentItem(
              studentData: students[index],
            ),
            onDismissed: (direction) async {
              await ref.read(studentProvider.notifier).deleteData(students[index]);
            },
          ),
        );
      },
      error: (error, stack) => Center(
        child: Text(
          error.toString(),
        ),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
