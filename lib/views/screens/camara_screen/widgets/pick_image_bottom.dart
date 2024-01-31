import 'package:face_detector/controlles/camera_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/constants/constants.dart';

class PickImageBottom extends StatelessWidget {
  PickImageBottom({super.key});

  final CameraScreenController _controller = Get.find<CameraScreenController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 30.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: _controller.takeImage,
                child: CircleAvatar(
                  radius: 32.r,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 30.r,
                    backgroundColor: Colors.black,
                    child: CircleAvatar(
                      radius: 28.r,
                      backgroundColor: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Spacer(),
          Padding(
            padding: EdgeInsets.only(bottom: 40.h, left: 20.w, right: 20.w),
            child: SizedBox(
              width: 1.sw,
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: _controller.pickImage,
                      child: Image.asset(
                        Constants.galleryIcon,
                        width: 24.h,
                        height: 24.h,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      child: Image.asset(
                        Constants.refreshIcon,
                        width: 24.h,
                        height: 24.h,
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
    ;
  }
}
