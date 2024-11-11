import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ukm_members_app/models/student.dart';
import 'package:http/http.dart' as http;

class StudentsNotifier extends StateNotifier<AsyncValue<List<Student>>> {
  StudentsNotifier() : super(const AsyncValue.loading()) {
    loadStudents();
  }

  Future<void> loadStudents() async {
    final url = Uri.parse(
        "https://ukm-members-default-rtdb.firebaseio.com/students.json");

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
      final List<Student> loaddedItems = listData.entries.map((item) {
        return Student(
          id: item.key,
          nim: item.value["nim"],
          name: item.value["name"],
          brith: DateTime.parse(item.value["birth"]),
          adress: item.value["address"],
        );
      }).toList();

      state = AsyncValue.data(loaddedItems);
    } catch (e) {
      state = AsyncValue.error("Something went wrong: $e", StackTrace.current);
    }
  }

  Future<void> addStudent(Student student) async {
    final url = Uri.parse(
        "https://ukm-members-default-rtdb.firebaseio.com/students.json");

    try {
      state = const AsyncValue.loading();

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(
          {
            "nim": student.nim,
            "name": student.name,
            "birth": student.brith.toIso8601String(),
            "address": student.adress
          },
        ),
      );

      final Map<String, dynamic> resData = json.decode(response.body);

      if (response.statusCode >= 400) {
        throw Exception("Failed to add data");
      }

      student = Student(
        id: resData["name"],
        nim: student.nim,
        name: student.name,
        brith: student.brith,
        adress: student.adress,
      );

      state = AsyncValue.data([...state.value ?? [], student]);
      await loadStudents();
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> updateData(Student student) async {
    final url = Uri.parse(
        "https://ukm-members-default-rtdb.firebaseio.com/students/${student.id}.json");

    try {
      state = const AsyncValue.loading();

      final response = await http.patch(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(
          {
            "nim": student.nim,
            "name": student.name,
            "birth": student.brith.toIso8601String(),
            "address": student.adress
          },
        ),
      );

      if (response.statusCode >= 400) {
        throw Exception("Failed to update data");
      }
    
      await loadStudents();
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> deleteData(Student student) async
  {
    final currentStudents = state.value ?? [];
    final removeStudentLocally = currentStudents.where((s) => s.id != student.id).toList();

    state = AsyncValue.data(removeStudentLocally);

    final url = Uri.parse(
        "https://ukm-members-default-rtdb.firebaseio.com/students/${student.id}.json");
    try {
      final response = await http.delete(url);

      if (response.statusCode >= 400) {
        throw Exception("Failed to remove data");
      }
      
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

final studentProvider =
    StateNotifierProvider<StudentsNotifier, AsyncValue<List<Student>>>(
        (ref) => StudentsNotifier());
