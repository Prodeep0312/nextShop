import 'package:nextshop/consts/consts.dart';
import 'package:flutter/material.dart';

Widget loadingIndicator(){
  return CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation(redColor),
  );
}