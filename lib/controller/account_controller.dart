

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
//import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nextshop/consts/consts.dart';
import 'package:path/path.dart';
import 'dart:io';
//import 'dart:async';




class AccountController extends GetxController{

var accountImgPath = ''.obs;
var accountImgLink='';
var isloading =false.obs;


var nameController=TextEditingController();
var oldpassController=TextEditingController();
var newpassController=TextEditingController();

changeImage(context)async{

  try{
    final img =await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 70);
  if(img == null) return;
  accountImgPath.value=img.path;


  }
  on PlatformException catch(e){

VxToast.show(context, msg: e.toString());
  }

}
uploadProfileImage()async{
  var filename=basename(accountImgPath.value);
  var destination='images/${currentUser!.uid}/$filename';
  Reference ref=FirebaseStorage.instance.ref().child(destination);
  await ref.putFile(File(accountImgPath.value));
  accountImgLink =await ref.getDownloadURL();




}

updateProfile({name,password,imgUrl})async{
  var store=firestore.collection(userCollection).doc(currentUser!.uid);
  await store.set({

    'name':name,
    'password':password,
    'imageUrl':imgUrl,
  },SetOptions(merge: true));
  isloading(false);



}

changeAuthPassword({email,password,newpassword})async{
final cred=EmailAuthProvider.credential(email: email, password: password);
await currentUser!.reauthenticateWithCredential(cred).then((value) {
  currentUser!.updatePassword(newpassword);
}).catchError((error){
  print(error.toString());
});
}
}