import 'package:flutter/material.dart';
import 'package:ukm_members_app/screens/ukm/add_ukm_screen.dart';
import 'package:ukm_members_app/widgets/ukm/ukm_list.dart';

class UkmScreen extends StatelessWidget {
  const UkmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Activity Unit"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const AddUkmScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: const UkmList(),
    );
  }
}
