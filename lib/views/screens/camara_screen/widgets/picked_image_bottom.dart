import 'package:face_detector/controlles/camera_screen_controller.dart';
import 'package:face_detector/core/constants/constants.dart';
import 'package:face_detector/views/screens/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PickedImageBottom extends StatelessWidget {
  PickedImageBottom({super.key});

  final CameraScreenController _controller = Get.find<CameraScreenController>();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 15.h,
            ),
            InkWell(
              onTap: () {
                _controller.reset.call();
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
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
            SizedBox(
              height: 15.h,
            ),
            Row(
              children: [
                button(
                  '눈',
                  () {
                    _controller.onTapEyeVisible.call();
                  },
                ),
                SizedBox(
                  width: 15.w,
                ),
                button(
                  '입',
                  () {
                    _controller.onTapLipsVisible.call();
                  },
                )
              ],
            ),
            const Spacer(),
            Obx(
              () => AppButton(
                title: '저장하기',
                light: !(_controller.eyeVisibility.isTrue &&
                    _controller.lipsVisibility.isTrue),
                onTap: () async {
                  await _controller.onTapSaveImage.call();
                },
              ),
            ),
            SizedBox(
              height: 20.h,
            )
          ],
        ),
      ),
    );
  }

  Widget button(String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60.h,
        width: 60.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.r),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
