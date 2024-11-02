import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

class Student {
  const Student({
    required this.id,
    required this.nim,
    required this.name,
    required this.brith,
    required this.adress,
  });

  final String id;
  final String nim;
  final String name;
  final DateTime brith;
  final String adress;

  String get formattedDate{
    return formatter.format(brith);
  } 
}