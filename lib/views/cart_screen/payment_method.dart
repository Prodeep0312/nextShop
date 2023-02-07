import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nextshop/consts/consts.dart';
import 'package:flutter/material.dart';
import 'package:nextshop/consts/lists.dart';
import 'package:nextshop/widgets_common/loading_indicator.dart';

import '../../controller/cart_controller.dart';
import '../../widgets_common/button.dart';
import '../home_screen/home.dart';
class PaymentMethods extends StatelessWidget {
  const PaymentMethods({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var controller=Get.find<cartController>();
    return Obx(()=>
       Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          title: "Choose Payment Method".text.color(darkFontGrey).fontFamily(semibold).make(),

        ),
        bottomNavigationBar: SizedBox(
          height: 60,
          child: controller.placingOrder.value?Center(
            child: loadingIndicator(),
          ):ourButton(
            onPress: ()async{
              await controller.placeMyOrder(
                orderPaymentMethod: paymentMethods[controller.paymentIndex.value],
                totalAmount: controller.TotalP.value
              );
              await controller.clearCart();
              VxToast.show(context, msg:"Order placed successfully!");
              Get.offAll(Home());
            },
            color: redColor,
            textColor: whiteColor,
            title: "Place Order",
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Obx(()=>
           Column(

              children:List.generate(paymentMethodsImg.length, (index){
                return GestureDetector(
                  onTap: (){
                    controller.changePaymentIndex(index);
                  },
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    margin: EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: controller.paymentIndex.value==index?redColor:Colors.transparent,
                        width: 4,

                      )

                    ),
                    child:Stack(
                      alignment: Alignment.topRight,

                      children:[
                        Image.asset(paymentMethodsImg[index],
                          width: double.infinity,
                          height: 100,
                          colorBlendMode:controller.paymentIndex.value==index?BlendMode.color: BlendMode.darken,
                          color: controller.paymentIndex.value==index?Colors.transparent:Colors.black.withOpacity(0.4),
                          fit: BoxFit.cover,),

                        controller.paymentIndex.value==index?Transform.scale(
                          scale: 1.3,
                          child: Checkbox(
                            activeColor: Colors.green,
                              shape:RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              value:true, onChanged:(value){

                          }),
                        ):
                            Container(),
                        Positioned(
                            bottom: 0,right: 10,
                            child: paymentMethods[index].text.white.fontFamily(semibold).size(16).make())
                      ],
                    ) ,
                  ),
                );
              }),
            ),
          ),
        ),

      ),
    );
  }
}
