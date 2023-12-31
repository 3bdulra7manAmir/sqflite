// ignore_for_file: avoid_print, body_might_complete_normally_nullable, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlite/shared/cubit/cubit.dart';
import 'package:sqlite/shared/default_formfield_dgn.dart';
import '../constance/const.dart';
import '../shared/cubit/states.dart';

class HomeLayout extends StatelessWidget {  
    HomeLayout({super.key});

late Database database;
var scaffoldKey = GlobalKey<ScaffoldState>();
var formKey = GlobalKey<FormState>();
bool isOpened = true;
bool iconChange = true;
IconData icon = Icons.edit;
var titleController = TextEditingController();
var timeController = TextEditingController();
var dateController = TextEditingController();



  


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          
        },
        builder: (context, state) {
          
          AppCubit cubit = AppCubit.get(context);
          
          return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: cubit.appbarText[cubit.currentIndex],
            //title: Text(title[currentIndex]),
          ),
          body: cubit.screens[cubit.currentIndex],
          //tasks.isEmpty ? const Center(child: CircularProgressIndicator()) : screens[currentIndex],
          floatingActionButton: FloatingActionButton(
            child: Icon(icon),
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
          
              //insertToDatabase();
              if (isOpened) {
                // if(formKey.currentState?.validate() != null && formKey.currentState!.validate()){
          
                // }
                scaffoldKey.currentState?.showBottomSheet(
                  (context) =>
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
                          defaultTextFormField(
                            controller: titleController,
                            keyboardType: TextInputType.text,
                            placeHolderText: "Enter Title Plz",
                            labelText: "Task Title",
                            prefixIcon: Icons.title,
                            onTap: () {
                              print("title tapped");
                            }, validate: (value) { 
                              if(value.toString().isEmpty){return 'Title must not be empty';}
                              return null;
                            },
                          ),
                          const SizedBox(height: 15,),
                          defaultTextFormField(
                            controller: timeController,
                            keyboardType: TextInputType.datetime,
                            labelText: "Task time",
                            prefixIcon: Icons.watch_later_outlined,
                            // onTap: () {print("time tapped");},
                            onTap: () {
                              showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now())
                                  .then((value) {
                                print(value?.format(context));
                                var time = value?.format(context);
                                timeController.text = time.toString();
                              });
                            }, validate: (value) {},
                          ),
                          const SizedBox(height: 15,),
                          defaultTextFormField(
                            controller: dateController,
                            keyboardType: TextInputType.datetime,
                            labelText: "Task Date",
                            prefixIcon: Icons.calendar_month_outlined,
                            //onTap: () {print("time tapped");},
                            onTap: (){
                              showDatePicker(
                                context: context,
                                firstDate: DateTime.parse("1400-01-01"),
                                lastDate: DateTime.now(),
                                initialDate: DateTime.now(),
                              ).then((value) {
                                var date = DateFormat.yMMM().format(value!);
                                print(date);
                                dateController.text = date.toString();
                              });
                            },
                            validate: (value) {  },
                          ),
                        ],
                      ),
                    ),
                  ),
                  elevation: 50,
                );
                // setState(() {
                //   icon = Icons.remove;
                // });
                isOpened = false;
              }
              else {
                // scaffoldKey.currentState?.showBottomSheet((context) =>
                //   Container(
                //     width: 0,
                //     height: 0,
                //   )
                // );
                //orrrr
                insertToDatabase(
                  date: dateController.text,
                  time: timeController.text,
                  title: titleController.text,
                ).then((value) {});
                Navigator.pop(context);
                // setState(() {
                //   icon = Icons.add;
                // });
                isOpened = true;
              }
            },
          ),
          bottomNavigationBar: BottomNavigationBar(
              onTap: (index) {
                // setState(() {
                //   currentIndex = index;
                //   print(index);
                // });
                AppCubit.get(context).changeIndex(index);
              },
              currentIndex: AppCubit.get(context).currentIndex,
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.menu_book_rounded),
                  label: "Tasks",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.check_circle_outline),
                  label: "Done",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.archive_rounded),
                  label: "Archived",
                ),
              ]),
        );
        },
      ),
    );
  }

// Future<String> printName() async{
//   return "Ahmed Ali";
// }

  void createDatabase() async {
    database = await openDatabase("todo.db", version: 1,
        onCreate: (database, version) {
      print("database Created");
      database
          .execute(
              'create table tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)')
          .then((value) {
        print("Table Created");
      }).catchError((error) {
        print("Error While Creating Database: $error");
      });
    }, onOpen: (database) {
      getDataFromDataBase(database).then((value){
        // setState(() {
        //   tasks = value;
        // });
        print(tasks);
      });
      print("database Opened");
    });
  }

  Future insertToDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
    return await database.transaction((txn) async {
      txn
          .rawInsert(
              "INSERT INTO tasks(title, date, time, status) VALUES('$title','$date','$time','new')")
          .then((value) {
        print("$value Inserted Successfully");
      }).catchError((error) {
        print("Error while Inserting: $error");
      });
      //throw("error"); //me
    });
  }

  Future<List<Map>> getDataFromDataBase(database) async{
    return await database.rawQuery("SELECT * FROM tasks");
    //print(tasks);
  }
}