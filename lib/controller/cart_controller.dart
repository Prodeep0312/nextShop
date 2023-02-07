import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:nextshop/consts/consts.dart';
import 'package:flutter/material.dart';
import 'package:nextshop/controller/home_controller.dart';
class cartController extends GetxController{
  var TotalP=0.obs;

  //text controllers for shipping
  var addressController=TextEditingController();
  var cityController=TextEditingController();
  var stateController=TextEditingController();
  var postalcodeController=TextEditingController();
  var phoneController=TextEditingController();

  late dynamic productSnapshot;
  var products=[];
  var  placingOrder=false.obs;

  var paymentIndex=0.obs;
  calculatedata(data)
  {TotalP.value=0;
    for(var i=0;i<data.length;i++)
      {
        TotalP.value+=int.parse(data[i]['tprice'].toString());
      }
  }

  changePaymentIndex(index){
    paymentIndex.value=index;

  }
  placeMyOrder({required orderPaymentMethod,required totalAmount})async{
    placingOrder(true);

    await getProductDetails();
    await firestore
        .collection(ordersCollection).doc().set({
        'order_code':'23397839393',
        'order_date':FieldValue.serverTimestamp(),
      'order_by':currentUser!.uid,
      'order_by_name':Get.find<HomeController>().username,
      'order_by_address':addressController.text,
      'order_by_email':currentUser!.email,
      'order_by_state':stateController.text,
      'order_by_city':cityController.text,
      'order_by_phone':phoneController.text,
      'order_by_postalcode':postalcodeController.text,
      'shipping_method':"Home Delivery",
      'payment_method':orderPaymentMethod,
      'order_placed':true,
      'order_confirmed':false,
      'order_delivered':false,
      'order_on_delivery':false,
      'total_amount':totalAmount,
      'orders':FieldValue.arrayUnion(products)


    });
placingOrder(false);
  }

  getProductDetails(){
    products.clear();

    for(var i=0;i<productSnapshot.length;i++){

      products.add({

        'color':productSnapshot[i]['color'],
        'img':productSnapshot[i]['img'],
        'qty':productSnapshot[i]['qty'],
        'vendor_id':productSnapshot[i]['vendor_id'],
        'tprice':productSnapshot[i]['tprice'],
        'title':productSnapshot[i]['title'],

      });
    }

  }

  clearCart(){
    for(var i=0;i<productSnapshot.length;i++)
      {

        firestore.collection(cartCollection).doc(productSnapshot[i].id).delete();

      }
  }
}