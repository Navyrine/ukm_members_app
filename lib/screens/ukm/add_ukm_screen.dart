import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ukm_members_app/models/ukm.dart';
import 'package:ukm_members_app/provider/ukm_provider.dart';

class AddUkmScreen extends ConsumerStatefulWidget {
  const AddUkmScreen({super.key});

  @override
  ConsumerState<AddUkmScreen> createState() {
    return _AddUkmScreenState();
  }
}

class _AddUkmScreenState extends ConsumerState<AddUkmScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _saveForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final newUkmData = Ukm(
        id: "",
        name: _nameController.text,
        description: _descriptionController.text,
      );

      try {
        await ref.read(ukmProvider.notifier).addUkm(newUkmData);
        Navigator.of(context).pop(newUkmData);
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
    final isSending = ref.watch(ukmProvider).isLoading;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: -1,
        title: const Text("Add Student Activity Unit"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: const InputDecoration(label: Text("Name")),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Name must be filled";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  _nameController.text = newValue!;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: const InputDecoration(label: Text("Description")),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Description must be filled";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  _descriptionController.text = newValue!;
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
                    : const Text("Save"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
