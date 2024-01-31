import 'package:camera/camera.dart';
import 'package:face_detector/controlles/camera_screen_controller.dart';
import 'package:face_detector/core/data/enums/enums.dart';
import 'package:face_detector/views/screens/camara_screen/widgets/pick_image_bottom.dart';
import 'package:face_detector/views/screens/camara_screen/widgets/picked_image_bottom.dart';
import 'package:face_detector/views/screens/camara_screen/widgets/picked_image_widget.dart';
import 'package:face_detector/views/screens/camara_screen/widgets/saved_image_bottom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CameraScreen extends StatelessWidget {
  CameraScreen({super.key});

  final CameraScreenController _controller = Get.put(CameraScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert_rounded),
          )
        ],
      ),
      body: Obx(
        () => _controller.dataStatus.value.isSuccess
            ? FutureBuilder(
                future: _controller.initializeControllerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Column(
                      children: [
                        generateImageWidget(),
                        generateBottomWidget(),
                      ],
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }

  Widget generateImageWidget() {
    return SizedBox(
      height: 420.h,
      width: double.infinity,
      child: Obx(
        () => !_controller.isImagePicked.value
            ? CameraPreview(_controller.cameraController)
            : PickedImageWidget(),
      ),
    );
  }

  Widget generateBottomWidget() {
    return Obx(() {
      if (_controller.imageStatus.value == ImageStatus.camera) {
        return PickImageBottom();
      } else if (_controller.imageStatus.value == ImageStatus.picked) {
        return PickedImageBottom();
      } else if (_controller.imageStatus.value == ImageStatus.saved) {
        return SavedImageBottom();
      } else {
        return SizedBox.shrink();
      }
    });
  }
}
