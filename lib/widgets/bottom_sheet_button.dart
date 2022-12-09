
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../screens/theme.dart';
import '../utils/app_layout.dart';

class BottomSheetButton extends StatelessWidget {

  final String label;
  final Function()? onTap;
  final Color clr;
  final bool ? isClose ;
  final BuildContext context;

  const BottomSheetButton({ this.isClose=false,required this.label, required this.onTap,required this.clr,required this.context,super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin:  EdgeInsets.symmetric(vertical:AppLayout.getHeight(4) ),
        height: AppLayout.getHeight(55),
        width: MediaQuery.of(context).size.width*0.9,
        
        decoration: BoxDecoration(
          border: Border.all(
            width: AppLayout.GetWidget(2),
            color: isClose==true?Get.isDarkMode?Colors.grey[600]!:Colors.grey[300]!:clr
          ),
          borderRadius: BorderRadius.circular(AppLayout.getHeight(20),
         ),
           color: isClose==true? Colors.transparent: clr,
        ),
        child: Center(child: Text(label,
        style: isClose!?titleStyle:titleStyle.copyWith(color: Colors.white)
        ),),
        
      ),
    );
  }
}