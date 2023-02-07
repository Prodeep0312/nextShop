import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nextshop/consts/consts.dart';
import 'package:nextshop/views/home_screen/home.dart';
import 'package:nextshop/views/home_screen/home_screen.dart';

import '../../widgets_common/appLogo.dart';
import '../auth_screen/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //creating a method to change screen
  changeScreen(){
    Future.delayed(Duration(seconds: 3),(){
    //using getx
      //Get.to(()=>LoginScreen());
    auth.authStateChanges().listen((User? user) {
      if(user==null && mounted){
        Get.to(()=>LoginScreen());
      }
      else
        {
          Get.to(()=>Home());
        }
    });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    changeScreen();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: redColor,
      body: Center(
        child: Column(
          children: [
            Align(
                alignment: Alignment.topLeft,
                child: Image.asset(icSplashBg,width: 300,)),
            20.heightBox,
            appLogoWidget(),
            10.heightBox,
            appname.text.fontFamily(bold).size(22.0).white.make(),
            5.heightBox,
            appversion.text.white.make(),
            Spacer(),
            credits.text.white.fontFamily(semibold).make(),
            30.heightBox,

            //splash screen ui using velocity x
          ],
        ),
      ),
    );
  }
}
