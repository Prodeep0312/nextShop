import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nextshop/consts/consts.dart';

import '../../consts/lists.dart';
import '../../controller/auth_controller.dart';
import '../../widgets_common/appLogo.dart';
import '../../widgets_common/bg.dart';
import '../../widgets_common/button.dart';
import '../../widgets_common/custom_textfield.dart';
import '../home_screen/home.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool? isCheck=false;
  var controller=Get.put(AuthController());
  //text controllers
  var nameController=TextEditingController();
  var passwordController=TextEditingController();
  var emailController=TextEditingController();
  var passwordretypeController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return bgWidget(

        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Center(
            child: Column(
              children: [
                (context.screenHeight * 0.1).heightBox,
                appLogoWidget(),
                10.heightBox,
                "Join the $appname".text.fontFamily(bold).white.size(18.0).make(),
                15.heightBox,
                Obx(
                        ()=>
                   Column(
                    children: [
                      customTextField(title: name,hint: nameHint,controller: nameController,isPass: false),
                      customTextField(title: email,hint: emailHint,controller: emailController,isPass: false),
                      customTextField(title: password,hint: passwordHint,controller: passwordController,isPass:true),
                      customTextField(title: retypePass,hint: retypepasswordHint,controller: passwordretypeController,isPass:true),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(onPressed: (){}, child:
                        forgetPass.text.make(),

                        ),


                      ),
                      5.heightBox,

                      Row(
                        children: [
                          Checkbox(
                            activeColor: redColor,
                              checkColor: whiteColor,
                              value: isCheck, onChanged: (newValue){
                                setState((){
                                  isCheck=newValue;

                                });




                          }),
                          10.widthBox,
                          Expanded(// to prevent pixel overflow
                            child: RichText(text: TextSpan(
                              children: [

                                TextSpan(text: "I agree to the " ,style: TextStyle(

                                  fontFamily: regular,
                                  color: fontGrey,

                                ) ),

                                TextSpan(text: termsAndCondn ,style: TextStyle(

                                  fontFamily: regular,
                                  color: redColor,

                                ) ),

                                TextSpan(text: " & " ,style: TextStyle(

                                  fontFamily: regular,
                                  color: fontGrey,

                                ) ),

                                TextSpan(text: privacyPolicy ,style: TextStyle(

                                  fontFamily: regular,
                                  color: redColor,

                                ) ),
                              ]
                            )),
                          )
                        ],
                      ),
                      10.heightBox,
                      //wrapping into gesture dectector of velocity x

                      controller.isloading.value ?CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(redColor),
                      ):ourButton(color:(isCheck==true)?redColor:lightGrey,textColor: whiteColor,onPress:()async{

                        if(isCheck!=false){
                          controller.isloading(true);
                          try{
                            await controller.signupMethod(context: context,email: emailController.text,password: passwordretypeController.text).then((value){
                              return controller.storeUserData(
                                  email: emailController.text,
                                  password: passwordretypeController.text,
                                name: nameController.text,
                              );
                            }
                            ).then((value){
                              VxToast.show(context, msg: loggedin);
                              Get.offAll(Home());
                            });



                          }catch(e){
                            auth.signOut();
                            VxToast.show(context, msg:e.toString());
                            controller.isloading(false);


                          }
                        }
                      },title:signup).box.width(context.screenWidth - 50.0).make(),
                      10.heightBox,
                      RichText(text: TextSpan(
                        children: [
                          TextSpan(
                            text: accnt,
                            style: TextStyle(
                              fontFamily: regular,
                              color: fontGrey,
                            )
                          ),

                          TextSpan(
                              text: login,
                              style: TextStyle(
                                fontFamily: regular,
                                color: redColor,
                              )
                          ),

                        ]
                      )).onTap(() {
                        Get.back();
                      })



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
