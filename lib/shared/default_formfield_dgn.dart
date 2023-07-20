// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

Widget defaultTextFormField({
  required TextEditingController controller,
  required TextInputType keyboardType,
  String? placeHolderText,
  String? labelText,
  //required Function? Function() validate,
  required String? Function(String?) validate,
  Function? Function()? onFieldSubmitted,
  required IconData prefixIcon,
  IconData? suffix,
  Function? Function()? suffixPressed,
  Function? Function()? onTap,
  bool isPassword = false,
  isClickable = true,
  //InputDecoration? decoration,
}) =>

TextFormField(
  controller: controller,
  keyboardType: keyboardType,
  onFieldSubmitted: (value) {print(value);},
  //onChanged: ( (value)    {print(value);}),
  validator: validate,
  obscureText: isPassword,
  onTap: onTap,
  enabled: isClickable,

  decoration: InputDecoration
  (
    hintText: placeHolderText,
    labelText: labelText,
    prefixIcon: Icon(prefixIcon),
    suffixIcon: suffix != null ? IconButton(icon: Icon(suffix), onPressed: () { suffixPressed; },) : null, //or just Icon(suffix) directly
    border: const OutlineInputBorder(),
  ),
);