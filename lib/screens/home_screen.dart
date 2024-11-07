import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 70),
            Container(
              alignment: Alignment.center,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Image.asset(
                width: double.infinity,
                "assets/animation/ukm_app_home.gif",
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 15),
            Text("Discover new opportunities, join exciting activities, and share inspiration with fellow Student Activity Unit (UKM) members. Everything is easier and more fun at UKM MEMBERS",
            style: Theme.of(context).textTheme.bodyMedium,
            )
          ],
        ),
      ),
    );
  }
}
