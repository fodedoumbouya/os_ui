import 'package:flutter/material.dart';
import 'package:os_ui/src/os/macOs/mac_os.dart';
import 'package:os_ui/src/utils/os_indentifier.dart';
import 'package:os_ui/src/utils/os_type.dart';

class Os extends StatelessWidget {
  /// [osIndentifier] is the object that contains the type of the OS and the controller for the windows.
  final OsIndentifier osIndentifier;

  const Os({
    super.key,
    required this.osIndentifier,
  });

  /// The theme of the OS.
  ThemeData _theme(BuildContext context) {
    final platform = switch (osIndentifier.type) {
      OsType.macos => TargetPlatform.macOS,
      OsType.windows => TargetPlatform.windows,
      OsType.linux => TargetPlatform.linux,
    };

    return Theme.of(context).copyWith(
      platform: platform,
    );
  }

  /// The widget that is displayed when the OS is not supported.
  Widget get _notSupport => Container(
        color: Colors.blue,
        child: const Center(
          child: Text(
            'Not supported for now. Please use macOS. Thank you. 🙏',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
      );

  /// The widget that is displayed when the OS is supported.
  Widget _screen(BuildContext context, OsIndentifier osIndentifier) {
    final mediaQuery = MediaQuery.of(context);
    final screenSize = mediaQuery.size;
    final screen = switch (osIndentifier.type == OsType.macos) {
      true => MacOs(
          windowsManagementController:
              osIndentifier.windowsManagementController,
        ),
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
