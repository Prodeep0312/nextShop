import 'package:flutter/services.dart';
import 'package:nextshop/consts/consts.dart';
import 'package:flutter/material.dart';
import 'package:nextshop/widgets_common/button.dart';

Widget exitDialog(context){

  return Dialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        "Confirm".text.color(darkFontGrey).fontFamily(bold).size(18).make(),
        Divider(),
        10.heightBox,
        "Are you sure you want to exit ?".text.size(16).fontFamily(semibold).color(darkFontGrey).make(),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ourButton(color: redColor,textColor: whiteColor,title: "Yes",onPress: (){SystemNavigator.pop();}),
            ourButton(color: redColor,textColor: whiteColor,title: "No",onPress: (){Navigator.pop(context);}),
          ],
        )

      ],
    ),
  ).box.color(lightGrey).roundedSM.padding(EdgeInsets.all(12)).make();
}