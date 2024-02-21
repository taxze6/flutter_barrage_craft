import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_barrage_craft_method_channel.dart';

abstract class FlutterBarrageCraftPlatform extends PlatformInterface {
  /// Constructs a FlutterBarrageCraftPlatform.
  FlutterBarrageCraftPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterBarrageCraftPlatform _instance = MethodChannelFlutterBarrageCraft();

  /// The default instance of [FlutterBarrageCraftPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterBarrageCraft].
  static FlutterBarrageCraftPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterBarrageCraftPlatform] when
  /// they register themselves.
  static set instance(FlutterBarrageCraftPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
