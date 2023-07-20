import 'package:flutter/material.dart';

//==========================================================================================//
Widget defaultButton({
  required String txt,
  required double width,
  //required double height,
  required Color color,
  required Function? Function() function,
}) => 

Container(
  width: width,
  //height: 10.0,
  color: color,
  
  child: MaterialButton(
  onPressed: function,
  child: Text(txt.toUpperCase(),
  style: const TextStyle(color: Colors.white),
  ),
  ),
);

//==========================================================================================//

