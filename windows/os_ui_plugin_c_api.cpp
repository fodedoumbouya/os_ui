#include "include/os_ui/os_ui_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "os_ui_plugin.h"

void OsUiPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  os_ui::OsUiPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
