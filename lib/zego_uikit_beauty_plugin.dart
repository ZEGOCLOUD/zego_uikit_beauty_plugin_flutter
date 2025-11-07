// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:zego_plugin_adapter/zego_plugin_adapter.dart';

// Project imports:
import 'package:zego_uikit_beauty_plugin/src/define.dart';
import 'package:zego_uikit_beauty_plugin/src/internal/core.dart';
import 'package:zego_uikit_beauty_plugin/src/log/logger_service.dart';
import 'package:zego_uikit_beauty_plugin/src/method_channel.dart';
import 'package:zego_uikit_beauty_plugin/src/components/screen_util/screen_util.dart';

class ZegoUIKitBeautyPlugin implements ZegoBeautyPluginInterface {
  factory ZegoUIKitBeautyPlugin() => instance;

  ZegoUIKitBeautyPlugin._();

  ZegoUIKitBeautyCore core = ZegoUIKitBeautyCore();

  static final ZegoUIKitBeautyPlugin instance = ZegoUIKitBeautyPlugin._();

  Future<String?> getPlatformVersion() {
    return ZegoUIKitBeautyPluginPlatform.instance.getPlatformVersion();
  }

  Size get _designSize => Size(550, 978);

  @override
  ZegoUIKitPluginType getPluginType() => ZegoUIKitPluginType.beauty;

  @override
  Future<String> getVersion() async {
    // zego_uikit_beauty_plugin:
    return '2.0.4';
  }

  @override
  Future<void> setAdvancedConfig(String key, String value) async {}

  @override
  Future<void> init({required int appID, required String appSign}) async {
    await ZegoBeautyLoggerService().initLog();

    ZegoBeautyLoggerService.logInfo(
      'init plugin, appID:$appID, ',
      tag: 'beauty',
      subTag: 'init',
    );

    await core.init(appID: appID, appSign: appSign);
  }

  @override
  void showBeautyUI(BuildContext context) {
    core.showBeautyUI(context, designSize: _designSize);
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
    _initUIConfig(core.effectsConfig.uiConfig);

    core.beautyTranslation = ZegoUIKitBeautyTranslation(config.innerText);
    core.generatedData(config.effectsTypes);
  }

  void _initUIConfig(ZegoBeautyPluginUIConfig uiConfig) {
    _preInitializeScreenUtil();

    uiConfig.backgroundColor ??= const Color.fromARGB(230, 9, 17, 28);
    uiConfig.selectedIconBorderColor ??= Colors.red;
    uiConfig.selectedIconDotColor ??= Colors.red;
    uiConfig.selectedTextStyle ??= TextStyle(
      color: Colors.white,
      fontSize: 14.zR,
    );
    uiConfig.normalTextStyle ??= TextStyle(
      color: Color(0xffC4C4C4),
      fontSize: 14.zR,
    );
    uiConfig.sliderTextStyle ??= TextStyle(
      color: Color(0xff1B1A1C),
      fontSize: 30.zR,
      fontWeight: FontWeight.w400,
    );
    uiConfig.sliderTextBackgroundColor ??= Colors.white;
    uiConfig.sliderActiveTrackColor ??= Colors.red;
    uiConfig.sliderInactiveTrackColor ??= Colors.red.withValues(alpha: 0.3);
    uiConfig.sliderThumbColor ??= Colors.white;
    uiConfig.normalHeaderTitleTextStyle ??= TextStyle(
      color: Color(0xffC4C4C4),
      fontSize: 16.zR,
    );
    uiConfig.selectHeaderTitleTextStyle ??= TextStyle(
      color: Colors.white,
      fontSize: 16.zR,
    );
  }

  void _preInitializeScreenUtil() {
    try {
      /// test is init or not
      ZegoBeautyScreenUtil().screenWidth;
      return;
    } catch (_) {
      /// not init
    }

    /// create default MediaQueryData
    const defaultSize = Size(375, 812);
    final defaultMediaQueryData = MediaQueryData(
      size: defaultSize,
      devicePixelRatio: 2.0,
      textScaler: const TextScaler.linear(1.0),
      platformBrightness: Brightness.light,
      accessibleNavigation: false,
      invertColors: false,
      disableAnimations: false,
      boldText: false,
      padding: EdgeInsets.zero,
      viewInsets: EdgeInsets.zero,
      viewPadding: EdgeInsets.zero,
      systemGestureInsets: EdgeInsets.zero,
      alwaysUse24HourFormat: false,
      highContrast: false,
      onOffSwitchLabels: false,
      navigationMode: NavigationMode.traditional,
    );

    /// init ZegoBeautyScreenUtil by default
    ZegoBeautyScreenUtil.configure(
      data: defaultMediaQueryData,
      designSize: _designSize,
      splitScreenMode: true,
      minTextAdapt: true,
    );
  }

  @override
  Future<void> setBeautyParams(
    List<ZegoBeautyParamConfig> paramConfigList, {
    bool forceUpdateCache = false,
  }) async {
    core.setBeautyParams(paramConfigList, forceUpdateCache: forceUpdateCache);
  }

  @override
  Stream<ZegoBeautyPluginFaceDetectionData> getFaceDetectionEventStream() {
    return ZegoUIKitBeautyPlugin
        .instance.core.faceDetectionDataStreamCtrl.stream;
  }

  @override
  Stream<ZegoBeautyError> getErrorStream() {
    return ZegoUIKitBeautyPlugin.instance.core.errorStreamCtrl.stream;
  }
}
