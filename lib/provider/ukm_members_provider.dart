import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:ukm_members_app/models/ukm_member.dart';

class UkmMembersNotifier extends StateNotifier<AsyncValue<List<UkmMember>>> {
  UkmMembersNotifier() : super(const AsyncData([]));

  Future<void> addUkmMember(UkmMember member) async {
    final url = Uri.parse(
        "https://ukm-members-default-rtdb.firebaseio.com/ukm_member.json");

    try {
      state = const AsyncValue.loading();

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(
          {"studentName": member.studentName, "ukmName": member.ukmName},
        ),
      );

      final Map<String, dynamic> resData = json.decode(response.body);

      if (response.statusCode >= 400) {
        throw Exception("Failed to add data");
      }

      member = UkmMember(
        id: resData["name"],
        studentName: member.studentName,
        ukmName: member.ukmName,
      );
      state = AsyncValue.data([...state.value ?? [], member]);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

final ukmMemberProvider =
    StateNotifierProvider<UkmMembersNotifier, AsyncValue<List<UkmMember>>>(
        (ref) => UkmMembersNotifier());
