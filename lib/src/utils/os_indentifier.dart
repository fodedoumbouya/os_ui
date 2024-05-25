import 'package:os_ui/src/os/macOs/windows_management/controller/controller.dart';
import 'package:os_ui/src/utils/os_type.dart';

class OsIndentifier {
  final OsType type;

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
