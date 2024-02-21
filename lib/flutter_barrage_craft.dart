
import 'flutter_barrage_craft_platform_interface.dart';

class FlutterBarrageCraft {
  Future<String?> getPlatformVersion() {
    return FlutterBarrageCraftPlatform.instance.getPlatformVersion();
  }
}
