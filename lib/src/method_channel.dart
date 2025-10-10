// Flutter imports:
import 'package:flutter/services.dart';

// Project imports:
import 'log/logger_service.dart';

/// ZegoUIKitBeautyPluginPlatform
class ZegoUIKitBeautyPluginPlatform {
  static final ZegoUIKitBeautyPluginPlatform _instance =
      ZegoUIKitBeautyPluginPlatform();

  static ZegoUIKitBeautyPluginPlatform get instance => _instance;

  final methodChannel = const MethodChannel('zego_uikit_beauty_plugin');

  /// getPlatformVersion
  Future<String?> getPlatformVersion() async {
    String? version;

    try {
      version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    } on PlatformException catch (e) {
      ZegoBeautyLoggerService.logError(
        'Failed to get platform version: $e.',
        tag: 'beauty',
        subTag: 'channel',
      );
    }

    return version;
  }
}
