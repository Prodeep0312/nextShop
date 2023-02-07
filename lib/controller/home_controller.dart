import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:nextshop/consts/consts.dart';


class HomeController extends GetxController{

  @override
  void onInit() {
    getuserName();
    super.onInit();
  }
  var currentNavIndex=0.obs;
  var username= '';
  var searchController=TextEditingController();
   getuserName()async{
     var n=await firestore.collection(userCollection).where('id',isEqualTo: currentUser!.uid).get().then((value) {
       if(value.docs.isNotEmpty){
         return value.docs.single['name'];
       }
     }
     );

     username=n;


   }


}