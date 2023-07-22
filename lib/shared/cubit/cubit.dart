import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqlite/shared/cubit/states.dart';

import '../../NavBarScreens/archived_tasks.dart';
import '../../NavBarScreens/done_tasks.dart';
import '../../NavBarScreens/tasks.dart';

class AppCubit extends Cubit<AppStates>{
AppCubit() : super(AppInitalState());

  static AppCubit get(context) => BlocProvider.of(context);

int currentIndex = 0;
List<Text> appbarText = const [Text("New Tasks"), Text("Done Tasks"), Text("Archived Tasks")];
//List<String> titles = ["New Tasks","Done Tasks","Archived Tasks"];
List<Widget> screens = const [Tasks(), DoneTasks(), ArchivedTasks()];

void changeIndex(int index){
currentIndex = index;
emit(AppChangeBottomNavBarState());
}

}