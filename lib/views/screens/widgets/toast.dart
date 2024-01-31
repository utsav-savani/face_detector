import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomToast extends StatelessWidget {
  final String text;

  const CustomToast.CustomToastContentWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 12.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        // color:Colors.red,
        color: Colors.black.withOpacity(.4),
      ),
      child: Text(text),
    );
  }
}
