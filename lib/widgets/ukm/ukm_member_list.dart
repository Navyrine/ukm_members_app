import 'package:flutter/material.dart';
import 'package:ukm_members_app/widgets/ukm/ukm_member_item.dart';

class UkmMemberList extends StatelessWidget {
  const UkmMemberList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (ctx, index) => const UkmMemberItem(),
    );
  }
}
