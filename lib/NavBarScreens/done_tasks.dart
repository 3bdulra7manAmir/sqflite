import 'package:flutter/material.dart';

class DoneTasks extends StatelessWidget {
  const DoneTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Done Tasks", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),)
      );
  }
}