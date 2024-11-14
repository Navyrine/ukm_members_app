import 'package:flutter/material.dart';
import 'package:ukm_members_app/models/ukm_member.dart';
import 'package:ukm_members_app/screens/ukm/update_ukm_member_screen.dart';

class UkmMemberItem extends StatelessWidget {
  const UkmMemberItem({
    super.key,
    required this.member,
  });

  final UkmMember member;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => UpdateUkmMemberScreen(member: member),
          ),
        );
      },
      child: Container(
        height: 100,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color.fromARGB(255, 137, 62, 158),
              Color.fromARGB(255, 248, 43, 115)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                member.studentName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Colors.white,
                    ),
              ),
              Text(
                member.ukmName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
