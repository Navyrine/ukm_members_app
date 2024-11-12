import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ukm_members_app/provider/students_provider.dart';

class AddUkmMemberScreen extends ConsumerStatefulWidget {
  const AddUkmMemberScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _AddUkmMemberScreenState();
  }
}

class _AddUkmMemberScreenState extends ConsumerState<AddUkmMemberScreen> {
  String? _selectedStudentName;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final studentValueName = ref.watch(studentProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Member"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          child: Column(
            children: [
              DropdownButtonFormField(
                value: _selectedStudentName,
                onTap: () {
                  if (!_isLoading && studentValueName.isLoading) {
                    setState(() {
                      _isLoading = true;
                    });
                  }
                },
                items: studentValueName.when(
                    data: (studentData) {
                      if (_isLoading) {
                        setState(() {
                          _isLoading = false;
                        });
                      }
                      return studentData.map((student) {
                        return DropdownMenuItem(
                          value: student.name,
                          child: Text(
                            student.name,
                            style: const TextStyle(color: Colors.black),
                          ),
                        );
                      }).toList();
                    },
                    error: (error, stackTrace) => [
                          DropdownMenuItem(
                            value: null,
                            child: Text(
                              error.toString(),
                            ),
                          ),
                        ],
                    loading: () => [
                          const DropdownMenuItem(
                            value: null,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        ]),
                onChanged: (value) {
                  setState(() {
                    _selectedStudentName = value!;
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
