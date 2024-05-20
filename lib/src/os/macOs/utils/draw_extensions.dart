import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:os_ui/os_ui.dart';

extension GenericDeviceFramePainterExtensions on Canvas {
  /// Draws a background wallpaper, adapted to the given [platform].
  void drawDefaultWallpaper({
    required OsType platform,
    required Rect bounds,
  }) {
    final paint = Paint();
    switch (platform) {
      case OsType.macos:
        paint.shader = ui.Gradient.radial(
          Offset(0, bounds.height),
          bounds.width,
          [
            const Color(0xff4817A6),
            const Color(0xffB236AF),
            const Color(0xffC7BDD6),
            const Color(0xffC870A2),
          ],
          [
            0,
            0.390208,
            0.578125,
            0.828125,
          ],
        );
        break;
      case OsType.linux:
        paint.shader = ui.Gradient.radial(
          Offset(0, bounds.height),
          bounds.width,
          [
            const Color(0xffBE15DA),
            const Color(0xffE22888),
            const Color(0xffD84E00),
          ],
          [0, 0.421875, 1],
        );
        break;
      case OsType.windows:
        paint.shader = ui.Gradient.radial(
          Offset(0, bounds.height),
          bounds.width,
          [
            const Color(0xff1491F8).withOpacity(1),
            const Color(0xff0043D8).withOpacity(1)
          ],
          [
            0,
            1,
          ],
        );
        break;
      default:
        paint.shader = ui.Gradient.radial(
          Offset(0, bounds.height),
          bounds.width,
          [
            const Color(0xffBE15DA),
            const Color(0xffE22888),
            const Color(0xffD84E00),
          ],
          [0, 0.421875, 1],
        );
    }
    drawRect(
      bounds,
      paint,
    );
  }
}
