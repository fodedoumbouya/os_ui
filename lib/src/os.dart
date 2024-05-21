import 'package:flutter/material.dart';
import 'package:os_ui/src/controller/controller.dart';
import 'package:os_ui/src/os/macOs/mac_os.dart';
import 'package:os_ui/src/utils/os_indentifier.dart';
import 'package:os_ui/src/utils/os_type.dart';

class Os extends StatelessWidget {
  final OsController osController;

  final OsIndentifier osIndentifier;

  /// [deviceOccupySize] is the size of the device in the screen
  final double? deviceOccupySize;

  const Os({
    super.key,
    required this.osController,
    required this.osIndentifier,
    this.deviceOccupySize,
  });

  ThemeData _theme(BuildContext context) {
    final platform = switch (osIndentifier.type) {
      OsType.macos => TargetPlatform.macOS,
      OsType.windows => TargetPlatform.windows,
      OsType.linux => TargetPlatform.linux,
    };

    return Theme.of(context).copyWith(
      platform: platform,
      // visualDensity: density,
    );
  }

  Widget get _notSupport => Container(
        color: Colors.blue,
        child: const Center(
          child: Text(
            'Not supported',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
      );

  Widget _screen(BuildContext context, OsIndentifier osIndentifier) {
    final mediaQuery = MediaQuery.of(context);
    final screenSize = mediaQuery.size;
    final screen = switch (osIndentifier.type == OsType.macos) {
      true => const MacOs(),
      false => _notSupport,
    };
    return SizedBox(
      width: screenSize.width,
      height: screenSize.height,
      child: Theme(
        data: _theme(context),
        child: screen,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: _screen(context, osIndentifier),
    );
  }
}
