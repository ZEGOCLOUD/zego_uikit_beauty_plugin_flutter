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

  /// enableCustomVideoProcessing
  Future<void> enableCustomVideoProcessing() async {
    try {
      await methodChannel.invokeMethod('enableCustomVideoProcessing');
    } on PlatformException catch (e) {
      ZegoBeautyLoggerService.logError(
        'Failed to enable custom video processing: $e.',
        tag: 'beauty',
        subTag: 'channel',
      );
    }
  }

  /// getResourcesFolder
  Future<String?> getResourcesFolder() async {
    String? folder;

    try {
      folder = await methodChannel.invokeMethod<String>('getResourcesFolder');
    } on PlatformException catch (e) {
      ZegoBeautyLoggerService.logError(
        'Failed to get resources folder: $e.',
        tag: 'beauty',
        subTag: 'channel',
      );
    }

    return folder;
  }
}
