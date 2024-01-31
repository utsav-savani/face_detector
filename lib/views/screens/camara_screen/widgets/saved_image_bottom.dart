import 'package:face_detector/controlles/camera_screen_controller.dart';
import 'package:face_detector/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SavedImageBottom extends StatelessWidget {
  SavedImageBottom({super.key});

  final CameraScreenController _controller = Get.find<CameraScreenController>();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: InkWell(
          onTap: () {
            _controller.reset.call();
          },
          child: Align(
            alignment: Alignment.topLeft,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  Constants.backIcon,
                  width: 24.h,
                  height: 24.h,
                ),
                Text('다시찍기'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
