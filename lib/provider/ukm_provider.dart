import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ukm_members_app/models/ukm.dart';
import 'package:http/http.dart' as http;

class UkmNotifier extends StateNotifier<AsyncValue<List<Ukm>>> {
  UkmNotifier() : super(const AsyncValue.loading()){
    loaddedUkms();
  }

  Future<void> addUkm(Ukm ukm) async {
    final url =
        Uri.parse("https://ukm-members-default-rtdb.firebaseio.com/ukm.json");

    try {
      state = const AsyncValue.loading();

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(
          {
            "name": ukm.name,
            "description": ukm.description,
          },
        ),
      );

      final Map<String, dynamic> resData = json.decode(response.body);

      if (response.statusCode > 400) {
        throw Exception("Failed to add data");
      }

      ukm = Ukm(
        id: resData["name"],
        name: ukm.name,
        description: ukm.description,
      );

      state = AsyncValue.data([...state.value ?? [], ukm]);
      await loaddedUkms();
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> loaddedUkms() async {
    final url =
        Uri.parse("https://ukm-members-default-rtdb.firebaseio.com/ukm.json");

    try {
      final response = await http.get(url);

      if (response.statusCode >= 400) {
        state = AsyncValue.error(
            "Failed to load data, try again later, ", StackTrace.current);
        return;
      }

      if (response.body == "null") {
        state = const AsyncValue.data([]);
        return;
      }

      final Map<String, dynamic> listData = json.decode(response.body);
      final List<Ukm> loaddedUkm = listData.entries.map((item) {
        return Ukm(
          id: item.key,
          name: item.value["name"],
          description: item.value["description"],
        );
      }).toList();

      state = AsyncValue.data(loaddedUkm);
    } catch (e) {
      state = AsyncValue.error("Something went wrong: $e", StackTrace.current);
    }
  }
}

final ukmProvider = StateNotifierProvider<UkmNotifier, AsyncValue<List<Ukm>>>(
    (ref) => UkmNotifier());
