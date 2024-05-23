// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:os_ui/src/os/macOs/windows_management/model/model.dart';

class WindowsManagementController {
  final _windows = ValueNotifier<List<WindowsModel>>([
    WindowsModel(
        index: 0,
        size: const Size(700, 700),
        iconPosition: AppIconPosition.dock,
        iconUrl:
            "https://cdn.discordapp.com/attachments/1035682064651005972/1242492378154008637/launcher.png?ex=665002f3&is=664eb173&hm=be6cd3748ce73232aa993c28b76f272828d67f1544e550c7c7866b9ec3e64c39&",
        style: WindowsModelStyle(
          barColor: Colors.blue,
          // shadowColor: Colors.transparent,
        ),
        child: Container(
          color: Colors.red,
          alignment: Alignment.center,
        ))
      ..isOpenWindow = true,
  ]);

  int currentWindow = 0;

  ValueNotifier<List<WindowsModel>> get windows => _windows;

  void swapToCurrentWindow({int? index}) {
    if (index != null) {
      currentWindow = index;
    }
    WindowsModel w = _windows.value[currentWindow];
    _windows.value.removeWhere((element) => element.index == currentWindow);
    _windows.value.add(w);
  }

  void addWindow(WindowsModel window) {
    _windows.value.add(window);
    currentWindow = window.index;
  }

  void updateWindow(WindowsModel window) {
    _windows.value.removeWhere((element) => element.index == window.index);
    _windows.value.add(window);
    currentWindow = window.index;
  }

  void toGo({required Widget child, WindowsModel? window}) {
    if (window != null) {
      currentWindow = window.index;
    }
    _windows.value[currentWindow].isCurrentScreen = true;
    _windows.value[currentWindow].states
        .add(_windows.value[currentWindow].child);
    _windows.value[currentWindow].child = child;
  }

  void goBack({WindowsModel? window}) {
    if (window != null) {
      currentWindow = window.index;
    }
    if (_windows.value[currentWindow].states.isEmpty) {
      close(index: currentWindow);
      return;
    }
    _windows.value[currentWindow].isCurrentScreen = true;
    _windows.value[currentWindow].child =
        _windows.value[currentWindow].states.last;
    _windows.value[currentWindow].states.removeLast();
  }

  void removeWindow(int index) {
    _windows.value.removeWhere((element) => element.index == index);
    if (_windows.value.isNotEmpty) {
      currentWindow = windows.value.last.index;
    } else {
      currentWindow = -1;
    }
  }

  void removeAllWindows() {
    windows.value.clear();
    currentWindow = -1;
  }

  void minimize({int? index}) {
    if (index != null) {
      currentWindow = index;
    }
    _windows.value[currentWindow].isMinimized = true;
    windows.notifyListeners();
  }

  void maximize({int? index}) {
    if (index != null) {
      currentWindow = index;
    }
    _windows.value[currentWindow].isMinimized = false;
  }

  void fullScreen({int? index}) {
    if (index != null) {
      currentWindow = index;
    }
    _windows.value[currentWindow].isFullScreen = true;
  }

  void close({required int index}) {
    _windows.value.removeWhere((element) => element.index == index);
    if (_windows.value.isNotEmpty) {
      currentWindow = _windows.value.last.index;
    } else {
      currentWindow = -1;
    }
    windows.notifyListeners();
  }
}
