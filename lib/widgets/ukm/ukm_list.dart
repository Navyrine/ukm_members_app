import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ukm_members_app/provider/ukm_provider.dart';
import 'package:ukm_members_app/widgets/ukm/ukm_item.dart';

class UkmList extends ConsumerWidget {
  const UkmList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ukmValue = ref.watch(ukmProvider);

    return ukmValue.when(
      data: (ukm) {
        if (ukm.isEmpty) {
          return const Center(child: Text("No ukm available"));
        }

        return ListView.builder(
          itemCount: ukm.length,
          shrinkWrap: true,
          itemBuilder: (ctx, index) => Dismissible(
            key: ValueKey(ukm[index].id),
            child: UkmItem(
              ukm: ukm[index],
            ),
            onDismissed: (direction) async {
              await ref.read(ukmProvider.notifier).deleteUkm(ukm[index]);
            },
          ),
        );
      },
      error: (error, stack) => Center(
        child: Text(error.toString()),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
