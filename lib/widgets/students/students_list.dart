import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ukm_members_app/models/student.dart';
import 'package:ukm_members_app/widgets/students/student_item.dart';
import 'package:http/http.dart' as http;

class StudentsList extends StatefulWidget {
  const StudentsList({super.key});

  @override
  State<StudentsList> createState() => _StudentsListState();
}

class _StudentsListState extends State<StudentsList> {
  List<Student> _student = [];
  String? _error;
  var _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _loadItems() async {
    final url = Uri.parse(
        "https://ukm-members-default-rtdb.firebaseio.com/students.json");

    try {
      final response = await http.get(url);

      if (response.statusCode >= 400) {
        setState(() {
          _isLoading = false;
          _error = "Failed to load data, try again later";
        });
      }

      if (response.body == "null") {
        setState(() {
          _isLoading = false;
        });
        return;
      }

      final Map<String, dynamic> listData = json.decode(response.body);
      final List<Student> loaddedItems = [];

      for (final item in listData.entries) {
        loaddedItems.add(
          Student(
            id: item.key,
            nim: item.value["nim"],
            name: item.value["name"],
            brith: DateTime.parse(item.value["birth"]),
            adress: item.value["address"],
          ),
        );
      }

      setState(() {
        _isLoading = false;
        _student = loaddedItems;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _error = "Something went wrong: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(child: Text(_error!));
    }

    return ListView.builder(
        itemCount: _student.length,
        shrinkWrap: true,
        itemBuilder: (ctx, index) => StudentItem(studentData: _student[index]));
  }
}
