import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nextshop/consts/consts.dart';
import 'package:nextshop/consts/lists.dart';
import 'package:nextshop/controller/account_controller.dart';
import 'package:nextshop/widgets_common/button.dart';

import '../../controller/product_controller.dart';
import '../../widgets_common/bg.dart';
import '../chat_screen/chat_screen.dart';


class ItemDetails extends StatelessWidget {
  final dynamic data;
  final String? title;
  const ItemDetails({Key? key, required this.title,this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    return WillPopScope(
      onWillPop: ()async{
        controller.resetValues();
        return true;
      },
      child: Scaffold(
        backgroundColor: lightGrey,
        appBar: AppBar(
          title: title!.text.color(darkFontGrey).fontFamily(bold).make(),
          leading: IconButton(
              onPressed:(){controller.resetValues();
              Get.back();},
            icon: Icon(Icons.arrow_back)),
          actions: [
            IconButton(onPressed: (){}, icon: Icon(Icons.share,)),
            Obx(()=>
              IconButton(onPressed: (){
                if(controller.isFav.value){
                  controller.removefromWishlist(data.id,context);

                }else{

                  controller.addtoWishlist(data.id,context);

                }
              }, icon: Icon(Icons.favorite,
              color: controller.isFav.value?redColor:darkFontGrey,)),
            ),

          ],
        ),
        body:Column(
          children: [
            Expanded(child:Padding(

              padding: EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //swiper section
                    VxSwiper.builder(
                        autoPlay: true,
                        height: 350.0,
                        aspectRatio: 16/9,
                        viewportFraction: 1.0,//1 img in 1 screen at a time
                        itemCount: data['p_imgs'].length, itemBuilder:(context,index){
                      return Image.network(data['p_imgs'][index],width: double.infinity,fit: BoxFit.cover,);
                    }),
                    10.heightBox,
                    //titles and details section
                    title!.text.size(16).color(darkFontGrey).fontFamily(semibold).make(),
                    10.heightBox,
                    //rating
                    VxRating(onRatingUpdate: (value){

                    },
                      value: double.parse(data['p_rating']),
                    normalColor: textfieldGrey,
                      isSelectable: false,//user canot manually change rating
                      selectionColor:Vx.yellow400,
                      count:5,
                      maxRating: 5,
                      size:25,
                      ),
                    10.heightBox,
                    "${data['p_price']}".numCurrency.text.color(redColor).fontFamily(bold).size(18).make(),
                    10.heightBox,
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              "Seller".text.white.fontFamily(semibold).make(),
                              5.heightBox,
                              "${data['p_seller']}".text.fontFamily(bold).color(darkFontGrey).make()
                            ],



                          ),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.white,
                            child: Icon(Icons.message_rounded,color: darkFontGrey,),
                        ).onTap(() {
                          Get.to(()=>ChatScreen(),
                          arguments: [data['p_seller'],data['vendor_id']]);
                        }),

                      ],
                    ).box.height(60).padding(EdgeInsets.symmetric(horizontal: 16)).color(textfieldGrey).make(),
                    20.heightBox,
                    //color section

                    Obx(()=>
                       Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 100.0,
                                child: "Color".text.color(textfieldGrey).make(),
                              ),
                              Row(
                                children: List.generate(data['p_colors'].length, (index) =>

                                    Stack(
                                        alignment: Alignment.center,
                                        children:[
                                      VxBox().size(40,40).color(Color(data['p_colors'][index]).withOpacity(1.0)).margin(EdgeInsets.symmetric(horizontal: 4)).roundedFull.make().onTap(() {
                                        controller.changeColorIndex(index);
                                      }),
                                      Visibility(
                                        visible: index==controller.colorIndex.value,
                                        child: Icon(Icons.done,color: Colors.white),)
                                    ] )),
                              ),

                            ],
                          ).box.padding(EdgeInsets.all(8.0)).make(),
                        ],
                      ).box.white.shadowSm.make(),
                    ),

                    //quantity section

                    Row(
                      children: [
                        SizedBox(
                          width: 100.0,
                          child: "Quantity".text.color(textfieldGrey).make(),
                        ),
                          Obx(
                                ()=>
                             Row(
                              children: [
                                IconButton(onPressed: (){
                                  controller.decreaseQuantity();
                                  controller.calculateTotalPrice(int.parse(data['p_price']));
                                }, icon:Icon(Icons.remove)),
                                controller.quantity.value.text.size(16).color(darkFontGrey).fontFamily(bold).make(),
                                IconButton(onPressed: (){
                                  controller.increaseQuantity(
                                    int.parse(data['p_quantity'])
                                  );
                                  controller.calculateTotalPrice(int.parse(data['p_price']));


                                }, icon:Icon(Icons.add)),
                                10.widthBox,
                                "(${data['p_quantity']} available)".text.color(textfieldGrey).make(),

                              ],
                            ),
                          ),


                      ],
                    ).box.padding(EdgeInsets.all(8)).make(),

                    Obx(()=>//to make total stateful
                       Row(
                        children: [
                          SizedBox(
                            width: 100.0,
                            child: "Total".text.color(textfieldGrey).make(),
                          ),
                          "${controller.totalPrice.value}".numCurrency.text.color(redColor).size(16).fontFamily(bold).make(),


                        ],
                      ).box.padding(EdgeInsets.all(8)).make(),
                    ),
                    10.heightBox,

                    //description section
                    "Description".text.fontFamily(semibold).color(darkFontGrey).make(),
                    10.heightBox,
                    "${data['p_desc']}".text.color(darkFontGrey).make(),

                    //buttons section
                    ListView(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children:List.generate(itemDetailsButtonList.length, (index) =>ListTile(
                        title: itemDetailsButtonList[index].text.fontFamily(semibold).make(),
                        trailing: Icon(Icons.arrow_forward),
                      )),
                    ),
                    20.heightBox,

                    productumlike.text.fontFamily(bold).size(16).color(darkFontGrey).make(),
                    10.heightBox,

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children:List.generate(6, (index) =>Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Image.asset(imgP1,width: 150.0,fit: BoxFit.cover,),
                            10.heightBox,
                            "Laptop 4GB/64GB".text.fontFamily(semibold).color(darkFontGrey).make(),
                            10.heightBox,
                            "\$600".text.color(redColor).fontFamily(bold).size(16).make()

                          ],

                        ).box.white.margin(EdgeInsets.symmetric(horizontal: 4.0)).roundedSM.padding(EdgeInsets.all(8.0)).make()),
                      ),
                    ),


                  ],
                ),
              ),
            )),
            SizedBox(
              width: double.infinity,
              height: 60.0,
              child: ourButton(

                color: redColor,
                onPress: (){
                  if(controller.quantity.value>0){
                    controller.addToCart(
                      color: data['p_colors'][controller.colorIndex.value],
                      context: context,
                      qty: controller.quantity.value,
                      vendorID: data['vendor_id'],
                      sellername: data['p_seller'],
                      img: data['p_imgs'][0],
                      title: data['p_name'],
                      tprice: controller.totalPrice.value,

                    );
                    VxToast.show(context, msg: "added to cart");
                  }else
                    {
                      VxToast.show(context, msg: "Minimum 1 product is required ");
                    }
                },
                textColor: whiteColor,
                title: "Add to Cart",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
