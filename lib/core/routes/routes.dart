import 'package:face_detector/views/screens/camara_screen/camera_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  Routes._();

  static const String camera = 'camera';
}

class RouteGenerator {
  RouteGenerator._();

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.camera:
        return MaterialPageRoute(
          builder: (context) => CameraScreen(),
        );
      default:
        return null;
    }
  }
}
