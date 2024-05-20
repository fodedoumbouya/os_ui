import 'package:os_ui/src/utils/os_type.dart';

class OsIndentifier {
  final String name;

  final OsType type;

  // final TargetPlatform platform;

  const OsIndentifier({
    required this.name,
    required this.type,
    // required this.platform,
  });

  @override
  String toString() {
    return 'OsIndentifier{name: $name, type: $type}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OsIndentifier && other.name == name && other.type == type;
    // other.platform == platform;
  }
}
