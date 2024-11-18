import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ukm_members_app/models/ukm_member.dart';
import 'package:ukm_members_app/provider/students_provider.dart';
import 'package:ukm_members_app/provider/ukm_members_provider.dart';
import 'package:ukm_members_app/provider/ukm_provider.dart';

class UpdateUkmMemberScreen extends ConsumerStatefulWidget {
  const UpdateUkmMemberScreen({
    super.key,
    required this.member,
  });

  final UkmMember member;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _UpdateUkmMemberScreenState();
  }
}

class _UpdateUkmMemberScreenState extends ConsumerState<UpdateUkmMemberScreen> {
  String? _selectedStudentName;
  String? _selectedUkmName;
  bool isRegistered = false;

  void _saveForm() async {
     if (_selectedStudentName == null || _selectedUkmName == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Student name dan activity name must be filled"),
        ),
      );
    } else {
      final updateMember = UkmMember(
        id: widget.member.id,
        studentName: _selectedStudentName!,
        ukmName: _selectedUkmName!,
        isRegistered: isRegistered = true,
      );

      try {
        await ref.read(ukmMemberProvider.notifier).updateUkmMember(updateMember);
        Navigator.of(context).pop(updateMember);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed to update data: $e"),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(ukmMemberProvider).isLoading;
    final studentValueName = ref.watch(studentProvider);
    final ukmValueName = ref.watch(ukmProvider);

    studentValueName.whenData((student) {
      if (_selectedStudentName == null && student.isNotEmpty) {
        setState(() {
          _selectedStudentName = student.first.name;
        });
      }
    });

    ukmValueName.whenData((ukm) {
      if (_selectedUkmName == null && ukm.isNotEmpty) {
        setState(() {
          _selectedUkmName = ukm.first.name;
        });
      }
    });


    return Scaffold(
      appBar: AppBar(
        titleSpacing: -1,
        title: const Text("Add Member"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              DropdownButtonFormField(
                value: _selectedStudentName,
                decoration: const InputDecoration(labelText: "Student Name"),
                items: studentValueName.when(
                    data: (studentData) {
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
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField(
                value: _selectedUkmName,
                decoration: const InputDecoration(
                    labelText: "Student Activity Unit Name"),
                items: ukmValueName.when(
                    data: (studentData) {
                      return studentData.map((ukm) {
                        return DropdownMenuItem(
                          value: ukm.name,
                          child: Text(
                            ukm.name,
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
                    _selectedUkmName = value!;
                  });
                },
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: isLoading ? null : _saveForm,
                child: isLoading
                    ? const SizedBox(
                        height: 16,
                        width: 16,
                        child: CircularProgressIndicator(),
                      )
                    : const Text("Update"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
