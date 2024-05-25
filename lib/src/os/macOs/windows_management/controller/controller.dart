// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:os_ui/src/os/macOs/windows_management/model/model.dart';

/// The controller class for managing windows in a macOS-like interface.
class WindowsManagementController {
  final _windows = ValueNotifier<List<WindowsModel>>([]);

  final List<WindowsModel> applications;
  WindowsManagementController(
      {required this.applications,
      required this.launchIconPath,
      this.dockStyle,
      this.topBarModel}) {
    /// Add the launcher to the list of windows.
    _windows.value.add(_launcher(launchIconPath));

    /// Add the applications to the list of windows.
    _windows.value.addAll(applications);
  }
  String launchIconPath;
  DockStyle? dockStyle;
  TopBarModel? topBarModel;

  int currentWindow = 0;

  /// Get the value notifier for the list of windows.
  ValueNotifier<List<WindowsModel>> get windows => _windows;

  /// Check if the current window exists. Throws an exception if it doesn't.
  checkIfWindowExist() {
    if (currentWindow == -1) {
      throw Exception("Window not found");
    }
  }

  /// Swap to the window with the specified index.
  void swapToCurrentWindow({int? index}) {
    if (index != null) {
      currentWindow =
          windows.value.indexWhere((element) => element.index == index);
    }
    checkIfWindowExist();
    _windows.value[currentWindow].isCurrentScreen = true;
    sortWindows();
  }

  /// Add a new window to the list of windows.
  void addWindow(WindowsModel window) {
    currentWindow =
        windows.value.indexWhere((element) => element.index == window.index);
    checkIfWindowExist();
    _windows.value[currentWindow].isOpenWindow = true;

    sortWindows();
  }

  /// Sort the windows based on the current window.
  Future sortWindows() async {
    final currentWindowWidget = _windows.value[currentWindow];
    _windows.value.removeAt(currentWindow);
    _windows.value.add(currentWindowWidget);
    windows.notifyListeners();
    return;
  }

  /// Transition to a new screen within the current window.
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

  /// Go back to the previous screen within the current window.
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

  /// Close all windows.
  void closeAllWindow() {
    for (var element in windows.value) {
      element.isOpenWindow = false;
    }
    currentWindow = -1;
    windows.notifyListeners();
  }

  /// Minimize the window with the specified index.
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

  /// Maximize the window with the specified index.
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

  /// Set the window with the specified index to full screen mode.
  void fullScreen({int? index}) async {
    swapToCurrentWindow(index: index);
    if (index != null) {
      currentWindow =
          windows.value.indexWhere((element) => element.index == index);
    }
    checkIfWindowExist();
    _windows.value[currentWindow].isFullScreen = true;
  }

  /// Set the window with the specified index to normal screen mode.
  void unFullScreen({int? index}) {
    if (index != null) {
      currentWindow =
          windows.value.indexWhere((element) => element.index == index);
    }
    checkIfWindowExist();
    sortWindows();

    _windows.value[currentWindow].isFullScreen = false;
  }

  /// Close the window with the specified index.
  void close({required int index}) {
    currentWindow =
        _windows.value.indexWhere((element) => element.index == index);

    /// set the window to be closed and initialize the window
    _windows.value[currentWindow].isOpenWindow = false;
    _windows.value[currentWindow].isMinimized = false;
    _windows.value[currentWindow].isFullScreen = false;
    _windows.value[currentWindow].isCurrentScreen = false;
    _windows.value[currentWindow].states = [];
    windows.notifyListeners();
  }
}

WindowsModel _launcher(String iconUrl) => WindowsModel(
    size: Size.zero,
    name: "Launcher",
    iconUrl: iconUrl,
    iconPosition: AppIconPosition.dock,
    child: const SizedBox.shrink())
  ..index = 0
  ..isLaunchpad = true;
