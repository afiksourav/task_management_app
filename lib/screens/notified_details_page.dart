
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../utils/app_layout.dart';

class NotifiedPage extends StatelessWidget {
  final String ? label;
  const NotifiedPage({required this.label,super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor:Get.isDarkMode? Colors.grey[600]:Colors.white,
          leading: IconButton(
            onPressed: ()=>Get.back(),
            icon:  Icon(Icons.arrow_back_ios,
            color: Get.isDarkMode?Colors.white:Colors.grey,
            ) ,
          ),
          title: Center(
            child: Text(this.label.toString().split("|")[0],
            style: TextStyle(color: Colors.black),),
          ),
        ),
        body: Center(
          child: Container(
            height: AppLayout.getHeight(400),
            width: AppLayout.GetWidget(300),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppLayout.getHeight(20),
              ),
              color: Get.isDarkMode? Colors.white: Colors.grey[400]
            ),
            child: Center(
              child: Text(
                this.label.toString().split("|")[1],
                style: TextStyle(color:Get.isDarkMode? Colors.black:Colors.white,
                fontSize: AppLayout.getHeight(30)
                ),
                
              ),
            ),
          ),
        )
    );
  }
}