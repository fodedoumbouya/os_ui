import 'package:flutter/material.dart';
import 'package:os_ui/src/os/macOs/windows_management/model/model.dart';

class WindowsManagementController {
  final List<WindowsModel> _windows = [
    WindowsModel(
        index: 0,
        size: const Size(700, 700),
        color: Colors.red,
        // position: const Offset(700, 400),
        screenName: "screenName",
        child: Container()),
  ];

  int currentWindow = 0;

  List<WindowsModel> get windows => _windows;

  void swapToCurrentWindow({int? index}) {
    if (index != null) {
      currentWindow = index;
    }
    WindowsModel w = _windows[currentWindow];
    _windows.removeWhere((element) => element.index == currentWindow);
    _windows.add(w);
  }

  void addWindow(WindowsModel window) {
    _windows.add(window);
    currentWindow = window.index;
  }

  void updateWindow(WindowsModel window) {
    _windows.removeWhere((element) => element.index == window.index);
    _windows.add(window);
    currentWindow = window.index;
  }

  void toGo({required Widget child, WindowsModel? window}) {
    if (window != null) {
      currentWindow = window.index;
    }
    _windows[currentWindow].isCurrentScreen = true;
    _windows[currentWindow].states.add(_windows[currentWindow].child);
    _windows[currentWindow].child = child;
  }

  void goBack({WindowsModel? window}) {
    if (window != null) {
      currentWindow = window.index;
    }
    if (_windows[currentWindow].states.isEmpty) {
      close(index: currentWindow);
      return;
    }
    _windows[currentWindow].isCurrentScreen = true;
    _windows[currentWindow].child = _windows[currentWindow].states.last;
    _windows[currentWindow].states.removeLast();
  }

  void removeWindow(int index) {
    _windows.removeWhere((element) => element.index == index);
    if (_windows.isNotEmpty) {
      currentWindow = windows.last.index;
    } else {
      currentWindow = -1;
    }
  }

  void removeAllWindows() {
    windows.clear();
    currentWindow = -1;
  }

  void minimize({int? index}) {
    if (index != null) {
      currentWindow = index;
    }
    _windows[currentWindow].isMinimized = true;
  }

  void maximize({int? index}) {
    if (index != null) {
      currentWindow = index;
    }
    _windows[currentWindow].isMinimized = false;
  }

  void fullScreen({int? index}) {
    if (index != null) {
      currentWindow = index;
    }
    _windows[currentWindow].isFullScreen = true;
  }

  void close({required int index}) {
    _windows.removeWhere((element) => element.index == index);
    if (_windows.isNotEmpty) {
      currentWindow = _windows.last.index;
    } else {
      currentWindow = -1;
    }
  }
}
