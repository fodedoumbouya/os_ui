import 'package:os_ui/src/os/controller/controller.dart';
import 'package:os_ui/src/utils/os_type.dart';

class OsIndentifier {
  /// [OsType] is the type of the OS.
  final OsType type;

  /// [WindowsManagementController] is the controller for managing windows.
  final WindowsManagementController windowsManagementController;

  const OsIndentifier({
    required this.type,
    required this.windowsManagementController,
  });

  @override
  String toString() {
    return 'OsIndentifier(type: $type)';
  }
}
