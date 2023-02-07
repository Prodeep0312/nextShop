import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nextshop/consts/consts.dart';
import 'package:flutter/material.dart';
import 'package:nextshop/services/firestore_services.dart';
import 'package:nextshop/widgets_common/loading_indicator.dart';

import '../../controller/chat_controller.dart';
import 'components/sender_bubble.dart';
class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller=Get.put(ChatsController());
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "${controller.friendName}".text.fontFamily(semibold).color(darkFontGrey).make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Obx(()=>
              controller.isLoading.value ? Center(
              child: loadingIndicator()):

              Expanded(child: StreamBuilder(
                  stream:FirestoreServices.getChatMessages(controller.chatDocId.toString()),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                    if(!snapshot.hasData){

                      return Center(
                        child: loadingIndicator(),
                      );
                    }else if(snapshot.data!.docs.isEmpty){

                      return Center(
                        child: "Send a message".text.color(darkFontGrey).make(),
                      );
                    }
                    else
                      {
                        return ListView(
                          children: snapshot.data!.docs.mapIndexed((currentValue, index){
                            var data=snapshot.data!.docs[index];



                            return Align(
                              alignment: data['uid']==currentUser!.uid?Alignment.centerRight:Alignment.centerLeft,
                                child: senderBubble(data));
                          }).toList(),
                        );
                      }
                  })),
            ),
            10.heightBox,
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller.msgController,
                    decoration: InputDecoration(
                      hintText: "Type a message ...",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: textfieldGrey,
                        ),

                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: textfieldGrey,
                        ),

                      ),
                    ),

                  ),

                ),

                IconButton(onPressed: (){

                  controller.sendMsg(controller.msgController.text);
                  controller.msgController.clear();
                }, icon: Icon(Icons.send,color: redColor,))
              ],
            ).box.height(80).margin(EdgeInsets.only(bottom: 12)).padding(EdgeInsets.all(12)).make()

          ],
        ),
      ),
    );
  }
}
