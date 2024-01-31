import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:face_detector/core/data/enums/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:screenshot/screenshot.dart';

import '../views/screens/widgets/toast.dart';

class CameraScreenController extends GetxController {
  Rx<ImageStatus> imageStatus = ImageStatus.camera.obs;
  Rx<RxStatus> dataStatus = RxStatus.loading().obs;
  late CameraController cameraController;
  late Future<void> initializeControllerFuture;

  final ScreenshotController screenshotController = ScreenshotController();
  final ImagePicker imagePicker = ImagePicker();
  Rx<XFile> pickedImage = XFile("").obs;
  RxBool isImagePicked = false.obs;

  Rx<Offset> position1 = Offset(50.0.w, 180.0.h).obs;
  Rx<Offset> position2 = Offset(200.0.w, 180.0.h).obs;
  Rx<Offset> position3 = Offset(125.0.w, 250.0.h).obs;
  late InputImage inputImage;
  final faceDetector = FaceDetector(options: FaceDetectorOptions());
  RxBool eyeVisibility = false.obs;
  RxBool lipsVisibility = false.obs;
  FToast fToast = FToast();

  @override
  void onInit() {
    super.onInit();
    fToast.init(Get.context!);

    availableCameras().then((cameras) {
      CameraDescription? frontCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first,
      );

      cameraController = CameraController(
        frontCamera,
        ResolutionPreset.medium,
      );

      initializeControllerFuture = cameraController.initialize();
      log("dataStatus is:--> $dataStatus");
      dataStatus.value = RxStatus.success();
      log("dataStatus is:--> $dataStatus");
    });
  }

  @override
  void dispose() {
    cameraController.dispose();
    isImagePicked.value = false;
    super.dispose();
  }

  void rotateCamera() {
    availableCameras().then((cameras) {
      CameraDescription? frontCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.back,
        orElse: () => cameras.first,
      );

      cameraController = CameraController(
        frontCamera,
        ResolutionPreset.max,
      );
    });
  }

  void onTapLipsVisible() {
    lipsVisibility.value = true;
  }

  void onTapEyeVisible() {
    eyeVisibility.value = true;
  }

  void reset() {
    imageStatus.value = ImageStatus.camera;
    eyeVisibility.value = false;
    lipsVisibility.value = false;
    position1.value = Offset(50.0.w, 180.0.h);
    position2.value = Offset(200.0.w, 180.0.h);
    position3.value = Offset(125.0.w, 250.0.h);

    pickedImage.value = XFile('');
    isImagePicked.value = false;
  }

  Future<void> takeImage() async {
    try {
      await initializeControllerFuture;

      final image = await cameraController.takePicture();
      pickedImage.value = image;
      faceDetection();
    } catch (e) {
      log('Error taking photo: $e');
    }
  }

  Future<void> pickImage() async {
    final file = await imagePicker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      pickedImage.value = file;
      faceDetection();
    }
  }

  Future<void> faceDetection() async {
    inputImage = InputImage.fromFile(File(pickedImage.value.path));
    final List<Face> faces = await faceDetector.processImage(inputImage);
    log("faces is:--> $faces");
    if (faces.isEmpty) {
      fToast.showToast(
        child: CustomToast.CustomToastContentWidget(
          text: 'Please Select Image With Face',
        ),
        gravity: ToastGravity.TOP,
        toastDuration: const Duration(seconds: 2),
      );

      return;
    } else if (faces.length > 1) {
      fToast.showToast(
        child: CustomToast.CustomToastContentWidget(
            text: 'Please Select Image With One Face'),
        gravity: ToastGravity.TOP,
        toastDuration: const Duration(seconds: 2),
      );

      return;
    } else {
      isImagePicked.value = true;
      imageStatus.value = ImageStatus.picked;
    }

    for (Face face in faces) {
      final Rect boundingBox = face.boundingBox;

      final double? rotX =
          face.headEulerAngleX; // Head is tilted up and down rotX degrees
      final double? rotY =
          face.headEulerAngleY; // Head is rotated to the right rotY degrees
      final double? rotZ =
          face.headEulerAngleZ; // Head is tilted sideways rotZ degrees

      // If landmark detection was enabled with FaceDetectorOptions (mouth, ears,
      // eyes, cheeks, and nose available):
      final FaceLandmark? leftEar = face.landmarks[FaceLandmarkType.leftEar];
      if (leftEar != null) {
        // final Point<int> leftEarPos = leftEar.position;
      }

      // If classification was enabled with FaceDetectorOptions:
      if (face.smilingProbability != null) {
        final double? smileProb = face.smilingProbability;
      }

      // If face tracking was enabled with FaceDetectorOptions:
      if (face.trackingId != null) {
        final int? id = face.trackingId;
      }
    }
  }

  Future<void> onTapSaveImage() async {
    final result = await screenshotController.capture();
    if (eyeVisibility.isFalse || lipsVisibility.isFalse) {
      fToast.showToast(
        child: CustomToast.CustomToastContentWidget(
          text: 'Please Select Eye And Lips',
        ),
        gravity: ToastGravity.TOP,
        toastDuration: const Duration(seconds: 2),
      );
      return;
    }
    if (result != null) {
      ImageGallerySaver.saveImage(result);

      fToast.showToast(
        child: CustomToast.CustomToastContentWidget(
          text: '2개 이상의 얼굴이 감지되었어요!',
        ),
        gravity: ToastGravity.TOP,
        toastDuration: const Duration(seconds: 2),
      );

      imageStatus.value = ImageStatus.saved;
    } else {
      fToast.showToast(
        child: CustomToast.CustomToastContentWidget(
            text: 'Something Went Wrong Try Again'),
        gravity: ToastGravity.TOP,
        toastDuration: const Duration(seconds: 2),
      );
    }
  }
}
