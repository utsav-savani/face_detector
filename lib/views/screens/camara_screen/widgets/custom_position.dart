import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomPositionWidget extends StatelessWidget {
  final Offset offset;
  final bool visible;

  final void Function(Velocity, Offset)? onDraggableCanceled;

  const CustomPositionWidget(
      {super.key,
      required this.offset,
      required this.visible,
      required this.onDraggableCanceled});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Positioned(
        left: offset.dx,
        top: offset.dy,
        child: Draggable(
          feedback: Container(
            width: 50.w,
            height: 20.h,
            decoration: BoxDecoration(
              color: Color(0xFF01FF0B).withOpacity(0.5),
              borderRadius: new BorderRadius.all(Radius.elliptical(100, 50)),
            ),
          ),
          childWhenDragging: const SizedBox.shrink(),
          onDraggableCanceled: onDraggableCanceled,
          child: Container(
            width: 50.w,
            height: 20.h,
            decoration: BoxDecoration(
              color: Color(0xFF01FF0B).withOpacity(0.5),
              borderRadius: new BorderRadius.all(Radius.elliptical(100, 50)),
            ),
          ),
        ),
      ),
    );
  }
}
