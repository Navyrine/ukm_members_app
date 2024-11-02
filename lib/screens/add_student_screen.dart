import 'package:flutter/material.dart';

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
  var _enteredBirth = "";
  var _enteredAddress = "";

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print(_enteredNim);
      print(_enteredName);
      print(_enteredBirth);
      print(_enteredAddress);
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
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: const InputDecoration(
                  label: Text("Birth"),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Birth must be filled";
                  }
                  return null;
                },
                onSaved: (value) {
                  _enteredBirth = value!;
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
                onPressed: _saveForm,
                child: const Text("Save"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
