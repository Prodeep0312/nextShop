import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nextshop/consts/consts.dart';
import 'package:intl/intl.dart' as intl;


import 'components/order_place_details.dart';
import 'components/order_status.dart';

class OrderDetails extends StatelessWidget {
  final dynamic data;
  const OrderDetails({Key? key,this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Order Details".text.fontFamily(semibold).color(darkFontGrey).make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(

            children: [
              orderStatus(color: redColor,title: " Placed",showDone: data['order_placed'],icon: Icons.done),
              orderStatus(color: Colors.blue,title: " Confirmed",showDone: data['order_confirmed'],icon: Icons.thumb_up),
              orderStatus(color: Colors.yellow,title: " On Delivery",showDone: data['order_on_delivery'],icon: Icons.car_crash),
              orderStatus(color: Colors.purple,title: " Delivered",showDone: data['order_delivered'],icon: Icons.done_all_rounded),
              Divider(),
              10.heightBox,
              Column(
                children: [
                  orderPlaceDetails(
                      d1: data['order_code'],
                      d2: data['shipping_method'],
                      title1: "Order Code",
                      title2: "Shipping Method"
                  ),
                  orderPlaceDetails(
                      d1: intl.DateFormat().add_yMd().format((data['order_date'].toDate())),
                      d2: data['payment_method'],
                      title1: "Order Date",
                      title2: "Payment Method"
                  ),
                  orderPlaceDetails(
                    d1: "Unpaid",
                    d2: "Order Placed",
                    title1: "Payment Status",
                    title2: "Delivery Status",
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Shipping Address".text.fontFamily(semibold).make(),
                            "${data['order_by_name']}".text.make(),
                            "${data['order_by_email']}".text.make(),
                            "${data['order_by_address']}".text.make(),
                            "${data['order_by_city']}".text.make(),
                            "${data['order_by_state']}".text.make(),
                            "${data['order_by_phone']}".text.make(),
                            "${data['order_by_postalcode']}".text.make(),

                          ],
                        ),
                        SizedBox(
                          width: 130,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "Total Amount".text.fontFamily(semibold).make(),
                              "${data['total_amount']}".numCurrency.text.color(redColor).fontFamily(bold).make(),

                            ],
                          ),
                        ),
                      ],
                    ),
                  )

                ],
              ).box.outerShadowMd.white.make(),
              Divider(),
              10.heightBox,
              "Ordered Products".text.size(16).fontFamily(semibold).color(darkFontGrey).makeCentered(),
              10.heightBox,
              ListView(
                shrinkWrap: true,
                children: List.generate(data['orders'].length, (index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[

                      orderPlaceDetails(
                          title1: data['orders'][index]['title'],
                          title2: data['orders'][index]['tprice'],
                          d1: "${data['orders'][index]['qty']}x",
                          d2: "Refundable"
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Container(

                          height: 20,
                          width: 30,
                          color: Color(data['orders'][index]['color']),
                        ),
                      ),
                      Divider(),
                    ],

                  );
                }).toList(),
              ).box.outerShadowMd.white.margin(EdgeInsets.only(bottom: 4)).make(),
              20.heightBox,
            ],
          ),
        ),
      ),
    );
  }
}
