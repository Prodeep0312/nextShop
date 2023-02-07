import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nextshop/consts/consts.dart';
import 'package:nextshop/consts/lists.dart';
import 'package:nextshop/services/firestore_services.dart';

import '../../controller/product_controller.dart';
import '../../widgets_common/bg.dart';
import '../../widgets_common/loading_indicator.dart';
import 'item_details.dart';

class CategoryDetails extends StatefulWidget {
  final String? title;

  const CategoryDetails({Key? key,required this.title}) : super(key: key);

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  var controller=Get.find<ProductController>();
  dynamic productMethod;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    switchCategory(widget.title);
  }

  switchCategory(title){
    if(controller.subcat.contains(title))
      {
        productMethod=FirestoreServices.getSubCategoryProducts(title);
      }
    else{
      productMethod=FirestoreServices.getProducts(title);
    }
  }
  Widget build(BuildContext context) {

    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          title:widget.title!.text.fontFamily(bold).white.make(),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                children:List.generate(controller.subcat.length, (index) =>"${controller.subcat[index]}".text.size(12.0).fontFamily(semibold).color(darkFontGrey).makeCentered().box.white.rounded.size(120, 60).margin(EdgeInsets.symmetric(horizontal: 4.0)).make().onTap(() {
                  switchCategory("${controller.subcat[index]}");
                  setState(() {

                  });
                })),
              ),
            ),
            20.heightBox,
            StreamBuilder(
              stream: productMethod,


                builder:(BuildContext context,AsyncSnapshot<QuerySnapshot>snapshot){
                if(!snapshot.hasData){
                  return Expanded(
                    child: Center(
                      child: loadingIndicator(),
                    ),
                  );
                }else if(snapshot.data!.docs.isEmpty){
                  return Expanded(
                    child: "No products found!".text.color(darkFontGrey).makeCentered(),
                  );
                }

                else
                  {
                      var data =snapshot.data!.docs;


                    return Expanded(child: Container(
                            color: lightGrey,
                            child: GridView.builder(
                                physics: BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: data.length,

                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisExtent: 250,mainAxisSpacing: 8.0,crossAxisSpacing: 8.0,), itemBuilder: (context,index){
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Image.network(data[index]['p_imgs'][0],
                                    width: 200.0,
                                    height:150.0,
                                    fit: BoxFit.cover,),

                                  "${data[index]['p_name']} ".text.fontFamily(semibold).color(darkFontGrey).make(),
                                  10.heightBox,
                                  "${data[index]['p_price']}".numCurrency.text.color(redColor).fontFamily(bold).size(16).make()

                                ],

                              ).box.white.outerShadowSm.margin(EdgeInsets.symmetric(horizontal: 4.0)).roundedSM.padding(EdgeInsets.all(12.0)).make()
                                  .onTap(() {
                                    controller.checkifFav(data[index]);
                                Get.to(()=>ItemDetails(title: "${data[index]['p_name']}",data: data[index]));
                              });
                            })


                        ),
                        );

                  }
                }),
          ],
        )
      )
    );
  }
}
