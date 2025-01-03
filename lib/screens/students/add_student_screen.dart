import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ukm_members_app/models/student.dart';
import 'package:ukm_members_app/provider/students_provider.dart';

class AddStudentScreen extends ConsumerStatefulWidget {
  const AddStudentScreen({super.key});

  @override
  ConsumerState<AddStudentScreen> createState() {
    return _AddStudentScreenState();
  }
}

class _AddStudentScreenState extends ConsumerState<AddStudentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nimController = TextEditingController();
  final _nameController = TextEditingController();
  DateTime? _selectedBirth;
  final _birthController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  void dispose() {
    _nimController.dispose();
    _nameController.dispose();
    _birthController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _datePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 100, now.month, now.day);
    final lastDate = DateTime(now.year, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    setState(() {
      _selectedBirth = pickedDate;
      _birthController.text = formatter.format(pickedDate!);
    });
  }

  void _saveForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final newStudent = Student(
        id: "",
        nim: _nimController.text,
        name: _nameController.text,
        brith: _selectedBirth!,
        adress: _addressController.text,
      );

      try {
      await ref.read(studentProvider.notifier).addStudent(newStudent);
          Navigator.of(context).pop(newStudent);
      } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Failed to save data: $e"),
            ),
          );
        
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isSending = ref.watch(studentProvider).isLoading;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Student"),
        titleSpacing: -1,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextFormField(
                controller: _nimController,
                maxLength: 10,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: const InputDecoration(
                  label: Text("NIM"),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "NIM must be filled";
                  }

                  if (value.trim().length < 10) {
                    return "NIM must be 10 character";
                  }
                  return null;
                },
                onSaved: (value) {
                  _nimController.text = value!;
                },
              ),
              const SizedBox(height: 17),
              TextFormField(
                controller: _nameController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: const InputDecoration(
                  label: Text("Name"),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Name must be filled";
                  }
                  return null;
                },
                onSaved: (value) {
                  _nameController.text = value!;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _birthController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: const InputDecoration(
                  label: Text("Birth"),
                ),
                readOnly: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Birth must be filled";
                  }
                  return null;
                },
                onTap: _datePicker,
                onSaved: (value) {
                  _birthController.text = value!;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _addressController,
                maxLines: 4,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: const InputDecoration(
                  label: Text("Address"),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Address must be filled";
                  }
                  return null;
                },
                onSaved: (value) {
                  _addressController.text = value!;
                },
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                  onPressed: isSending ? null : _saveForm,
                  child: isSending
                      ? const SizedBox(
                          height: 16,
                          width: 16,
                          child: CircularProgressIndicator(),
                        )
                      : const Text("Save"))
            ],
          ),
        ),
      ),
    );
  }
}
