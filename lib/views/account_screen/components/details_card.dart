import 'package:flutter/material.dart';
import 'package:nextshop/consts/consts.dart';
import 'package:nextshop/widgets_common/bg.dart';

Widget detailsCard({width,String? count,String? title}){

  return  Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      "$count".text.fontFamily(bold).size(16).color(darkFontGrey).make(),
      5.heightBox,
      "$title".text.color(darkFontGrey).make(),
    ],
  ).box.white.roundedSM.width(width).height(50.0).padding(EdgeInsets.all(4.0)).make();
}