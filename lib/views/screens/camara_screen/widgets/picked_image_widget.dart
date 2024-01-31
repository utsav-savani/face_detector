import 'dart:io';

import 'package:face_detector/controlles/camera_screen_controller.dart';
import 'package:face_detector/views/screens/camara_screen/widgets/custom_position.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';

class PickedImageWidget extends StatelessWidget {
  PickedImageWidget({super.key});

  final CameraScreenController _controller = Get.find<CameraScreenController>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Screenshot(
        controller: _controller.screenshotController,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.file(
              File(_controller.pickedImage.value.path ?? ""),
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
            Obx(
              () => CustomPositionWidget(
                offset: _controller.position1.value,
                visible: _controller.eyeVisibility.value,
                onDraggableCanceled: (p0, offset) {
                  _controller.position1.value =
                      Offset(offset.dx, offset.dy - 90);
                },
              ),
            ),
            Obx(
              () => CustomPositionWidget(
                offset: _controller.position2.value,
                visible: _controller.eyeVisibility.value,
                onDraggableCanceled: (p0, offset) {
                  _controller.position2.value =
                      Offset(offset.dx, offset.dy - 90);
                },
              ),
            ),
            Obx(
              () => CustomPositionWidget(
                offset: _controller.position3.value,
                visible: _controller.lipsVisibility.value,
                onDraggableCanceled: (p0, offset) {
                  _controller.position3.value =
                      Offset(offset.dx, offset.dy - 90);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
