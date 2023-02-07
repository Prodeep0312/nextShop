import '../consts/firebase_consts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nextshop/consts/consts.dart';
//get users data
class FirestoreServices{
  static getUser(uid){
    return firestore.collection(userCollection).where('id',isEqualTo: uid).snapshots();
  }

  //get products according to category
static getProducts(category){
  return firestore.collection(productsCollection).where('p_category',isEqualTo: category).snapshots();
}

  static getSubCategoryProducts(title){
    return firestore.collection(productsCollection).where('p_subcategory',isEqualTo: title).snapshots();
  }
//get cart
static getCart(uid){
    return firestore.collection(cartCollection).where('added_by',isEqualTo: uid).snapshots();
}

//delete document
static deleteDocument(docId){
    return firestore.collection(cartCollection).doc(docId).delete();
}

//get all messages
static getChatMessages(docId){
    return firestore.collection(chatsCollection).doc(docId).collection(messagesCollection).orderBy('created_on',descending: false).snapshots();
}


static getAllOrders()
{
  return firestore.collection(ordersCollection).where('order_by',isEqualTo: currentUser!.uid).snapshots();

}

  static getWishlists()
  {
    return firestore.collection(productsCollection).where('p_wishlist',arrayContains:currentUser!.uid ).snapshots();

  }

  static getAllMessages()
  {
    return firestore.collection(chatsCollection).where('fromId',isEqualTo: currentUser!.uid).snapshots();
  }


  static getCount()async{
    var res=await Future.wait([
      firestore.collection(cartCollection).where('added_by',isEqualTo: currentUser!.uid).get().then((value) {
        return value.docs.length;
      }),

     firestore.collection(productsCollection).where('p_wishlist',arrayContains:currentUser!.uid ).get().then((value) {
        return value.docs.length;
      }),

      firestore.collection(ordersCollection).where('order_by',isEqualTo: currentUser!.uid).get().then((value) {
        return value.docs.length;
      })
    ]);
      return res;
  }

  static allProducts(){
    return firestore.collection(productsCollection).snapshots();
  }
  static getFeaturedProducts()
  {
    return firestore.collection(productsCollection).where('is_featured',isEqualTo: true).get();
  }

  static searchProducts(title)
  {
    return firestore.collection(productsCollection).get();
  }
}

