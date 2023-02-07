import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nextshop/consts/consts.dart';
import 'package:nextshop/controller/account_controller.dart';
import 'package:nextshop/widgets_common/button.dart';
import 'package:nextshop/widgets_common/custom_textfield.dart';

import '../../widgets_common/bg.dart';

class EditAccountScreen extends StatelessWidget {
  final dynamic data;
  const EditAccountScreen({Key? key,this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller =Get.find<AccountController>();

    return bgWidget(
      child:Scaffold(
        appBar: AppBar(),
        body: Obx(()=>
            Column(
              mainAxisSize:MainAxisSize.min ,
              children: [



                controller.accountImgPath.isEmpty?Image.asset(imgProfile2,width: 100.0,fit: BoxFit.cover,).box.roundedFull.clip(Clip.antiAlias).make() : Image.file(File(controller.accountImgPath.value),
                  width:100 ,
                  fit: BoxFit.cover,).box.roundedFull.clip(Clip.antiAlias).make() ,
                10.heightBox,
                ourButton(color: redColor,onPress: (){

                  Get.find<AccountController>().changeImage(context);
                },textColor: whiteColor,title: "Change"),
                Divider(),
                20.heightBox,
                customTextField(
                    controller: controller.nameController,
                    hint: nameHint,title: name,isPass:false),
                10.heightBox,
                customTextField(
                    controller: controller.oldpassController,
                    hint: passwordHint,title:oldPass,isPass:true),
                10.heightBox,
                customTextField(
                    controller: controller.newpassController,
                    hint: passwordHint,title:newPass,isPass:true),



                20.heightBox,
                controller.isloading.value ? CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(redColor),
                ):SizedBox(width:context.screenWidth - 60,
                    child: ourButton(color: redColor,onPress: ()async{
                      controller.isloading(true);
                      //if image is not selected
                      if(controller.accountImgPath.value.isNotEmpty){

                        await controller.uploadProfileImage();
                      }else
                        {
                          controller.accountImgLink=data['imageUrl'];
                        }
                      //if old password matches database
                      if(data['password']==controller.oldpassController.text)
                        {
                          await controller.changeAuthPassword(
                            email: data['email'],
                            password:controller.oldpassController.text,
                            newpassword: controller.newpassController.text,
                          );
                          await controller.updateProfile(
                            imgUrl: controller.accountImgLink,
                            name:controller.nameController.text,
                            password:controller.newpassController.text,

                          );
                          VxToast.show(context, msg:"Updated");
                        }else
                          {
                            VxToast.show(context, msg:"Wrong old passsword!!");
                            controller.isloading(false);
                          }



                    },textColor: whiteColor,title: "Save")),



              ],

            ).box.white.shadowSm.padding(EdgeInsets.all(16)).margin(EdgeInsets.only(top:50,left: 12,right: 12)).roundedSM.make(),
        ),

      ),
    );

  }
}

