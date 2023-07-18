import 'package:flutter/material.dart';

class Tasks extends StatelessWidget {
  const Tasks({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("New Task", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),)
      );
  }
}