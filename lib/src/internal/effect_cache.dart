// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zego_plugin_adapter/zego_plugin_adapter.dart';

String effectValueKey = 'effectValueKey';
String isSelectKey = 'isSelectKey';
String effectRecordKey = 'effectRecordKey';

class ZegoBeautyEffectRecord {
  factory ZegoBeautyEffectRecord() => instance;
  ZegoBeautyEffectRecord._();
  static final ZegoBeautyEffectRecord instance = ZegoBeautyEffectRecord._();

  Map<String, dynamic>? effectCacheMap;

  Future<Map<String, dynamic>?> getEffectRecord() async {
    final prefs = await SharedPreferences.getInstance();
    String? cacheEffectRecord = prefs.get(effectRecordKey) as String?;
    if (cacheEffectRecord != null && cacheEffectRecord != 'null') {
      Map<String, dynamic> recordMap = jsonDecode(cacheEffectRecord);
      effectCacheMap = recordMap;
    }
    return effectCacheMap;
  }

  void setEffectRecordValue(
      ZegoBeautyPluginEffectsType effectTypeKey, int effectValue) {
    final typeKey = enumToString(effectTypeKey);
    Map<String, dynamic> recordMap = effectCacheMap?[typeKey] ?? {};
    recordMap[effectValueKey] = effectValue;
    effectCacheMap?[typeKey] = recordMap;
  }

  void setEffectRecordSelectState(
      ZegoBeautyPluginEffectsType effectTypeKey, bool isSelect) {
    final typeKey = enumToString(effectTypeKey);
    Map<String, dynamic> recordMap = effectCacheMap?[typeKey] ?? {};
    recordMap[isSelectKey] = isSelect;
    effectCacheMap ??= {};
    effectCacheMap?[typeKey] = recordMap;
  }

  void delectEffectRecord(ZegoBeautyPluginEffectsType effectTypeKey) {
    final typeKey = enumToString(effectTypeKey);
    effectCacheMap?.remove(typeKey);
  }

  Future<void> saveEffectRecord() async {
    final prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(effectCacheMap);
    prefs.setString(effectRecordKey, jsonString);
  }

  Future<void> clearEffectRecord() async {
    final prefs = await SharedPreferences.getInstance();
    effectCacheMap = {};
    prefs.remove(effectRecordKey);
  }

  String enumToString(ZegoBeautyPluginEffectsType type) {
    return type.toString().split('.').last;
  }

  ZegoBeautyPluginEffectsType stringToEnum(String type) {
    return ZegoBeautyPluginEffectsType.values
        .firstWhere((effectsType) => enumToString(effectsType) == type);
  }
}
