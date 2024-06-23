#ifndef FLUTTER_PLUGIN_OS_UI_PLUGIN_H_
#define FLUTTER_PLUGIN_OS_UI_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace os_ui {

class OsUiPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  OsUiPlugin();

  virtual ~OsUiPlugin();

  // Disallow copy and assign.
  OsUiPlugin(const OsUiPlugin&) = delete;
  OsUiPlugin& operator=(const OsUiPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace os_ui

#endif  // FLUTTER_PLUGIN_OS_UI_PLUGIN_H_
