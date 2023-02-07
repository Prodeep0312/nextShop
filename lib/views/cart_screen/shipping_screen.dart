import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nextshop/consts/consts.dart';
import 'package:flutter/material.dart';
import 'package:nextshop/views/cart_screen/payment_method.dart';
import 'package:nextshop/widgets_common/button.dart';

import '../../controller/cart_controller.dart';
import '../../widgets_common/custom_textfield.dart';

class ShippingDetails extends StatelessWidget {
  const ShippingDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller=Get.find<cartController>();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Shipping Info".text.color(darkFontGrey).fontFamily(semibold).make(),

      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: ourButton(
          onPress: (){
            if(controller.addressController.text.length>10){
              Get.to(()=>PaymentMethods());

            }else
              {
                VxToast.show(context, msg: "Please fill the form");
              }
          },
          color: redColor,
          textColor: whiteColor,
          title: "Continue",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            customTextField(hint: "Address",isPass: false,title: "Address",controller: controller.addressController),
            customTextField(hint: "City",isPass: false,title:"City" ,controller: controller.cityController),
            customTextField(hint: "State",isPass: false,title:"State" ,controller: controller.stateController),
            customTextField(hint: "Postal code",isPass: false,title:"Postal code",controller: controller.postalcodeController ),
            customTextField(hint: "Phone",isPass: false,title: "Phone",controller: controller.phoneController),
          ],
        ),
      ),

    );
  }
}
