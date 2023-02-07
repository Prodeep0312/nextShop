import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nextshop/consts/consts.dart';
import 'package:nextshop/consts/strings.dart';
import 'package:nextshop/consts/lists.dart';
import 'package:nextshop/views/auth_screen/signup_screen.dart';

import '../../controller/auth_controller.dart';
import '../../widgets_common/bg.dart';
import '../../widgets_common/appLogo.dart';
import '../../widgets_common/button.dart';
import '../../widgets_common/custom_textfield.dart';
import '../home_screen/home.dart';
class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return bgWidget(

      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            children: [
              (context.screenHeight * 0.1).heightBox,
              appLogoWidget(),
              10.heightBox,
              "Log in to $appname".text.fontFamily(bold).white.size(18.0).make(),
              15.heightBox,
              Obx(
                      ()=>
                 Column(
                  children: [
                    customTextField(title: email,hint: emailHint,isPass: false,controller:controller.emailController),
                    customTextField(title: password,hint: passwordHint,isPass: true,controller:controller.passwordController),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(onPressed: (){}, child:
                      forgetPass.text.make(),

                      ),


                    ),
                    5.heightBox,
                    controller.isloading.value?CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(redColor),
                    ):
                    ourButton(color: redColor,textColor: whiteColor,onPress:()async{
                      controller.isloading(true);

                      await controller.loginMethod(context: context).then((value){
                        if(value!=null){
                          VxToast.show(context, msg: loggedin);
                          Get.offAll(()=>Home());
                        }
                        else{
                          controller.isloading(false);
                        }
                      });
                    },title: login).box.width(context.screenWidth - 50.0).make(),

                    5.heightBox,
                    createNewAccount.text.color(fontGrey).make(),
                    5.heightBox,
                    ourButton(color:Colors.amber[100],textColor: redColor,onPress:(){
                      
                      Get.to(()=> SignUpScreen());
                    },title:signup).box.width(context.screenWidth - 50.0).make(),
                    10.heightBox,
                    loginWith.text.color(fontGrey).make(),
                    5.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(3, (index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundColor: lightGrey,
                          radius: 25.0,
                          child: Image.asset(socialIconList[index],width: 30.0,),
                        ),
                      )),
                    )
                  ],
                ).box.white.rounded.padding(EdgeInsets.all(16.0)).width(context.screenWidth - 70).shadowSm.make(),
              ),




            ],
          ),
        ),
      )
    );
  }
}
