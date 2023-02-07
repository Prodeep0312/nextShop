import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nextshop/consts/consts.dart';
import 'package:nextshop/views/category_screen/category_details.dart';

Widget featuredButton({String ? title,icon}){
  return Row(
    children: [
      Image.asset(icon,width: 60.0,fit: BoxFit.fill,),
      10.widthBox,
      title!.text.fontFamily(semibold).color(darkFontGrey).make(),

    ],
  ).box.margin(EdgeInsets.symmetric(horizontal: 4.0)).width(200).roundedSM.padding(EdgeInsets.all(4.0)).outerShadowSm.make().onTap(() {
    Get.to(()=>CategoryDetails(title: title));
  });
}