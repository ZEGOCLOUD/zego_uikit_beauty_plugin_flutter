// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:zego_plugin_adapter/zego_plugin_adapter.dart';

// Project imports:
import 'package:zego_uikit_beauty_plugin/src/define.dart';
import 'package:zego_uikit_beauty_plugin/src/internal/core.dart';
import 'package:zego_uikit_beauty_plugin/src/log/logger_service.dart';
import 'package:zego_uikit_beauty_plugin/src/method_channel.dart';

class ZegoUIKitBeautyPlugin implements ZegoBeautyPluginInterface {
  factory ZegoUIKitBeautyPlugin() => instance;

  ZegoUIKitBeautyPlugin._();

  ZegoUIKitBeautyCore core = ZegoUIKitBeautyCore();

  static final ZegoUIKitBeautyPlugin instance = ZegoUIKitBeautyPlugin._();

  Future<String?> getPlatformVersion() {
    return ZegoUIKitBeautyPluginPlatform.instance.getPlatformVersion();
  }

  @override
  ZegoUIKitPluginType getPluginType() => ZegoUIKitPluginType.beauty;

  @override
  Future<String> getVersion() async {
    return '';
  }

  @override
  Future<void> setAdvancedConfig(String key, String value) async {}

  @override
  Future<void> init({
    required int appID,
    String appSign = '',
    String licence = '',
  }) async {
    await ZegoBeautyLoggerService().initLog();

    ZegoBeautyLoggerService.logInfo(
      'init plugin, appID:$appID, '
      'has appSign:${appSign.isNotEmpty}, '
      'has license:${licence.isNotEmpty}',
      tag: 'beauty',
      subTag: 'init',
    );

    await core.init(
      appID: appID,
      appSign: appSign,
      licence: licence,
    );
  }

  @override
  void showBeautyUI(BuildContext context) {
    core.showBeautyUI(context);
  }

  @override
  void uninit() {
    ZegoBeautyLoggerService.logInfo(
      'destroy effects',
      tag: 'beauty',
      subTag: 'uninit',
    );
    core.unInit();
  }

  @override
  void setConfig(ZegoBeautyPluginConfig config) {
    core.effectsConfig = config;
    core.beautyTranslation = ZegoUIKitBeautyTranslation(config.innerText);
    core.generatedData(config.effectsTypes);
  }

  @override
  Future<void> setBeautyParams(List<ZegoBeautyParamConfig> paramConfigList,
      {bool forceUpdateCache = false}) async {
    core.setBeautyParams(paramConfigList, forceUpdateCache: forceUpdateCache);
  }

  @override
  Stream<ZegoBeautyPluginFaceDetectionData> getFaceDetectionEventStream() {
    return const Stream.empty();
  }

  @override
  Stream<ZegoBeautyError> getErrorStream() {
    return ZegoUIKitBeautyPlugin.instance.core.errorStreamCtrl.stream;
  }
}
