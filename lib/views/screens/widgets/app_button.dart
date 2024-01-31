import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class AppButton extends StatelessWidget {
  final String title;
  bool light = false;
  final void Function() onTap;

  AppButton({
    super.key,
    required this.title,
    this.light = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 40.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: light ? Color(0xFFD3D3D3) : Color(0xFF7B8FF7),
          // color: Color(OxffD3D3D3)
        ),
        child: Text(title),
      ),
    );
  }
}
