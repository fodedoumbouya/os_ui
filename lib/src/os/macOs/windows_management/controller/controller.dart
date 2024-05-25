// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:os_ui/src/os/macOs/windows_management/model/model.dart';

class WindowsManagementController {
  final _windows = ValueNotifier<List<WindowsModel>>([]);

  final List<WindowsModel> applications;
  WindowsManagementController(
      {required this.applications, this.dockStyle, this.topBarModel}) {
    _windows.value.addAll(applications);
  }
  DockStyle? dockStyle;
  TopBarModel? topBarModel;

  int currentWindow = 0;

  ValueNotifier<List<WindowsModel>> get windows => _windows;

  checkIfWindowExist() {
    if (currentWindow == -1) {
      throw Exception("Window not found");
    }
  }

  void swapToCurrentWindow({int? index}) {
    if (index != null) {
      currentWindow =
          windows.value.indexWhere((element) => element.index == index);
    }
    checkIfWindowExist();
    _windows.value[currentWindow].isCurrentScreen = true;
    sortWindows();
  }

  void addWindow(WindowsModel window) {
    currentWindow =
        windows.value.indexWhere((element) => element.index == window.index);
    checkIfWindowExist();
    _windows.value[currentWindow].isOpenWindow = true;

    sortWindows();
  }

  Future sortWindows() async {
    final currentWindowWidget = _windows.value[currentWindow];
    _windows.value.removeAt(currentWindow);
    _windows.value.add(currentWindowWidget);
    windows.notifyListeners();
    return;
  }

  // void updateWindow(WindowsModel window) {
  //   _windows.value.removeWhere((element) => element.index == window.index);
  //   _windows.value.add(window);
  //   currentWindow = window.index;
  //   windows.notifyListeners();
  // }

  void toGo({required Widget child, WindowsModel? window}) {
    if (window != null) {
      currentWindow =
          windows.value.indexWhere((element) => element.index == window.index);
    }
    checkIfWindowExist();

    _windows.value[currentWindow].isCurrentScreen = true;
    _windows.value[currentWindow].states
        .add(_windows.value[currentWindow].child);
    _windows.value[currentWindow].child = child;
    windows.notifyListeners();
  }

  void goBack({WindowsModel? window}) {
    if (window != null) {
      currentWindow =
          windows.value.indexWhere((element) => element.index == window.index);
    }
    checkIfWindowExist();
    if (_windows.value[currentWindow].states.isEmpty) {
      close(index: currentWindow);
      return;
    }
    _windows.value[currentWindow].isCurrentScreen = true;
    _windows.value[currentWindow].child =
        _windows.value[currentWindow].states.last;
    _windows.value[currentWindow].states.removeLast();
    windows.notifyListeners();
  }

  // void removeWindow(int index) {
  //   _windows.value.removeWhere((element) => element.index == index);
  //   if (_windows.value.isNotEmpty) {
  //     currentWindow = windows.value.last.index;
  //   } else {
  //     currentWindow = -1;
  //   }
  // }

  void closeAllWindow() {
    for (var element in windows.value) {
      element.isOpenWindow = false;
    }
    currentWindow = -1;
    windows.notifyListeners();
  }

  void minimize({int? index}) {
    if (index != null) {
      currentWindow =
          windows.value.indexWhere((element) => element.index == index);
    }
    checkIfWindowExist();
    final w = _windows.value[currentWindow];
    w.isMinimized = true;
    _windows.value.removeAt(currentWindow);
    _windows.value.add(w);
    windows.notifyListeners();
  }

  void maximize({int? index}) {
    if (index != null) {
      currentWindow =
          windows.value.indexWhere((element) => element.index == index);
    }
    checkIfWindowExist();
    final w = _windows.value[currentWindow];
    w.isMinimized = false;
    _windows.value.removeAt(currentWindow);
    _windows.value.add(w);
    windows.notifyListeners();
  }

  void fullScreen({int? index}) async {
    swapToCurrentWindow(index: index);
    if (index != null) {
      currentWindow =
          windows.value.indexWhere((element) => element.index == index);
    }
    checkIfWindowExist();
    _windows.value[currentWindow].isFullScreen = true;
  }

  void unFullScreen({int? index}) {
    if (index != null) {
      currentWindow =
          windows.value.indexWhere((element) => element.index == index);
    }
    checkIfWindowExist();
    sortWindows();

    _windows.value[currentWindow].isFullScreen = false;
  }

  void close({required int index}) {
    currentWindow =
        _windows.value.indexWhere((element) => element.index == index);

    /// set the window to be closed
    _windows.value[currentWindow].isOpenWindow = false;

    windows.notifyListeners();
  }
}
