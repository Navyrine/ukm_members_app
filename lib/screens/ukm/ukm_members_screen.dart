import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ukm_members_app/provider/ukm_members_provider.dart';
import 'package:ukm_members_app/screens/ukm/add_ukm_member_screen.dart';
import 'package:ukm_members_app/widgets/ukm/ukm_member_list.dart';

class UkmMembersScreen extends ConsumerWidget {
  const UkmMembersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Members"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const AddUkmMemberScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Expanded(
        child: Column(
          children: [
             Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(18)),
                      prefixIcon: const Icon(Icons.search),
                      hintText: "Search"),
                      onChanged: (value) {
                        ref.read(ukmMemberProvider.notifier).setSearchQuery(value);
                      },
                ),
              ),
              const UkmMemberList()
          ],
        ),
      ),
    );
  }
}
