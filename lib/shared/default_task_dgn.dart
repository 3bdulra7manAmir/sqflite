import 'package:flutter/material.dart';

//Map tasksTitle = tasks;

Widget buildTaskItem(Map model) =>
Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 40,
            child: Text("02:00 PM"),
          ),
          const SizedBox(width: 15,),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("${model['title']}", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              Text("${model['time']}", style: const TextStyle(color: Colors.grey),),
              Text("${model['date']}", style: const TextStyle(color: Colors.grey),),
    
            ],
          )
        ],
      ),
    );


