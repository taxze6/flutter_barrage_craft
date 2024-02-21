import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_barrage_craft_platform_interface.dart';

/// An implementation of [FlutterBarrageCraftPlatform] that uses method channels.
class MethodChannelFlutterBarrageCraft extends FlutterBarrageCraftPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_barrage_craft');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
