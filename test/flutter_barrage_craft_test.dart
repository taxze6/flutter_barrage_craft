import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_barrage_craft/flutter_barrage_craft.dart';
import 'package:flutter_barrage_craft/flutter_barrage_craft_platform_interface.dart';
import 'package:flutter_barrage_craft/flutter_barrage_craft_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterBarrageCraftPlatform
    with MockPlatformInterfaceMixin
    implements FlutterBarrageCraftPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterBarrageCraftPlatform initialPlatform = FlutterBarrageCraftPlatform.instance;

  test('$MethodChannelFlutterBarrageCraft is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterBarrageCraft>());
  });

  test('getPlatformVersion', () async {
    FlutterBarrageCraft flutterBarrageCraftPlugin = FlutterBarrageCraft();
    MockFlutterBarrageCraftPlatform fakePlatform = MockFlutterBarrageCraftPlatform();
    FlutterBarrageCraftPlatform.instance = fakePlatform;

    expect(await flutterBarrageCraftPlugin.getPlatformVersion(), '42');
  });
}
