import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:nextshop/consts/consts.dart';
import 'package:nextshop/consts/lists.dart';
import 'package:nextshop/controller/account_controller.dart';
import 'package:nextshop/views/auth_screen/login_screen.dart';
import 'package:nextshop/widgets_common/bg.dart';
import 'package:nextshop/widgets_common/loading_indicator.dart';

import '../../controller/auth_controller.dart';
import '../../services/firestore_services.dart';
import '../chat_screen/message_screen.dart';
import '../orders_screen/orders_screen.dart';
import '../wishlist_screen/wishlist_screen.dart';
import 'components/details_card.dart';
import 'edit_accountscreen.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(AccountController());

    return bgWidget(
      child: Scaffold(
        body: StreamBuilder(
          stream: FirestoreServices.getUser(currentUser!.uid),


            builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
            if(!snapshot.hasData){
              return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(redColor),),);
            }
            else{


          var data = snapshot.data!.docs[0];

              return SafeArea(
                child: Column(


                  children: [
                    //edit profile button

                    Align(
                        alignment: Alignment.topRight,
                        child: Icon(Icons.edit,color: Colors.white,)).onTap(() {
                      controller.nameController.text=data['name'];


                      Get.to(()=>EditAccountScreen(data: data,));
                    }
                    ),

                    //user details section
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Image.asset(imgProfile2,width: 100.0,fit: BoxFit.cover,).box.roundedFull.clip(Clip.antiAlias).make(),
                          10.widthBox,
                          Expanded(child: Column(
                            crossAxisAlignment:CrossAxisAlignment.start,
                            children: [
                              "${data['name']}".text.white
                                  .fontFamily(semibold).make(),
                              5.heightBox,
                              "${data['email']}".text.white.make(),


                            ],),

                          ),

                          OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  side: const BorderSide(
                                    color: whiteColor,
                                  )
                              ),

                              onPressed: ()async{

                                await Get.put(AuthController()).signoutMethod(context);
                                Get.offAll(()=>LoginScreen());
                              }, child: logout.text.fontFamily(semibold).white.make())
                        ],
                      ),
                    ),
                    20.heightBox,
                   FutureBuilder(
                       future:FirestoreServices.getCount(),
                       builder: (BuildContext context,AsyncSnapshot snapshot){
                         if(!snapshot.hasData){
                           return Center(child: loadingIndicator());
                         }
                         else
                           {var countData =snapshot.data;
                             print(snapshot.data);
                             return Row(
                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                               children: [
                                 detailsCard(count:countData[0].toString(),title: "In your cart",width: context.screenWidth/4),
                                 detailsCard(count: countData[1].toString(),title: "In your wl",width: context.screenWidth/4),
                                 detailsCard(count:countData[2].toString(),title: "Your orders",width: context.screenWidth/4),
                               ],
                             );
                           }



                       }),

                    //buttons section


                    ListView.separated(
                        shrinkWrap: true,
                        separatorBuilder: (context,index){
                          return Divider(
                            color: lightGrey,

                          );
                        },
                        itemCount:profileButtonList.length ,

                        itemBuilder: (context,index){
                          return ListTile(
                            onTap: (){
                              switch(index){
                                case 0: Get.to(()=>OrdersScreen());
                                        break;
                                case 1: Get.to(()=>WishlistScreen());
                                break;

                                case 2: Get.to(()=>MessagesScreen());
                                break;

                              }
                            },
                            leading: Image.asset(profileButtonIcons[index],width: 22.0,),
                            title: profileButtonList[index].text.fontFamily(semibold).color(darkFontGrey).make(),
                          );

                        }).box.white.rounded.margin(EdgeInsets.all(12)).padding(EdgeInsets.symmetric(horizontal: 16)).shadowSm.make().box.color(redColor).make()
                  ],
                ),
              );
            }

            }),
      )
    );
  }
}
