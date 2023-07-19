// ignore_for_file: avoid_print, body_might_complete_normally_nullable

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlite/NavBarScreens/archived_tasks.dart';
import 'package:sqlite/NavBarScreens/tasks.dart';
import 'package:sqlite/shared/default_form_field.dart';
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
var scaffoldKey = GlobalKey<ScaffoldState>();
var formKey = GlobalKey<FormState>();
bool isOpened = true;
bool iconChange = true;
IconData icon = Icons.edit;

var titleController = TextEditingController();
var timeController = TextEditingController();
var dateController = TextEditingController();
//var 

@override
  void initState() {
    createDatabase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: appbarText[currentIndex],
        //title: Text(title[currentIndex]),
      ),
      body: screens[currentIndex],
      floatingActionButton: FloatingActionButton(
        child: Icon(icon),
        onPressed: (){ 
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

        //insertToDatabase();
        if(isOpened){
          scaffoldKey.currentState?.showBottomSheet((context) => 
            // Container(
            //   width: double.infinity,
            //   height: 120.0,
            //   color: Colors.red,
            // )
            Container(
              color: Colors.grey[200],
              padding: const EdgeInsets.all(15),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    defaultTextFormField(controller: titleController,
                    keyboardType: TextInputType.text,
                    hintText: "Enter Your name Plz",
                    labelText: "Your name!",
                    prefixIcon: Icons.title,
                    onTap: () {print("title tapped");},
                    ),
                    const SizedBox(height: 15,),
                    defaultTextFormField(controller: timeController,
                    keyboardType: TextInputType.datetime,
                    labelText: "Task time",
                    prefixIcon: Icons.watch_later_outlined,
                    // onTap: () {print("time tapped");},
                    onTap: () {showTimePicker(context: context, initialTime: TimeOfDay.now())
                    .then((value){
                      print(value?.format(context));
                      var time = value?.format(context);
                      timeController.text = time.toString();
                    });
                    },
                  ),
                  const SizedBox(height: 15,),
                  defaultTextFormField(controller: dateController,
                  keyboardType: TextInputType.datetime,
                  labelText: "Task time",
                  prefixIcon: Icons.calendar_month_outlined,
                  // onTap: () {print("time tapped");},
                  onTap: () {showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime.parse("2023-07-19"),)
                  .then((value){
                    print(value);
                    dateController.text = value.toString();
                  });
                  },
                ),
              
                  ],
                ),
              ),
            )
          );
        setState(() {
          icon = Icons.remove;
        });
        isOpened = false;
        }
        else{
          // scaffoldKey.currentState?.showBottomSheet((context) => 
          //   Container(
          //     width: 0,
          //     height: 0,
          //   )
          // );
          //orrrr
        Navigator.pop(context);
        setState(() {
                  icon = Icons.add;
        });
        isOpened = true;
        }
        
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
  database = await openDatabase(
    "todo.db",
    version: 1,
    onCreate: (database, version){
      print("database Created");
      database.execute('create table tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)')
      .then((value){
        print("Table Created");
      }).catchError((error)
      {
        print("Error While Creating Database: $error");
      });
  },
  onOpen: (database){
    print("database Opened");
  });
}


void insertToDatabase() async{
  await database.transaction((txn) async{
  txn.rawInsert("INSERT INTO tasks(title, date, time, status) VALUES('FirstgTask','022622','8691','neew')")
  .then((value){
      print("$value Inserted Successfully");
    }).catchError((error){
      print("Error while Inserting: $error");
    });
    //throw("error"); //me
  });
}



}