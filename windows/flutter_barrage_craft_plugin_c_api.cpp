#include "include/flutter_barrage_craft/flutter_barrage_craft_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "flutter_barrage_craft_plugin.h"

void FlutterBarrageCraftPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  flutter_barrage_craft::FlutterBarrageCraftPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
