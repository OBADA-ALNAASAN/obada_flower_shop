import 'package:flower_shop/constant/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        // width: 80.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: Colors.white),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
                color: AppColors.purple,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
