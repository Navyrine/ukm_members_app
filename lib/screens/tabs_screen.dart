import 'package:flutter/material.dart';
import 'package:ukm_members_app/screens/home_screen.dart';
import 'package:ukm_members_app/screens/students/student_screen.dart';
import 'package:ukm_members_app/screens/ukm/ukm_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedScreenIndex = 0;

  final screens = [
    const HomeScreen(),
    const StudentScreen(),
    const UkmScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: screens[_selectedScreenIndex],
        bottomNavigationBar: Container(
          height: 80,
          margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(61.21),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  offset: const Offset(0, 4),
                  blurRadius: 30,
                )
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                enableFeedback: false,
                icon: _selectedScreenIndex == 0
                    ? const Icon(
                        Icons.home_filled,
                        color: Colors.blue,
                        size: 35,
                      )
                    : const Icon(
                        Icons.home_filled,
                        color: Color.fromARGB(255, 123, 123, 125),
                        size: 35,
                      ),
                onPressed: () {
                  setState(() {
                    _selectedScreenIndex = 0;
                  });
                },
              ),
              IconButton(
                enableFeedback: false,
                icon: _selectedScreenIndex == 1
                    ? const Icon(
                        Icons.person,
                        color: Colors.blue,
                        size: 35,
                      )
                    : const Icon(
                        Icons.person,
                        color: Color.fromARGB(225, 123, 123, 125),
                        size: 35,
                      ),
                onPressed: () {
                  setState(() {
                    _selectedScreenIndex = 1;
                  });
                },
              ),
              IconButton(
                enableFeedback: false,
                icon: _selectedScreenIndex == 2
                    ? const Icon(
                        Icons.list,
                        color: Colors.blue,
                        size: 35,
                      )
                    : const Icon(
                        Icons.list,
                        color: Color.fromARGB(225, 123, 123, 125),
                        size: 35,
                      ),
                onPressed: () {
                  setState(() {
                    _selectedScreenIndex = 2;
                  });
                },
              )
            ],
          ),
        ));
  }
}
