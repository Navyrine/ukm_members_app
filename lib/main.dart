import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ukm_members_app/screens/student_screen.dart';

final theme = ThemeData().copyWith(
  textTheme: GoogleFonts.robotoTextTheme().copyWith(
    titleLarge: GoogleFonts.roboto(
      fontWeight: FontWeight.bold
    ),
    titleMedium: GoogleFonts.roboto(
      fontWeight: FontWeight.bold
    ),
    titleSmall: GoogleFonts.roboto(
      fontWeight: FontWeight.bold
    )
  )
);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UKM MEMBERS',
      theme: theme,
      home: const StudentScreen(),
    );
  }
}
