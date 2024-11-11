import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ukm_members_app/models/ukm.dart';
import 'package:ukm_members_app/provider/ukm_provider.dart';

class UpdateUkmScreen extends ConsumerStatefulWidget
{
  const UpdateUkmScreen({super.key, required this.ukmpdate,});

  final Ukm ukmpdate;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _UpdateUkmScreenState();
  }
}

class _UpdateUkmScreenState extends ConsumerState<UpdateUkmScreen>
{
  final _formKey = GlobalKey<FormState>();
  final _nameUpdateController = TextEditingController();
  final _descriptionUpdateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameUpdateController.text = widget.ukmpdate.name;
    _descriptionUpdateController.text = widget.ukmpdate.description;
  }

  @override
  void dispose() {
    _nameUpdateController.dispose();
    _descriptionUpdateController.dispose();
    super.dispose();
  }

  void _updateForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final updateUkmData = Ukm(
        id: widget.ukmpdate.id,
        name: _nameUpdateController.text,
        description: _descriptionUpdateController.text,
      );

      try {
        await ref.read(ukmProvider.notifier).updateUkm(updateUkmData);
        Navigator.of(context).pop(updateUkmData);
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
        title: const Text("Update Student Activity Unit"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextFormField(
                controller: _nameUpdateController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: const InputDecoration(label: Text("Name")),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Name must be filled";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  _nameUpdateController.text = newValue!;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _descriptionUpdateController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: const InputDecoration(label: Text("Description")),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Description must be filled";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  _descriptionUpdateController.text = newValue!;
                },
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: isSending ? null : _updateForm,
                child: isSending
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