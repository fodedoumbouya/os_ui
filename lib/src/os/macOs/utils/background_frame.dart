import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:os_ui/os_ui.dart';
import 'package:os_ui/src/os/macOs/utils/draw_extensions.dart';

//Copy this CustomPainter code to the Bottom of the File
class MacOsPainter extends CustomPainter {
  final Size windowSize;
  MacOsPainter({required this.windowSize});
  @override
  void paint(Canvas canvas, Size size) {
    final screenBounds =
        Rect.fromLTWH(0, 0, windowSize.width, windowSize.height);

    canvas.drawDefaultWallpaper(
      platform: OsType.macos,
      bounds: screenBounds,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
