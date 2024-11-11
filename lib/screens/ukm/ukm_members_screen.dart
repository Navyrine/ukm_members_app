import 'package:flutter/material.dart';
import 'package:ukm_members_app/widgets/ukm/ukm_member_list.dart';

class UkmMembersScreen extends StatelessWidget {
  const UkmMembersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Members"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {},
          ),
        ],
      ),
      body: const UkmMemberList(),
    );
  }
}