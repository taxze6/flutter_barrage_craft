#ifndef FLUTTER_PLUGIN_FLUTTER_BARRAGE_CRAFT_PLUGIN_H_
#define FLUTTER_PLUGIN_FLUTTER_BARRAGE_CRAFT_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace flutter_barrage_craft {

class FlutterBarrageCraftPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  FlutterBarrageCraftPlugin();

  virtual ~FlutterBarrageCraftPlugin();

  // Disallow copy and assign.
  FlutterBarrageCraftPlugin(const FlutterBarrageCraftPlugin&) = delete;
  FlutterBarrageCraftPlugin& operator=(const FlutterBarrageCraftPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace flutter_barrage_craft

#endif  // FLUTTER_PLUGIN_FLUTTER_BARRAGE_CRAFT_PLUGIN_H_
