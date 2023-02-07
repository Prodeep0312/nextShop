
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nextshop/consts/consts.dart';

import '../models/category_model.dart';

class ProductController extends GetxController{
  var quantity=0.obs;
  var colorIndex=0.obs;
  var totalPrice=0.obs;

  var subcat=[];
  var isFav=false.obs;
  getSubCategories(title)async{
    subcat.clear();
    var data=await rootBundle.loadString("lib/services/category_model.json");
    var decoded=categoryModelFromJson(data);
    var s=decoded.categories.where((element) => element.name==title).toList();

    for(var e in s[0].subcategory ){
      subcat.add(e);
    }
  }

  changeColorIndex(index){
    colorIndex.value=index;
  }
  increaseQuantity(totalQuantity){
    if(quantity.value<totalQuantity){
      quantity.value++;
    }

  }
  decreaseQuantity(){
    if(quantity.value >0){
      quantity.value--;
    }

  }
  calculateTotalPrice(price){
    totalPrice.value= price * quantity.value;
  }
addToCart({
    title,img,sellername,tprice,color,qty,context,vendorID
})async

{

  await firestore.collection(cartCollection).doc().set({
  'title':title,
  'img':img,
  'sellername':sellername,
  'tprice':tprice,
  'color':color,
    'vendor_id':vendorID,
  'qty':qty,
  'added_by':currentUser!.uid,
  }).catchError((e){
    VxToast.show(context, msg:e.toString());
  });




}

resetValues(){
    quantity.value=0;
    colorIndex.value=0;
    totalPrice.value=0;
}
addtoWishlist(docId,context)async{

    await firestore.collection(productsCollection).doc(docId).set({
      'p_wishlist':FieldValue.arrayUnion([currentUser!.uid])
    },
    SetOptions(merge: true));
    isFav(true);
    VxToast.show(context, msg:"added to wishlist");
}


  removefromWishlist(docId,context)async{

    await firestore.collection(productsCollection).doc(docId).set({
      'p_wishlist':FieldValue.arrayRemove([currentUser!.uid])
    },
        SetOptions(merge: true));
    isFav(false);
    VxToast.show(context, msg:"removed from wishlist");
  }

  checkifFav(data) async{

    if(data['p_wishlist'].contains(currentUser!.uid)){
      isFav(true);
    }
    else
      {
        isFav(false);
      }

  }

}