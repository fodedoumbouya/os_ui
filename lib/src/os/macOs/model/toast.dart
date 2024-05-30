import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MacOsToast {
  /// [toastDecoration] is a decoration that holds the style of the toast.
  Decoration? toastDecoration;

  /// [autoDismiss] is a boolean that holds the state of the toast.
  bool autoDismiss;

  /// [duration] is a duration that holds the time the toast is shown.
  Duration? duration;

  /// [showToast] is a ValueNotifier that holds the state of the toast.
  final showToast = ValueNotifier<bool>(false);

  /// [leading] is a widget that holds the leading widget of the toast.
  Widget? leading;

  /// [content] is a widget that holds the content of the toast.
  Widget? content;

  /// [title] is a widget that holds the title of the toast.
  Widget? title;

  /// [trailing] is a widget that holds the trailing widget of the toast.
  Widget? trailing;

  /// [contentPadding] is an EdgeInsetsGeometry that holds the padding of the content.
  EdgeInsetsGeometry? contentPadding;

  /// [MacOsToast] is a constructor that creates an instance of [MacOsToast].
  MacOsToast({
    this.toastDecoration,
    this.autoDismiss = true,
    this.duration = const Duration(seconds: 2),
  });
}
