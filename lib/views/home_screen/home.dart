import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nextshop/consts/consts.dart';
import 'package:nextshop/views/account_screen/account_screen.dart';
import 'package:nextshop/views/cart_screen/cart_screen.dart';
import 'package:nextshop/views/category_screen/category_screen.dart';
import 'package:nextshop/views/home_screen/home_screen.dart';

import '../../controller/home_controller.dart';
import '../../widgets_common/exit_dialog.dart';


class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    //init home controller
    var controller=Get.put(HomeController());
    var navBarItem=[
      BottomNavigationBarItem(icon: Image.asset(icHome,width: 26.0,),
      label: home),
      BottomNavigationBarItem(icon: Image.asset(icCategories,width: 26.0,),
          label: categories),

      BottomNavigationBarItem(icon: Image.asset(icCart,width: 26.0,),
          label: cart),

      BottomNavigationBarItem(icon: Image.asset(icProfile,width: 26.0,),
          label: account),


    ];

    var navBody=[
      HomeScreen(),
      CategoryScreen(),
      CartScreen(),
      AccountScreen(),

    ];
    return WillPopScope(
      onWillPop: ()async{
        showDialog(
          barrierDismissible: false,
            context: context, builder: (context)=>exitDialog(context));
        return false;
      },
      child: Scaffold(
        body:Column(
          children: [
            Obx(()=>
               Expanded(
                child: navBody.elementAt(controller.currentNavIndex.value),

              ),
            ),
          ],
        ),
        bottomNavigationBar: Obx(()=>
           BottomNavigationBar(
             currentIndex: controller.currentNavIndex.value,
            selectedItemColor: redColor,
            selectedLabelStyle: TextStyle(fontFamily: semibold),
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            items: navBarItem,
             onTap: (value){

               controller.currentNavIndex.value=value;
             },
          ),
        ),
      ),
    );
  }
}
