import 'package:flutter/material.dart';
import 'package:nextshop/consts/consts.dart';
Widget ourButton({onPress,color,textColor,String ? title}){

  return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: color,
        padding: EdgeInsets.all(12.0),

      ),
      onPressed: onPress,
      child: title!.text.color(textColor).fontFamily(bold).make());


}