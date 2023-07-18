// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:sqlite/NavBarScreens/tasks.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {

int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: const Tasks(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {  },
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index)
      {
        setState(() {
          currentIndex = index;
          print(index);
        });
      },
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.menu_book_rounded),
          label: "Tasks",),

        BottomNavigationBarItem(
          icon: Icon(Icons.check_circle_outline),
          label: "Done",),

        BottomNavigationBarItem(
          icon: Icon(Icons.archive_rounded),
          label: "Archived",),
      ]),
    );
  }
}