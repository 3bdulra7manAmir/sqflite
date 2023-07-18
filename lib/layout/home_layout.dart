// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
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

late Database database;

@override
  void initState() {
    createDatabase();
    super.initState();
  }

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
        onPressed: () async{ 
          // var name = await printName();
          // print(name);
          // try{
          //     var name = await printName();
          //     print(name);
          //     throw("error");
          // }catch(error){
          //   print("error $error");
          // }
          // printName().then((value) {
          //   print(value);
          //   print("osama");
          //   throw("errorrrrrrrrrrrrrrrrrr");
          // }).catchError((error){
          //   print("error $error");
          // });

          insertToDatabase();
        },
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

// Future<String> printName() async{
//   return "Ahmed Ali";
// }

void createDatabase() async{

await openDatabase(
  "todo.db",
  version: 1,
  onCreate: (database, version){
    print("database Created");

    database.execute('CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)').then((value){
      print("Table Created");
    }).catchError((error)
    {
      print("Error While Creating Database: $error");
    });

  },
  onOpen: (database){
    print("database Opened");
  },
  );
  
}

void insertToDatabase(){
  database.transaction((txn){
    txn.rawInsert('INSERT INTO tasks(title, date, time, status) VALUES("First Task","02222","891","new")').
    then((value){
      print("$value Inserted Successfully");
    }).catchError((error){
      print("Error while Inserting: $error");
    });
    throw("error"); //me
  },
  );
}



}