
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/theme.dart';
import '../utils/app_layout.dart';

class MyInputField extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController ? controller;
  final Widget ? widget;
  const MyInputField({ 

    required this.title,
    required this.hint,
    this.controller,
    this.widget,
     
     super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: AppLayout.getHeight(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: titleStyle,
          ),

          Container(
            height: AppLayout.getHeight(52),
            margin: EdgeInsets.only(top: AppLayout.getHeight(10.0)),
            padding: EdgeInsets.only(left: AppLayout.getHeight(14.0)),
            decoration: BoxDecoration(
             border: Border.all(
              color: Colors.grey,
              width: 1.0
             ),
             borderRadius: BorderRadius.circular(AppLayout.getHeight(15))
            ),
            child: Row(
              children: [
                Expanded(
                  child:TextFormField(
                    readOnly: widget==null?false:true,
                    autofocus: false,
                    cursorColor: Get.isDarkMode?Colors.grey[100]:Colors.grey[700],
                    controller: controller,
                    style: subTitleStyle,
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: subTitleStyle,
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: context.theme.backgroundColor,
                          width: 0
                        )
                      ), 
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: context.theme.backgroundColor,
                          width: 0
                        )
                      ),
                    ),

                  ) ,
                ),
                widget==null?Container():Container(child: widget,)
              ],
            ),
          )
        ],
      ),
    );
  }
}