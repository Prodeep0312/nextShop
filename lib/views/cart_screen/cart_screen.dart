import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nextshop/consts/consts.dart';
import 'package:nextshop/services/firestore_services.dart';
import 'package:nextshop/views/cart_screen/shipping_screen.dart';
import 'package:nextshop/widgets_common/loading_indicator.dart';

import '../../controller/cart_controller.dart';
import '../../widgets_common/button.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller=Get.put(cartController());
    return Scaffold(

      bottomNavigationBar: SizedBox(
        height: 60,
        width: context.screenWidth - 60,
        child: ourButton(
          color: redColor,
          onPress: (){
            Get.to(()=>ShippingDetails());
          },
          textColor: whiteColor,
          title: "Proceed to Shopping",
        ),
      ),
      backgroundColor:whiteColor,
      appBar:AppBar(
        automaticallyImplyLeading: false,
        title:"Shopping Cart".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body:StreamBuilder(
        stream: FirestoreServices.getCart(currentUser!.uid),

          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData)
            {
              return Center(
                child: loadingIndicator(),
              );
            }else if(snapshot.data!.docs.isEmpty){
            return Center(
              child: "Cart is empty".text.color(darkFontGrey).make(),
            );
          }
          else
            {

              var data=snapshot.data!.docs;
              controller.calculatedata(data);
              controller.productSnapshot=data;
              return Padding(

                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Expanded(child:ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (BuildContext context,int index){
                          return ListTile(
                            leading: Image.network("${data[index]['img']} ",
                            width: 80,
                            fit: BoxFit.cover,),
                            title: "${data[index]['title']} x ${data[index]['qty']}".text.fontFamily(semibold).size(16).make(),
                            subtitle: "${data[index]['tprice']}".numCurrency.text.fontFamily(semibold).size(14).color(redColor).make(),
                            trailing: Icon(Icons.delete,color: redColor,).onTap(() {
                              FirestoreServices.deleteDocument(data[index].id);

                            })
                          );
                        })
                   ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        "Total Price".text.color(darkFontGrey).fontFamily(semibold).make(),
                        Obx(()=>"${controller.TotalP.value}" .numCurrency.text.color(redColor).fontFamily(semibold).make()),
                      ],
                    ).box.color(Colors.amberAccent).width(context.screenWidth - 60).padding(EdgeInsets.all(12)).roundedSM.make(),
                    10.heightBox,


                  ],
                ),
              );
            }

          })
    );
  }
}
