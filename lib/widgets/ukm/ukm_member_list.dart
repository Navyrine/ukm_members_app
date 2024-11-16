import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ukm_members_app/provider/ukm_members_provider.dart';
import 'package:ukm_members_app/widgets/ukm/ukm_member_item.dart';

class UkmMemberList extends ConsumerWidget {
  const UkmMemberList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ukmMemberValue = ref.watch(ukmMemberProvider);

    return ukmMemberValue.when(
      data: (memberData) {
        if (memberData.isEmpty) {
          return const Center(
            child: Text("No member available"),
          );
        }

        return Expanded(
          child: ListView.builder(
            itemCount: memberData.length,
            shrinkWrap: true,
            itemBuilder: (ctx, index) => Dismissible(
              key: ValueKey(memberData[index].id),
              child: UkmMemberItem(
                member: memberData[index],
              ),
              onDismissed: (direction) async {
                ref.read(ukmMemberProvider.notifier).deleteUkmMember(
                      memberData[index],
                    );
              },
            ),
          ),
        );
      },
      error: (error, stack) => Center(
        child: Text(
          error.toString(),
        ),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
