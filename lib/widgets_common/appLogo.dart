import 'package:nextshop/consts/consts.dart';
import 'package:flutter/material.dart';

Widget appLogoWidget(){
  //using velocityx here
  return Image.asset(icAppLogo).box.white.size(77.0, 77.0).padding(EdgeInsets.all(8.0)).rounded.make();
}