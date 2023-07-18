// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:sqlite/NavBarScreens/archived_tasks.dart';
import 'package:sqlite/NavBarScreens/tasks.dart';

import '../NavBarScreens/done_tasks.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {

int currentIndex = 0;
List<Text> appbarText = const [Text("New Tasks"), Text("Done Tasks"), Text("Archived Tasks")];
//List<String> titles = ["New Tasks","Done Tasks","Archived Tasks"];
List<Widget> screens = const [Tasks(), DoneTasks(), ArchivedTasks()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appbarText[currentIndex],
        //title: Text(title[currentIndex]),
      ),
      body: screens[currentIndex],
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