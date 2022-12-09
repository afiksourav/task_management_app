
import 'package:flutter/material.dart';
import '../screens/theme.dart';
import '../utils/app_layout.dart';


class MyBottom extends StatelessWidget {
  final String label;
  final Function()? onTap;
  const MyBottom({required this.label, required this.onTap,super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap,
      child: Container(
        width: AppLayout.GetWidget(120),
        height: AppLayout.getHeight(50),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppLayout.getHeight(20)),
          color: primaryClr
        ),
        child: Center(
          child: Text(
            label,
            style:const TextStyle(
              color: Colors.white
            ),
          ),
        ),
      ),
    );
  }
}