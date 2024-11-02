import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ukm_members_app/models/student.dart';
import 'package:http/http.dart' as http;

class AddStudentScreen extends StatefulWidget {
  const AddStudentScreen({super.key});

  @override
  State<AddStudentScreen> createState() {
    return _AddStudentScreenState();
  }
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  final _formKey = GlobalKey<FormState>();
  var _enteredNim = "";
  var _enteredName = "";
  DateTime? _selectedBirth;
  final _birthController = TextEditingController();
  var _enteredAddress = "";
  var _isSending = false;

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
      setState(() {
        _isSending = true;
      });

      final url = Uri.parse(
          "https://ukm-members-default-rtdb.firebaseio.com/students.json");
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(
          {
            "nim": _enteredNim,
            "name": _enteredName,
            "birth": _selectedBirth!.toIso8601String(),
            "address": _enteredAddress
          },
        ),
      );

      final Map<String, dynamic> resData = json.decode(response.body);

      if (!context.mounted) {
        return;
      }
      Navigator.of(context).pop(
        Student(
          id: resData["name"],
          nim: _enteredNim,
          name: _enteredName,
          brith: _selectedBirth!,
          adress: _enteredAddress,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  onPressed: _isSending ? null : _saveForm,
                  child: _isSending
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
