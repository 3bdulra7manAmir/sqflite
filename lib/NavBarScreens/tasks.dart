import 'package:flutter/material.dart';
import 'package:sqlite/constance/const.dart';

import '../shared/default_task_dgn.dart';

class Tasks extends StatelessWidget {
  const Tasks({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(itemBuilder: (context, index) => buildTaskItem(tasks[index]), separatorBuilder: (context, index) => Padding(
      padding: const EdgeInsetsDirectional.only(start: 20),
      child: Container(
        width: double.infinity,
        height: 1,
        color: Colors.grey[300],
      ),
    ), itemCount: tasks.length); 
  
  }
}