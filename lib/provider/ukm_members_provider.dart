import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:ukm_members_app/models/ukm_member.dart';

class UkmMembersNotifier extends StateNotifier<AsyncValue<List<UkmMember>>> {
  UkmMembersNotifier() : super(const AsyncValue.loading()) {
    loaddedUkmMember();
  }

  void setSearchQuery(String query) {

    final currentItem = state.value ?? [];

    if (query.isEmpty) {
      loaddedUkmMember();
      return;
    }

    final filteredMembers = currentItem
        .where(
          (member) =>
              member.studentName
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              member.ukmName.toLowerCase().contains(
                    query.toLowerCase(),
                  ),
        )
        .toList();
    
    state = AsyncValue.data(filteredMembers);
  }

  Future<void> addUkmMember(UkmMember member) async {
    final url = Uri.parse(
        "https://ukm-members-default-rtdb.firebaseio.com/ukm_member.json");

    try {
      state = const AsyncValue.loading();

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(
          {
            "studentName": member.studentName,
            "ukmName": member.ukmName,
            "isRegistered": member.isRegistered,
          },
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
        isRegistered: member.isRegistered,
      );
      state = AsyncValue.data([...state.value ?? [], member]);
      await loaddedUkmMember();
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> loaddedUkmMember() async {
    final url = Uri.parse(
        "https://ukm-members-default-rtdb.firebaseio.com/ukm_member.json");

    try {
      final response = await http.get(url);

      if (response.statusCode >= 400) {
        state = AsyncValue.error(
            "Failed to load data, try again later", StackTrace.current);
        return;
      }

      if (response.body == "null") {
        state = const AsyncValue.data([]);
        return;
      }

      final Map<String, dynamic> listData = json.decode(response.body);
      final List<UkmMember> loaddedMember = listData.entries.map((member) {
        return UkmMember(
          id: member.key,
          studentName: member.value["studentName"],
          ukmName: member.value["ukmName"],
          isRegistered: member.value["isRegistered"],
        );
      }).toList();

      state = AsyncValue.data(loaddedMember);
    } catch (e) {
      state = AsyncValue.error("Something went wrong: $e", StackTrace.current);
    }
  }

  Future<void> deleteUkmMember(UkmMember member) async {
    final currentItem = state.value ?? [];
    final removeUkmLocally =
        currentItem.where((m) => m.id != member.id).toList();

    state = AsyncValue.data(removeUkmLocally);

    final url = Uri.parse(
        "https://ukm-members-default-rtdb.firebaseio.com/ukm_member/${member.id}.json");

    try {
      final response = await http.delete(url);

      if (response.statusCode >= 400) {
        throw Exception("Failed to remove data");
      }
    } catch (e) {
      state = AsyncValue.error("Failed to remove data: $e", StackTrace.current);
    }
  }

  Future<void> updateUkmMember(UkmMember member) async {
    final url = Uri.parse(
        "https://ukm-members-default-rtdb.firebaseio.com/ukm_member/${member.id}.json");

    try {
      state = const AsyncValue.loading();
      
      final response = await http.patch(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "studentName": member.studentName,
          "ukmName": member.ukmName,
          "isRegistered": member.isRegistered
        }),
      );

      if (response.statusCode >= 400) {
        throw Exception("Failed to update data");
      }
      await loaddedUkmMember();
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

final ukmMemberProvider =
    StateNotifierProvider<UkmMembersNotifier, AsyncValue<List<UkmMember>>>(
        (ref) => UkmMembersNotifier());
