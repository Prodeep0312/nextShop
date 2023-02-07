import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nextshop/consts/consts.dart';

Widget orderStatus({color,icon,title,showDone}){
  return ListTile(
    leading: Icon(
      icon,
      color: color,


    ).box.roundedSM.border(color: color).padding(EdgeInsets.all(4)).make(),

    trailing: SizedBox(
      height: 100,
        width: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          "$title".text.color(darkFontGrey).make(),
          showDone?Icon(
            icon,
            color: color,


          ):Container(),
        ],
      ),
    ),

  );
}
