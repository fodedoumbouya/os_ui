import 'package:flutter/material.dart';

class CommonSizes {
  CommonSizes({
    required this.areaHeight,
    required this.areaWidth,
    required this.height,
    required this.width,
    required this.minWidth,
    required this.minHeight,
    required this.initialPosition,
  });

  final double areaHeight;
  final double areaWidth;
  final double height;
  final double width;
  final double minWidth;
  final double minHeight;
  final Offset initialPosition;

  @override
  String toString() {
    return 'CommonSizes{areaHeight: $areaHeight, areaWidth: $areaWidth, height: $height, width: $width, minWidth: $minWidth, minHeight: $minHeight, initialPosition: $initialPosition}';
  }
}
