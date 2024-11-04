import 'package:flutter/material.dart';
import 'package:ukm_members_app/models/student.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ukm_members_app/provider/students_provider.dart';

class UpdateStudentScreen extends ConsumerStatefulWidget {
  const UpdateStudentScreen({
    super.key,
    required this.studentUpdate,
  });

  final Student studentUpdate;

  @override
  ConsumerState<UpdateStudentScreen> createState() =>
      _UpdateStudentScreenState();
}

class _UpdateStudentScreenState extends ConsumerState<UpdateStudentScreen> {
  final _formKey = GlobalKey<FormState>();
  var _enteredNim = "";
  var _enteredName = "";
  DateTime? _selectedBirth;
  final _birthController = TextEditingController();
  var _enteredAddress = "";

  @override
  void initState() {
    super.initState();
    _birthController.text = widget.studentUpdate.formattedDate;
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

  void _updateDataForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final updateStudent = Student(
        id: widget.studentUpdate.id,
        nim: _enteredNim,
        name: _enteredName,
        brith: _selectedBirth!,
        adress: _enteredAddress,
      );

      try {
      await ref.read(studentProvider.notifier).updateData(updateStudent);
      Navigator.of(context).pop(updateStudent);
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
    final isUpdate = ref.watch(studentProvider).isLoading;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Student"),
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
                initialValue: widget.studentUpdate.nim,
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
                  _enteredNim = value!;
                },
              ),
              const SizedBox(height: 17),
              TextFormField(
                initialValue: widget.studentUpdate.name,
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
                  _enteredName = value!;
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
                initialValue: widget.studentUpdate.adress,
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
                  _enteredAddress = value!;
                },
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: isUpdate ? null : _updateDataForm,
                child: isUpdate
                    ? const SizedBox(
                        height: 16,
                        width: 16,
                        child: CircularProgressIndicator(),
                      )
                    : const Text("Update"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
