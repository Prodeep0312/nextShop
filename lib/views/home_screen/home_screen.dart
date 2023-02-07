import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nextshop/consts/consts.dart';
import 'package:nextshop/services/firestore_services.dart';
import 'package:nextshop/widgets_common/loading_indicator.dart';

import '../../consts/lists.dart';
import '../../controller/home_controller.dart';
import '../../widgets_common/home_button.dart';
import '../category_screen/item_details.dart';
import 'components/featured_button.dart';
import 'components/search_screen.dart';

class HomeScreen extends StatelessWidget {

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller=Get.find<HomeController>();
    return Container(
      padding: EdgeInsets.all(12.0),
      color: lightGrey,
      width: context.screenWidth,
      height: context.screenHeight,
      child: SafeArea(child: Column(
        children: [
          Container(

            alignment: Alignment.center,
            height: 30.0,
            color: lightGrey,
            child: TextFormField(
              controller: controller.searchController,
              decoration: InputDecoration(
                border: InputBorder.none,
                suffixIcon: Icon(Icons.search).onTap(() {

                  if(controller.searchController.text.isNotEmptyAndNotNull)
                    {
                      Get.to(()=>SearchScreen(title: controller.searchController.text,));
                    }

                }),
                filled: true,
                fillColor: whiteColor,
                hintText: searchanything,
                hintStyle: TextStyle(
                  color: textfieldGrey,

                )
              ),
            ),
          ),
          10.heightBox,

          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  //swipers brands
                  VxSwiper.builder(
                      aspectRatio: 16/9,
                      autoPlay: true,
                      height: 150,
                      enlargeCenterPage: true,

                      itemCount: sliderslist.length, itemBuilder: (context,index){
                    return Image.asset(sliderslist[index],
                      fit: BoxFit.fill,

                    ).box.rounded.clip(Clip.antiAlias).margin(EdgeInsets.symmetric(horizontal: 8.0)).make();
                  }),
                  10.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(2, (index) =>homeButtons(
                      height: context.screenHeight * 0.15,
                      width: context.screenWidth / 2.5,
                      icon: index==0? icTodaysDeal:icFlashDeal,
                      title: index==0? todaysdeal:flashsale,
                    )),
                  ),
                  10.heightBox,


                  //2nd swiper

                  VxSwiper.builder(
                      aspectRatio: 16/9,
                      autoPlay: true,
                      height: 150.0,
                      enlargeCenterPage: true,

                      itemCount: secondSliderslist.length, itemBuilder: (context,index){
                    return Image.asset(secondSliderslist[index],
                      fit: BoxFit.fill,

                    ).box.rounded.clip(Clip.antiAlias).margin(EdgeInsets.symmetric(horizontal: 8.0)).make();
                  }),
                  10.heightBox,
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children:List.generate(3, (index) =>homeButtons(
                        height: context.screenHeight * 0.15,
                        width: context.screenWidth / 3.5,
                        icon: index==0? icTopCategories:index==1?icBrands:icTopSeller,
                        title: index==0?topCategories:index==1?brand:topsellers,

                      ))),

                  //featured categories
                  20.heightBox,
                  Align(
                      alignment: Alignment.centerLeft,
                      child: featuredCategories.text.color(darkFontGrey).size(18.0).fontFamily(semibold).make()),
                  20.heightBox,
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children:List.generate(3,
                              (index) =>

                                  Column(

                                    children: [
                                      featuredButton(icon: featuredImages1[index],title: featuredTitles1[index]),
                                      10.heightBox,
                                      featuredButton(icon: featuredImages2[index],title: featuredTitles2[index]),
                                    ],
                                  )).toList(),
                    ),
                  ),

                  //featured product
                  20.heightBox,
                  Container(
                    padding: EdgeInsets.all(12.0),
                    width: double.infinity,
                   decoration: BoxDecoration(
                     color: Colors.orange[900],

                   ),
                    child: Column(
                      
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        featuredProducts.text.white.fontFamily(bold).size(18.0).make(),
                        10.heightBox,
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child:FutureBuilder(
                              future:FirestoreServices.getFeaturedProducts(),
                              builder:(context,AsyncSnapshot<QuerySnapshot>snapshot){

                                if(!snapshot.hasData){
                                  return Center(
                                    child: loadingIndicator(),
                                  );
                                }else if(snapshot.data!.docs.isEmpty)
                                  {
                                    return "No featured Products".text.white.makeCentered();
                                  }
                                else
                                  {
                                    var featuredData=snapshot.data!.docs;
                                    return  Row(
                                      children:List.generate(featuredData.length, (index) =>Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          Image.network(featuredData[index]['p_imgs'][0],width: 130.0,height:130,fit: BoxFit.cover,),
                                          10.heightBox,
                                          "${featuredData[index]['p_name']}".text.fontFamily(semibold).color(darkFontGrey).make(),
                                          10.heightBox,
                                          "${featuredData[index]['p_price']}".numCurrency.text.color(redColor).fontFamily(bold).size(16).make()

                                        ],

                                      ).box.white.margin(EdgeInsets.symmetric(horizontal: 4.0)).roundedSM.padding(EdgeInsets.all(8.0)).make().onTap(() {
                                        Get.to(()=>ItemDetails(
                                          title: "${featuredData[index]['p_name']}",
                                          data: featuredData[index],

                                        ));
                                      })),
                                    );
                                  }

                              })
                        )
                      ],

                    ),
                  ),

                  //third swiper
                   20.heightBox,
                  VxSwiper.builder(
                      aspectRatio: 16/9,
                      autoPlay: true,
                      height: 150.0,
                      enlargeCenterPage: true,

                      itemCount: secondSliderslist.length, itemBuilder: (context,index){
                    return Image.asset(secondSliderslist[index],
                      fit: BoxFit.fill,

                    ).box.rounded.clip(Clip.antiAlias).margin(EdgeInsets.symmetric(horizontal: 8.0)).make();
                  }),

                  //all products section
                  20.heightBox,
                  Align(
                    alignment: Alignment.centerLeft,

                      child: "All Products".text.fontFamily(bold).color(darkFontGrey).size(18).make()),

                  20.heightBox,

                  StreamBuilder(
                    stream: FirestoreServices.allProducts(),
                      builder:(BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){

                      if(!snapshot.hasData)
                        {
                          return loadingIndicator();
                        }else
                          { var allProductsdata=snapshot.data!.docs;
                            return GridView.builder(
                                physics: NeverScrollableScrollPhysics(),

                                shrinkWrap:true,
                                itemCount: allProductsdata.length,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 8.0,crossAxisSpacing: 8.0,mainAxisExtent: 300), itemBuilder: (context,index){
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Image.network(allProductsdata[index]['p_imgs'][0],width: 200.0,height:200.0,fit: BoxFit.cover,),
                                  Spacer(),
                                  "${allProductsdata[index]['p_name']}".text.fontFamily(semibold).color(darkFontGrey).make(),
                                  10.heightBox,
                                  "${allProductsdata[index]['p_price']}".text.color(redColor).fontFamily(bold).size(16).make()

                                ],

                              ).box.white.margin(EdgeInsets.symmetric(horizontal: 4.0)).roundedSM.padding(EdgeInsets.all(12.0)).make().onTap(() { 
                                Get.to(()=>ItemDetails(
                                  title: "${allProductsdata[index]['p_name']}",
                                  data: allProductsdata[index],

                                ));
                              });
                            });
                          }
                      })



                ],
              ),
            ),
          )
        ],
      )),

    );
  }
}
