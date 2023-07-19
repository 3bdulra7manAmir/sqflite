import 'package:flutter/material.dart';

Widget defaultTextFormField({
  required TextEditingController controller,
  required TextInputType keyboardType,
  //required Function? Function() onFieldSubmitted,
  Function? Function()? suffixPressed,
  Function? Function()? onTap,
  //required Function? Function() validate,
  //required InputDecoration decoration,
  String? hintText,
  String? labelText,
  required IconData prefixIcon,
  IconData? suffix,
  bool isPassword = false,
  isClickable = true,
}) =>

TextFormField(
  controller: controller,
  keyboardType: keyboardType,
  //onFieldSubmitted: (value) {print(value);},
  //onChanged: ( (value)      {print(value);}),
  //validator: validate,
  obscureText: isPassword,
  onTap: onTap,
  enabled: isClickable,
  decoration: InputDecoration(
  hintText: hintText,
  labelText: labelText,
  prefixIcon: Icon(prefixIcon),
  suffixIcon: suffix != null ? IconButton(icon: Icon(suffix), onPressed: () { suffixPressed; },) : null, //or just Icon(suffix) directly
  border: const OutlineInputBorder(),
    ),
);

//==========================================================================================//

