// Dart imports:
import 'dart:async';
import 'dart:math';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:zego_effects_plugin/zego_effects_defines.dart';
import 'package:zego_effects_plugin/zego_effects_plugin.dart';
import 'package:zego_plugin_adapter/zego_plugin_adapter.dart';

// Project imports:
import 'package:zego_uikit_beauty_plugin/src/define.dart';
import 'package:zego_uikit_beauty_plugin/src/internal/effect_cache.dart';
import 'package:zego_uikit_beauty_plugin/src/internal/effect_setting.dart';
import 'package:zego_uikit_beauty_plugin/src/internal/ui_display.dart';
import 'package:zego_uikit_beauty_plugin/src/log/logger_service.dart';
import 'package:zego_uikit_beauty_plugin/src/models/model.dart';

class ZegoUIKitBeautyCore {
  int appID = 0;
  String appSign = '';

  ZegoBeautyPluginConfig effectsConfig = ZegoBeautyPluginConfig();

  ZegoBeautyMainModel? mainModel;

  ValueNotifier<bool> isSelectStyleMakeup = ValueNotifier(false);
  ValueNotifier<bool> isSelectMakeup = ValueNotifier(false);

  ZegoBeautyItemModel? lastStyleMakeupModel;
  ZegoBeautyItemModel? lastFilterModel;
  ZegoBeautyItemModel? lastBackgroundModel;

  ZegoUIKitBeautyTranslation beautyTranslation =
      ZegoUIKitBeautyTranslation(ZegoBeautyPluginInnerText());

  ZegoBeautyUIDisplay uiDisplay = ZegoBeautyUIDisplay();

  String resourceFolder = '';

  StreamController<ZegoBeautyError> errorStreamCtrl =
      StreamController<ZegoBeautyError>.broadcast();

  /// init
  Future<void> init({
    required int appID,
    required String appSign,
  }) async {
    this.appID = appID;
    this.appSign = appSign;

    initEffects(appID, appSign);
  }

  /// initEventHandler
  void initEventHandler() {
    ZegoEffectsPlugin.registerEventCallback(
      onEffectsError: onEffectsError,
    );
  }

  /// uninitEventHandler
  void uninitEventHandler() {
    ZegoEffectsPlugin.destroyEventCallback();
  }

  /// onEffectsError
  Future<void> onEffectsError(int errorCode, String desc) async {
    ZegoBeautyLoggerService.logInfo(
      'errorCode: $errorCode, '
      'desc:$desc, ',
      tag: 'beauty',
      subTag: 'onEffectsError',
    );

    errorStreamCtrl.add(
      ZegoBeautyError(
        code: errorCode,
        message: desc,
        method: 'onEffectsError',
      ),
    );
  }

  /// onEffectsFaceDetected
  Future<void> onEffectsFaceDetected(
    double score,
    Point point,
    Size size,
  ) async {
    // ZegoBeautyLoggerService.logInfo(
    //   'score: $score, point: $point, size: $size',
    //   tag: 'beauty',
    //   subTag: 'onEffectsFaceDetected',
    // );
  }

  Future<void> setBeautyParams(List<ZegoBeautyParamConfig> paramConfigList,
      {bool forceUpdateCache = false}) async {
    if (forceUpdateCache) {
      await ZegoBeautyEffectRecord.instance.clearEffectRecord();
    } else {
      final cacheRecord =
          await ZegoBeautyEffectRecord.instance.getEffectRecord();
      if (cacheRecord != null && cacheRecord.entries.isNotEmpty) {
        return;
      }
    }
    for (var paramConfig in paramConfigList) {
      ZegoBeautyEffectRecord.instance
          .setEffectRecordValue(paramConfig.type, paramConfig.value);
      ZegoBeautyEffectRecord.instance
          .setEffectRecordSelectState(paramConfig.type, paramConfig.isSelected);
    }
    ZegoBeautyEffectRecord.instance.saveEffectRecord();
  }

  /// generatedData
  Future<void> generatedData(
      List<ZegoBeautyPluginEffectsType> effectsType) async {
    List<ZegoBeautyItemBaseModel> basicBeautyItemModels = [];
    List<ZegoBeautyItemBaseModel> advanceBeautyItemModels = [];
    List<ZegoBeautyItemBaseModel> lipStickBeautyItemModels = [];
    List<ZegoBeautyItemBaseModel> blusherBeautyItemModels = [];
    List<ZegoBeautyItemBaseModel> eyelashesBeautyItemModels = [];
    List<ZegoBeautyItemBaseModel> eyelinerBeautyItemModels = [];
    List<ZegoBeautyItemBaseModel> eyeshadowBeautyItemModels = [];
    List<ZegoBeautyItemBaseModel> coloredBeautyItemModels = [];
    List<ZegoBeautyItemBaseModel> styleMakeupBeautyItemModels = [];

    List<ZegoBeautyItemBaseModel> filterNatureItemModels = [];
    List<ZegoBeautyItemBaseModel> filterGrayItemModels = [];
    List<ZegoBeautyItemBaseModel> filterDreamItemModels = [];

    List<ZegoBeautyItemBaseModel> backgroundItemModels = [];

    List<ZegoTwoLevelBaseTabModel> beautyTabModels = [];
    List<ZegoTwoLevelBaseTabModel> filterTabModels = [];
    List<ZegoTwoLevelBaseTabModel> backgroundTabModels = [];
    List<ZegoBeautyMakeUpModel> makeupBeautyItemModels = [];

    List<ZegoBeautyPluginEffectsType> newEffectsType =
        effectsType.toSet().toList();

    for (ZegoBeautyPluginEffectsType type in newEffectsType) {
      String title = beautyTranslation.beautyMap[type.toString()] ?? '';
      Map<String, dynamic> record =
          await ZegoBeautyEffectRecord.instance.getEffectRecord() ?? {};
      int value = -9999;
      bool isSelect = false;
      String effectKey = ZegoBeautyEffectRecord.instance.enumToString(type);
      if (record.containsKey(effectKey)) {
        Map? effectRecord = record[effectKey] as Map?;
        if (effectRecord != null) {
          if (effectRecord.containsKey(effectValueKey)) {
            value = effectRecord[effectValueKey];
          }
          if (effectRecord.containsKey(isSelectKey)) {
            isSelect = effectRecord[isSelectKey];
          }
        }
      }
      if (ZegoUIKitBeautyTranslation.basicEffectsTypes().contains(type)) {
        //basic
        basicBeautyItemModels.add(
          ZegoBeautyItemModel(
            title,
            ValueNotifier(isSelect),
            type,
            ValueNotifier(value == -9999 ? 50 : value),
          ),
        );
      } else if (ZegoUIKitBeautyTranslation.advancedEffectsTypes()
          .contains(type)) {
        //advance
        setAdvancedModel(type, title, advanceBeautyItemModels);
      } else if (ZegoUIKitBeautyTranslation.stypeMakeupEffectsTypes()
          .contains(type)) {
        //style makeup
        ZegoBeautyItemModel styleMakeupModel = ZegoBeautyItemModel(
          title,
          ValueNotifier(isSelect),
          type,
          ValueNotifier(value == -9999 ? 50 : value),
        );
        if (isSelect) {
          isSelectStyleMakeup.value = true;
          lastStyleMakeupModel = styleMakeupModel;
        }
        styleMakeupBeautyItemModels.add(styleMakeupModel);
      } else if (ZegoUIKitBeautyTranslation.makeupLipstickEffectsTypes()
          .contains(type)) {
        //lipstick
        lipStickBeautyItemModels.add(
          ZegoBeautyItemModel(
            title,
            ValueNotifier(isSelect),
            type,
            ValueNotifier(value == -9999 ? 80 : value),
          ),
        );
      } else if (ZegoUIKitBeautyTranslation.makeupBlusherEffectsTypes()
          .contains(type)) {
        blusherBeautyItemModels.add(
          ZegoBeautyItemModel(
            title,
            ValueNotifier(isSelect),
            type,
            ValueNotifier(value == -9999 ? 80 : value),
          ),
        );
      } else if (ZegoUIKitBeautyTranslation.makeupEyelashesEffectsTypes()
          .contains(type)) {
        eyelashesBeautyItemModels.add(
          ZegoBeautyItemModel(
            title,
            ValueNotifier(isSelect),
            type,
            ValueNotifier(value == -9999 ? 100 : value),
          ),
        );
      } else if (ZegoUIKitBeautyTranslation.makeupEyelinerEffectsTypes()
          .contains(type)) {
        eyelinerBeautyItemModels.add(
          ZegoBeautyItemModel(
            title,
            ValueNotifier(isSelect),
            type,
            ValueNotifier(value == -9999 ? 60 : value),
          ),
        );
      } else if (ZegoUIKitBeautyTranslation.makeupEyeshadowEffectsTypes()
          .contains(type)) {
        eyeshadowBeautyItemModels.add(
          ZegoBeautyItemModel(
            title,
            ValueNotifier(isSelect),
            type,
            ValueNotifier(value == -9999 ? 80 : value),
          ),
        );
      } else if (ZegoUIKitBeautyTranslation.makeupColoredContactsEffectsTypes()
          .contains(type)) {
        coloredBeautyItemModels.add(
          ZegoBeautyItemModel(
            title,
            ValueNotifier(isSelect),
            type,
            ValueNotifier(value == -9999 ? 80 : value),
          ),
        );
      } else if (ZegoUIKitBeautyTranslation.filterNaturalEffectsTypes()
          .contains(type)) {
        ZegoBeautyItemModel filterModel = ZegoBeautyItemModel(
          title,
          ValueNotifier(isSelect),
          type,
          ValueNotifier(value == -9999 ? 50 : value),
        );
        if (isSelect) {
          lastFilterModel = filterModel;
        }
        filterNatureItemModels.add(filterModel);
      } else if (ZegoUIKitBeautyTranslation.filterGrayEffectsTypes()
          .contains(type)) {
        ZegoBeautyItemModel filterModel = ZegoBeautyItemModel(
          title,
          ValueNotifier(isSelect),
          type,
          ValueNotifier(value == -9999 ? 50 : value),
        );
        if (isSelect) {
          lastFilterModel = filterModel;
        }
        filterGrayItemModels.add(filterModel);
      } else if (ZegoUIKitBeautyTranslation.filterDreamyEffectsTypes()
          .contains(type)) {
        ZegoBeautyItemModel filterModel = ZegoBeautyItemModel(
          title,
          ValueNotifier(isSelect),
          type,
          ValueNotifier(value == -9999 ? 50 : value),
        );
        if (isSelect) {
          lastFilterModel = filterModel;
        }
        filterDreamItemModels.add(filterModel);
      } else if (ZegoUIKitBeautyTranslation.backgroundEffectsTypes()
          .contains(type)) {
        ZegoBeautyItemModel backgroundModel = ZegoBeautyItemModel(
          title,
          ValueNotifier(isSelect),
          type,
          ValueNotifier(value == -9999 ? 50 : value),
        );
        if (isSelect) {
          lastBackgroundModel = backgroundModel;
        }
        backgroundItemModels.add(backgroundModel);
      }
    }

    if (lipStickBeautyItemModels.isNotEmpty) {
      bool lipStikcIsSelect = makeupItemIsSelect(lipStickBeautyItemModels);
      lipStickBeautyItemModels.insert(
        0,
        ZegoBeautyItemCleanModel(
          beautyTranslation.beautyMap[
                  ZegoUIKitBeautyResetType.originalDraw.toString()] ??
              '',
          ZegoUIKitBeautyResetType.originalDraw,
          ZegoUIKitResetEffectType.beautyMakeupLipSticker,
        ),
      );
      ZegoBeautyMakeUpModel model = ZegoBeautyMakeUpModel(
        beautyTranslation
                .beautyMap[ZegoUIKitBeautyMakeupType.lipstick.toString()] ??
            '',
        ZegoUIKitBeautyMakeupType.lipstick,
        lipStickBeautyItemModels,
        ValueNotifier(lipStikcIsSelect),
      );
      makeupBeautyItemModels.add(model);
    }

    if (blusherBeautyItemModels.isNotEmpty) {
      bool blusherIsSelect = makeupItemIsSelect(blusherBeautyItemModels);
      blusherBeautyItemModels.insert(
        0,
        ZegoBeautyItemCleanModel(
          beautyTranslation.beautyMap[
                  ZegoUIKitBeautyResetType.originalDraw.toString()] ??
              '',
          ZegoUIKitBeautyResetType.originalDraw,
          ZegoUIKitResetEffectType.beautyMakeupBlusher,
        ),
      );
      ZegoBeautyMakeUpModel model = ZegoBeautyMakeUpModel(
        beautyTranslation
                .beautyMap[ZegoUIKitBeautyMakeupType.blusher.toString()] ??
            '',
        ZegoUIKitBeautyMakeupType.blusher,
        blusherBeautyItemModels,
        ValueNotifier(blusherIsSelect),
      );

      makeupBeautyItemModels.add(model);
    }

    if (eyelashesBeautyItemModels.isNotEmpty) {
      bool eyelashesIsSelect = makeupItemIsSelect(eyelashesBeautyItemModels);
      eyelashesBeautyItemModels.insert(
        0,
        ZegoBeautyItemCleanModel(
          beautyTranslation.beautyMap[
                  ZegoUIKitBeautyResetType.originalDraw.toString()] ??
              '',
          ZegoUIKitBeautyResetType.originalDraw,
          ZegoUIKitResetEffectType.beautyMakeupEyelashes,
        ),
      );
      ZegoBeautyMakeUpModel model = ZegoBeautyMakeUpModel(
        beautyTranslation
                .beautyMap[ZegoUIKitBeautyMakeupType.eyelashes.toString()] ??
            '',
        ZegoUIKitBeautyMakeupType.eyelashes,
        eyelashesBeautyItemModels,
        ValueNotifier(eyelashesIsSelect),
      );

      makeupBeautyItemModels.add(model);
    }

    if (eyelinerBeautyItemModels.isNotEmpty) {
      bool eyelinerIsSelect = makeupItemIsSelect(eyelinerBeautyItemModels);
      eyelinerBeautyItemModels.insert(
        0,
        ZegoBeautyItemCleanModel(
          beautyTranslation.beautyMap[
                  ZegoUIKitBeautyResetType.originalDraw.toString()] ??
              '',
          ZegoUIKitBeautyResetType.originalDraw,
          ZegoUIKitResetEffectType.beautyMakeupEyeliner,
        ),
      );
      ZegoBeautyMakeUpModel model = ZegoBeautyMakeUpModel(
        beautyTranslation
                .beautyMap[ZegoUIKitBeautyMakeupType.eyeliner.toString()] ??
            '',
        ZegoUIKitBeautyMakeupType.eyeliner,
        eyelinerBeautyItemModels,
        ValueNotifier(eyelinerIsSelect),
      );

      makeupBeautyItemModels.add(model);
    }

    if (eyeshadowBeautyItemModels.isNotEmpty) {
      bool eyeshadowIsSelect = makeupItemIsSelect(eyeshadowBeautyItemModels);
      eyeshadowBeautyItemModels.insert(
        0,
        ZegoBeautyItemCleanModel(
          beautyTranslation.beautyMap[
                  ZegoUIKitBeautyResetType.originalDraw.toString()] ??
              '',
          ZegoUIKitBeautyResetType.originalDraw,
          ZegoUIKitResetEffectType.beautyMakeupEyeshadow,
        ),
      );
      ZegoBeautyMakeUpModel model = ZegoBeautyMakeUpModel(
        beautyTranslation
                .beautyMap[ZegoUIKitBeautyMakeupType.eyeshadow.toString()] ??
            '',
        ZegoUIKitBeautyMakeupType.eyeshadow,
        eyeshadowBeautyItemModels,
        ValueNotifier(eyeshadowIsSelect),
      );

      makeupBeautyItemModels.add(model);
    }

    if (coloredBeautyItemModels.isNotEmpty) {
      bool coloredIsSelect = makeupItemIsSelect(coloredBeautyItemModels);
      coloredBeautyItemModels.insert(
        0,
        ZegoBeautyItemCleanModel(
          beautyTranslation.beautyMap[
                  ZegoUIKitBeautyResetType.originalDraw.toString()] ??
              '',
          ZegoUIKitBeautyResetType.originalDraw,
          ZegoUIKitResetEffectType.beautyMakeupColor,
        ),
      );
      ZegoBeautyMakeUpModel model = ZegoBeautyMakeUpModel(
        beautyTranslation
                .beautyMap[ZegoUIKitBeautyMakeupType.color.toString()] ??
            '',
        ZegoUIKitBeautyMakeupType.color,
        coloredBeautyItemModels,
        ValueNotifier(coloredIsSelect),
      );

      makeupBeautyItemModels.add(model);
    }

    if (basicBeautyItemModels.isNotEmpty) {
      basicBeautyItemModels.insert(
        0,
        ZegoBeautyItemCleanModel(
          beautyTranslation
                  .beautyMap[ZegoUIKitBeautyResetType.reset.toString()] ??
              '',
          ZegoUIKitBeautyResetType.reset,
          ZegoUIKitResetEffectType.beautyBasic,
        ),
      );
      beautyTabModels.add(
        ZegoBeautyTabModel(
          beautyTranslation
                  .beautyMap[ZegoUIKitBeautyTabType.basic.toString()] ??
              '',
          ZegoUIKitBeautyTabType.basic,
          basicBeautyItemModels,
          [],
          ValueNotifier(true),
        ),
      );
    }

    if (advanceBeautyItemModels.isNotEmpty) {
      advanceBeautyItemModels.insert(
        0,
        ZegoBeautyItemCleanModel(
          beautyTranslation
                  .beautyMap[ZegoUIKitBeautyResetType.reset.toString()] ??
              '',
          ZegoUIKitBeautyResetType.reset,
          ZegoUIKitResetEffectType.beautyAdvanced,
        ),
      );
      beautyTabModels.add(
        ZegoBeautyTabModel(
          beautyTranslation
                  .beautyMap[ZegoUIKitBeautyTabType.advanced.toString()] ??
              '',
          ZegoUIKitBeautyTabType.advanced,
          advanceBeautyItemModels,
          [],
          ValueNotifier(false),
        ),
      );
    }

    if (makeupBeautyItemModels.isNotEmpty) {
      beautyTabModels.add(
        ZegoBeautyTabModel(
          beautyTranslation
                  .beautyMap[ZegoUIKitBeautyTabType.beautyMakeup.toString()] ??
              '',
          ZegoUIKitBeautyTabType.beautyMakeup,
          [],
          makeupBeautyItemModels,
          ValueNotifier(false),
        ),
      );
    }

    if (styleMakeupBeautyItemModels.isNotEmpty) {
      styleMakeupBeautyItemModels.insert(
        0,
        ZegoBeautyItemCleanModel(
          beautyTranslation.beautyMap[
                  ZegoUIKitBeautyResetType.originalDrawRect.toString()] ??
              '',
          ZegoUIKitBeautyResetType.originalDrawRect,
          ZegoUIKitResetEffectType.beautyStyleMakeup,
        ),
      );
      beautyTabModels.add(
        ZegoBeautyTabModel(
          beautyTranslation
                  .beautyMap[ZegoUIKitBeautyTabType.styleMakeup.toString()] ??
              '',
          ZegoUIKitBeautyTabType.styleMakeup,
          styleMakeupBeautyItemModels,
          [],
          ValueNotifier(false),
        ),
      );
    }

    if (filterNatureItemModels.isNotEmpty) {
      filterNatureItemModels.insert(
        0,
        ZegoBeautyItemCleanModel(
          beautyTranslation.beautyMap[
                  ZegoUIKitBeautyResetType.originalDrawRect.toString()] ??
              '',
          ZegoUIKitBeautyResetType.originalDrawRect,
          ZegoUIKitResetEffectType.filterNature,
        ),
      );
      ZegoFilterTabModel model = ZegoFilterTabModel(
        beautyTranslation.beautyMap[ZegoUIKitFilterTabType.nature.toString()] ??
            '',
        ZegoUIKitFilterTabType.nature,
        filterNatureItemModels,
        ValueNotifier(true),
      );
      filterTabModels.add(model);
    }

    if (filterGrayItemModels.isNotEmpty) {
      filterGrayItemModels.insert(
        0,
        ZegoBeautyItemCleanModel(
          beautyTranslation.beautyMap[
                  ZegoUIKitBeautyResetType.originalDrawRect.toString()] ??
              '',
          ZegoUIKitBeautyResetType.originalDrawRect,
          ZegoUIKitResetEffectType.filterGray,
        ),
      );
      ZegoFilterTabModel model = ZegoFilterTabModel(
        beautyTranslation
                .beautyMap[ZegoUIKitFilterTabType.grayTone.toString()] ??
            '',
        ZegoUIKitFilterTabType.grayTone,
        filterGrayItemModels,
        ValueNotifier(false),
      );
      filterTabModels.add(model);
    }

    if (filterDreamItemModels.isNotEmpty) {
      filterDreamItemModels.insert(
        0,
        ZegoBeautyItemCleanModel(
          beautyTranslation.beautyMap[
                  ZegoUIKitBeautyResetType.originalDrawRect.toString()] ??
              '',
          ZegoUIKitBeautyResetType.originalDrawRect,
          ZegoUIKitResetEffectType.filterDreamy,
        ),
      );
      ZegoFilterTabModel model = ZegoFilterTabModel(
        beautyTranslation.beautyMap[ZegoUIKitFilterTabType.dream.toString()] ??
            '',
        ZegoUIKitFilterTabType.dream,
        filterDreamItemModels,
        ValueNotifier(false),
      );
      filterTabModels.add(model);
    }

    if (backgroundItemModels.isNotEmpty) {
      backgroundItemModels.insert(
        0,
        ZegoBeautyItemCleanModel(
          beautyTranslation.beautyMap[
                  ZegoUIKitBeautyResetType.originalDrawRect.toString()] ??
              '',
          ZegoUIKitBeautyResetType.originalDrawRect,
          ZegoUIKitResetEffectType.background2D,
        ),
      );
      ZegoBackgroundTabModel model = ZegoBackgroundTabModel(
        beautyTranslation
                .beautyMap[ZegoUIKitBackgroundTabType.background.toString()] ??
            '',
        ZegoUIKitBackgroundTabType.background,
        backgroundItemModels,
        ValueNotifier(true),
      );
      backgroundTabModels.add(model);
    }

    List<ZegoBeautyOneLevelModel> oneLevelsModels = [];

    if (beautyTabModels.isNotEmpty) {
      ZegoBeautyOneLevelModel oneLevelModel = ZegoBeautyOneLevelModel(
        beautyTranslation
                .beautyMap[ZegoUIKitBeautyMainTabType.beauty.toString()] ??
            '',
        ZegoUIKitBeautyMainTabType.beauty,
        beautyTabModels,
        ValueNotifier(true),
      );
      oneLevelsModels.add(oneLevelModel);
    }

    if (filterTabModels.isNotEmpty) {
      ZegoBeautyOneLevelModel oneLevelModel = ZegoBeautyOneLevelModel(
        beautyTranslation
                .beautyMap[ZegoUIKitBeautyMainTabType.filter.toString()] ??
            '',
        ZegoUIKitBeautyMainTabType.filter,
        filterTabModels,
        ValueNotifier(false),
      );
      oneLevelsModels.add(oneLevelModel);
    }

    if (backgroundTabModels.isNotEmpty) {
      ZegoBeautyOneLevelModel oneLevelModel = ZegoBeautyOneLevelModel(
        beautyTranslation
                .beautyMap[ZegoUIKitBeautyMainTabType.background.toString()] ??
            '',
        ZegoUIKitBeautyMainTabType.background,
        backgroundTabModels,
        ValueNotifier(false),
      );
      oneLevelsModels.add(oneLevelModel);
    }

    mainModel = ZegoBeautyMainModel(
      oneLevelsModels,
      ValueNotifier(oneLevelsModels.first),
    );
    uiDisplay.mainModel = mainModel;
  }

  bool makeupItemIsSelect(List<ZegoBeautyItemBaseModel> modelList) {
    bool isSelect = false;
    for (var model in modelList) {
      if (model is ZegoBeautyItemModel) {
        if (model.isSelect.value) {
          isSelect = model.isSelect.value;
          break;
        }
      }
    }
    return isSelect;
  }

  /// updateMakeUpItemSelectState
  void updateMakeUpItemSelectState(
      ZegoBeautyItemModel model, ZegoBeautyMakeUpModel makeUpModel) {
    if (model.isSelect.value) {
      return;
    }
    for (var element in makeUpModel.models) {
      if (element is ZegoBeautyItemModel && element.type != model.type) {
        element.isSelect.value = false;
        ZegoBeautyEffectRecord.instance.delectEffectRecord(element.type);
      }
    }
    ZegoBeautyEffectRecord.instance
        .setEffectRecordSelectState(model.type, true);
    isSelectMakeup.value = true;
    model.isSelect.value = true;

    setMakeupEffects(model.type, model.effectValue.value);
  }

  void setMakeupEffects(ZegoBeautyPluginEffectsType type, int value) {
    if (type == ZegoBeautyPluginEffectsType.beautyMakeupLipstickCameoPink ||
        type == ZegoBeautyPluginEffectsType.beautyMakeupLipstickSweetOrange ||
        type == ZegoBeautyPluginEffectsType.beautyMakeupLipstickRustRed ||
        type == ZegoBeautyPluginEffectsType.beautyMakeupLipstickCoral ||
        type == ZegoBeautyPluginEffectsType.beautyMakeupLipstickRedVelvet) {
      ZegoEffectsPlugin.instance.setLipstick(
        beautyTranslation.beautyResourceMap[type.toString()] ?? '',
      );
      ZegoEffectsLipstickParam param = ZegoEffectsLipstickParam();
      param.intensity = value;
      ZegoEffectsPlugin.instance.setLipstickParam(param);
    } else if (type ==
            ZegoBeautyPluginEffectsType.beautyMakeupBlusherSlightlyDrunk ||
        type == ZegoBeautyPluginEffectsType.beautyMakeupBlusherPeach ||
        type == ZegoBeautyPluginEffectsType.beautyMakeupBlusherMilkyOrange ||
        type == ZegoBeautyPluginEffectsType.beautyMakeupBlusherApricotPink ||
        type == ZegoBeautyPluginEffectsType.beautyMakeupBlusherSweetOrange) {
      ZegoEffectsPlugin.instance.setBlusher(
        beautyTranslation.beautyResourceMap[type.toString()] ?? '',
      );
      ZegoEffectsBlusherParam param = ZegoEffectsBlusherParam();
      param.intensity = value;
      ZegoEffectsPlugin.instance.setBlusherParam(param);
    } else if (type ==
            ZegoBeautyPluginEffectsType.beautyMakeupEyelashesNatural ||
        type == ZegoBeautyPluginEffectsType.beautyMakeupEyelashesTender ||
        type == ZegoBeautyPluginEffectsType.beautyMakeupEyelashesCurl ||
        type == ZegoBeautyPluginEffectsType.beautyMakeupEyelashesEverlong ||
        type == ZegoBeautyPluginEffectsType.beautyMakeupEyelashesThick) {
      ZegoEffectsPlugin.instance.setEyelashes(
        beautyTranslation.beautyResourceMap[type.toString()] ?? '',
      );
      ZegoEffectsEyelashesParam param = ZegoEffectsEyelashesParam();
      param.intensity = value;
      ZegoEffectsPlugin.instance.setEyelashesParam(param);
    } else if (type ==
            ZegoBeautyPluginEffectsType.beautyMakeupEyelinerNatural ||
        type == ZegoBeautyPluginEffectsType.beautyMakeupEyelinerCatEye ||
        type == ZegoBeautyPluginEffectsType.beautyMakeupEyelinerNaughty ||
        type == ZegoBeautyPluginEffectsType.beautyMakeupEyelinerInnocent ||
        type == ZegoBeautyPluginEffectsType.beautyMakeupEyelinerDignified) {
      ZegoEffectsPlugin.instance.setEyeliner(
        beautyTranslation.beautyResourceMap[type.toString()] ?? '',
      );
      ZegoEffectsEyelinerParam param = ZegoEffectsEyelinerParam();
      param.intensity = value;
      ZegoEffectsPlugin.instance.setEyelinerParam(param);
    } else if (type ==
            ZegoBeautyPluginEffectsType.beautyMakeupEyeshadowPinkMist ||
        type == ZegoBeautyPluginEffectsType.beautyMakeupEyeshadowShimmerPink ||
        type == ZegoBeautyPluginEffectsType.beautyMakeupEyeshadowTeaBrown ||
        type == ZegoBeautyPluginEffectsType.beautyMakeupEyeshadowBrightOrange ||
        type == ZegoBeautyPluginEffectsType.beautyMakeupEyeshadowMochaBrown) {
      ZegoEffectsPlugin.instance.setEyeshadow(
        beautyTranslation.beautyResourceMap[type.toString()] ?? '',
      );
      ZegoEffectsEyeshadowParam param = ZegoEffectsEyeshadowParam();
      param.intensity = value;
      ZegoEffectsPlugin.instance.setEyeshadowParam(param);
    } else if (type ==
            ZegoBeautyPluginEffectsType
                .beautyMakeupColoredContactsDarknightBlack ||
        type ==
            ZegoBeautyPluginEffectsType.beautyMakeupColoredContactsStarryBlue ||
        type ==
            ZegoBeautyPluginEffectsType.beautyMakeupColoredContactsBrownGreen ||
        type ==
            ZegoBeautyPluginEffectsType
                .beautyMakeupColoredContactsLightsBrown ||
        type ==
            ZegoBeautyPluginEffectsType
                .beautyMakeupColoredContactsChocolateBrown) {
      ZegoEffectsPlugin.instance.setColoredcontacts(
        beautyTranslation.beautyResourceMap[type.toString()] ?? '',
      );
      ZegoEffectsColoredcontactsParam param = ZegoEffectsColoredcontactsParam();
      param.intensity = value;
      ZegoEffectsPlugin.instance.setColoredcontactsParam(param);
    }
  }

  /// setAdvancedModel
  Future<void> setAdvancedModel(ZegoBeautyPluginEffectsType type, String title,
      List<ZegoBeautyItemBaseModel> advanceBeautyItemModels) async {
    Map<String, dynamic> record =
        await ZegoBeautyEffectRecord.instance.getEffectRecord() ?? {};
    int value = -9999;
    bool isSelect = false;
    String effectKey = ZegoBeautyEffectRecord.instance.enumToString(type);
    if (record.containsKey(effectKey)) {
      Map? effectRecord = record[effectKey] as Map?;
      if (effectRecord != null) {
        if (effectRecord.containsKey(effectValueKey)) {
          value = effectRecord[effectValueKey];
        }
        if (effectRecord.containsKey(isSelectKey)) {
          isSelect = effectRecord[isSelectKey];
        }
      }
    }
    if (type == ZegoBeautyPluginEffectsType.beautyAdvancedNoseLengthening ||
        type == ZegoBeautyPluginEffectsType.beautyAdvancedMouthReshape ||
        type == ZegoBeautyPluginEffectsType.beautyAdvancedChinLengthening ||
        type == ZegoBeautyPluginEffectsType.beautyAdvancedForeheadSlimming) {
      ZegoBeautyItemModel model = ZegoBeautyItemModel(
        title,
        ValueNotifier(isSelect),
        type,
        ValueNotifier(value == -9999 ? 0 : value),
        maxValue: 100,
        minValue: -100,
      );
      advanceBeautyItemModels.add(model);
    } else {
      ZegoBeautyItemModel model = ZegoBeautyItemModel(
        title,
        ValueNotifier(isSelect),
        type,
        ValueNotifier(value == -9999 ? 50 : value),
      );
      advanceBeautyItemModels.add(model);
    }
  }

  /// updateFilterSelectState
  void updateFilterSelectState(ZegoBeautyItemModel model) {
    if (model.isSelect.value) {
      return;
    }
    // lastFilterModel?.effectValue.value = 50;
    lastFilterModel?.isSelect.value = false;
    if (lastFilterModel != null) {
      ZegoBeautyEffectRecord.instance
          .setEffectRecordSelectState(lastFilterModel!.type, false);
    }
    ZegoBeautyEffectRecord.instance
        .setEffectRecordSelectState(model.type, true);
    model.isSelect.value = true;
    lastFilterModel = model;
    setFilterEffects(model.type, model.effectValue.value);
  }

  void setFilterEffects(ZegoBeautyPluginEffectsType type, int value) {
    if (type == ZegoBeautyPluginEffectsType.filterNaturalAutumn ||
        type == ZegoBeautyPluginEffectsType.filterNaturalBrighten ||
        type == ZegoBeautyPluginEffectsType.filterNaturalCreamy ||
        type == ZegoBeautyPluginEffectsType.filterNaturalFresh ||
        type == ZegoBeautyPluginEffectsType.filterGrayMonet ||
        type == ZegoBeautyPluginEffectsType.filterGrayNight ||
        type == ZegoBeautyPluginEffectsType.filterGrayFilmlike ||
        type == ZegoBeautyPluginEffectsType.filterDreamySunset ||
        type == ZegoBeautyPluginEffectsType.filterDreamyCozily ||
        type == ZegoBeautyPluginEffectsType.filterDreamySweet) {
      ZegoEffectsPlugin.instance.setFilter(
        beautyTranslation.beautyResourceMap[type.toString()] ?? '',
      );
      setEffectValue(type, value);
    }
  }

  /// updateBackgroundSelectState
  void updateBackgroundSelectState(ZegoBeautyItemModel model) {
    if (model.isSelect.value) {
      return;
    }
    lastBackgroundModel?.isSelect.value = false;
    if (lastBackgroundModel != null) {
      ZegoBeautyEffectRecord.instance
          .setEffectRecordSelectState(lastBackgroundModel!.type, false);
    }
    ZegoBeautyEffectRecord.instance
        .setEffectRecordSelectState(model.type, true);
    // lastBackgroundModel?.effectValue.value = 50;
    model.isSelect.value = true;
    lastBackgroundModel = model;
    setBackgroundEffects(model.type, model.effectValue.value);
  }

  ZegoEffectsScaleMode getsegmentationScaleMode() {
    if (effectsConfig.segmentationScaleMode ==
        ZegoBeautyPluginSegmentationScaleMode.scaleToFill) {
      return ZegoEffectsScaleMode.ScaleToFill;
    } else if (effectsConfig.segmentationScaleMode ==
        ZegoBeautyPluginSegmentationScaleMode.aspectFit) {
      return ZegoEffectsScaleMode.AspectFit;
    } else {
      return ZegoEffectsScaleMode.AspectFill;
    }
  }

  void setBackgroundEffects(ZegoBeautyPluginEffectsType type, int value) {
    String? backgroundPath;
    if (effectsConfig.segmentationBackgroundImageName != null) {
      backgroundPath =
          '$resourceFolder/BackgroundImages/${effectsConfig.segmentationBackgroundImageName}';
    }
    if (type == ZegoBeautyPluginEffectsType.backgroundPortraitSegmentation) {
      ZegoEffectsPlugin.instance.enablePortraitSegmentation(true);
      ZegoEffectsPlugin.instance.enablePortraitSegmentationBackground(true);
      if (backgroundPath != null) {
        ZegoEffectsPlugin.instance.setPortraitSegmentationBackgroundPath(
          backgroundPath,
          getsegmentationScaleMode(),
        );
      }
      setEffectValue(type, value);
    } else if (type ==
        ZegoBeautyPluginEffectsType.backgroundGreenScreenSegmentation) {
      ZegoEffectsPlugin.instance.enableChromaKey(true);
      ZegoEffectsPlugin.instance.enableChromaKeyBackground(true);
      ZegoEffectsPlugin.instance.enablePortraitSegmentation(false);
      ZegoEffectsChromaKeyParam param = ZegoEffectsChromaKeyParam();
      param.smoothness = 80;
      param.opacity = 100;
      param.keyColor = 65280;
      param.similarity = 67;
      ZegoEffectsPlugin.instance.setChromaKeyParam(param);
      if (backgroundPath != null) {
        ZegoEffectsPlugin.instance.setChromaKeyBackgroundPath(
          backgroundPath,
          getsegmentationScaleMode(),
        );
      }
    } else if (type == ZegoBeautyPluginEffectsType.backgroundGaussianBlur) {
      ZegoEffectsPlugin.instance.enablePortraitSegmentation(true);
      ZegoEffectsPlugin.instance.enablePortraitSegmentationBackgroundBlur(true);
      setEffectValue(type, value);
    } else if (type == ZegoBeautyPluginEffectsType.backgroundMosaicing) {
      ZegoEffectsPlugin.instance.enablePortraitSegmentation(true);
      ZegoEffectsPlugin.instance
          .enablePortraitSegmentationBackgroundMosaic(true);
      setEffectValue(type, value);
    }
  }

  /// updateStyleMakeupSelectState
  void updateStyleMakeupSelectState(ZegoBeautyItemModel model) {
    if (model.isSelect.value) {
      return;
    }
    resetBeauty(ZegoUIKitResetEffectType.beautyMakeup);
    isSelectStyleMakeup.value = true;
    lastStyleMakeupModel?.isSelect.value = false;
    if (lastStyleMakeupModel != null) {
      ZegoBeautyEffectRecord.instance
          .setEffectRecordSelectState(lastStyleMakeupModel!.type, false);
    }
    ZegoBeautyEffectRecord.instance
        .setEffectRecordSelectState(model.type, true);
    model.isSelect.value = true;
    lastStyleMakeupModel = model;
    setStyleMakeupEffects(model.type);
  }

  void setStyleMakeupEffects(ZegoBeautyPluginEffectsType type) {
    if (type == ZegoBeautyPluginEffectsType.beautyStyleMakeupInnocentEyes ||
        type == ZegoBeautyPluginEffectsType.beautyStyleMakeupMilkyEyes ||
        type == ZegoBeautyPluginEffectsType.beautyStyleMakeupCutieCool ||
        type == ZegoBeautyPluginEffectsType.beautyStyleMakeupPureSexy ||
        type == ZegoBeautyPluginEffectsType.beautyStyleMakeupFlawless) {
      ZegoEffectsPlugin.instance.setMakeup(
          beautyTranslation.beautyResourceMap[type.toString()] ?? '');
    }
  }

  /// updateBasicAndAdvancedSelectState
  void updateBasicAndAdvancedSelectState(ZegoBeautyItemModel model) {
    updateBasicAndAdvancedSelectStateWithType(model.type);
    ZegoBeautyEffectRecord.instance
        .setEffectRecordValue(model.type, model.effectValue.value);
  }

  void updateBasicAndAdvancedSelectStateWithType(
      ZegoBeautyPluginEffectsType type) {
    ZegoBeautyEffectRecord.instance.setEffectRecordSelectState(type, true);
    if (type == ZegoBeautyPluginEffectsType.beautyBasicSharpening) {
      ZegoEffectsPlugin.instance.enableSharpen(true);
    } else if (type == ZegoBeautyPluginEffectsType.beautyBasicSmoothing) {
      ZegoEffectsPlugin.instance.enableSmooth(true);
    } else if (type == ZegoBeautyPluginEffectsType.beautyBasicBlusher) {
      ZegoEffectsPlugin.instance.enableRosy(true);
    } else if (type == ZegoBeautyPluginEffectsType.beautyBasicDarkCircles) {
      ZegoEffectsPlugin.instance.enableDarkCirclesRemoving(true);
    } else if (type == ZegoBeautyPluginEffectsType.beautyBasicSkinTone) {
      ZegoEffectsPlugin.instance.enableWhiten(true);
    } else if (type == ZegoBeautyPluginEffectsType.beautyBasicWrinkles) {
      ZegoEffectsPlugin.instance.enableWrinklesRemoving(true);
    } else if (type ==
        ZegoBeautyPluginEffectsType.beautyAdvancedCheekboneSlimming) {
      ZegoEffectsPlugin.instance.enableCheekboneSlimming(true);
    } else if (type ==
        ZegoBeautyPluginEffectsType.beautyAdvancedChinLengthening) {
      ZegoEffectsPlugin.instance.enableLongChin(true);
    } else if (type ==
        ZegoBeautyPluginEffectsType.beautyAdvancedEyesBrightening) {
      ZegoEffectsPlugin.instance.enableEyesBrightening(true);
    } else if (type ==
        ZegoBeautyPluginEffectsType.beautyAdvancedEyesEnlarging) {
      ZegoEffectsPlugin.instance.enableBigEyes(true);
    } else if (type ==
        ZegoBeautyPluginEffectsType.beautyAdvancedFaceShortening) {
      ZegoEffectsPlugin.instance.enableFaceShortening(true);
    } else if (type == ZegoBeautyPluginEffectsType.beautyAdvancedFaceSlimming) {
      ZegoEffectsPlugin.instance.enableFaceLifting(true);
    } else if (type ==
        ZegoBeautyPluginEffectsType.beautyAdvancedForeheadSlimming) {
      ZegoEffectsPlugin.instance.enableForeheadShortening(true);
    } else if (type ==
        ZegoBeautyPluginEffectsType.beautyAdvancedMandibleSlimming) {
      ZegoEffectsPlugin.instance.enableMandibleSlimming(true);
    } else if (type == ZegoBeautyPluginEffectsType.beautyAdvancedMouthReshape) {
      ZegoEffectsPlugin.instance.enableSmallMouth(true);
    } else if (type ==
        ZegoBeautyPluginEffectsType.beautyAdvancedNoseLengthening) {
      ZegoEffectsPlugin.instance.enableNoseLengthening(true);
    } else if (type == ZegoBeautyPluginEffectsType.beautyAdvancedNoseSlimming) {
      ZegoEffectsPlugin.instance.enableNoseNarrowing(true);
    } else if (type ==
        ZegoBeautyPluginEffectsType.beautyAdvancedTeethWhitening) {
      ZegoEffectsPlugin.instance.enableTeethWhitening(true);
    }
  }

  /// resetEffect
  void resetEffect(ZegoBeautyItemCleanModel model) {
    switch (model.resetType) {
      case ZegoUIKitResetEffectType.beautyBasic:
      case ZegoUIKitResetEffectType.beautyAdvanced:
      case ZegoUIKitResetEffectType.beautyMakeup:
      case ZegoUIKitResetEffectType.beautyStyleMakeup:
      case ZegoUIKitResetEffectType.beautyMakeupLipSticker:
      case ZegoUIKitResetEffectType.beautyMakeupBlusher:
      case ZegoUIKitResetEffectType.beautyMakeupEyelashes:
      case ZegoUIKitResetEffectType.beautyMakeupEyeliner:
      case ZegoUIKitResetEffectType.beautyMakeupEyeshadow:
      case ZegoUIKitResetEffectType.beautyMakeupColor:
        resetBeauty(model.resetType);
        break;
      case ZegoUIKitResetEffectType.filterNature:
      case ZegoUIKitResetEffectType.filterGray:
      case ZegoUIKitResetEffectType.filterDreamy:
        resetFilter(model.resetType);
        break;
      case ZegoUIKitResetEffectType.background2D:
        resetBackground(model.resetType);
        break;
    }
  }

  /// resetBeauty
  void resetBeauty(ZegoUIKitResetEffectType type) {
    for (var model in mainModel!.models) {
      for (ZegoTwoLevelBaseTabModel tabModel in model.models) {
        if (type == ZegoUIKitResetEffectType.beautyBasic) {
          if (tabModel is ZegoBeautyTabModel &&
              tabModel.type == ZegoUIKitBeautyTabType.basic) {
            ZegoBeautyEffectValueSetting.resetBasicBeauty(tabModel);
            break;
          }
        } else if (type == ZegoUIKitResetEffectType.beautyAdvanced) {
          if (tabModel is ZegoBeautyTabModel &&
              tabModel.type == ZegoUIKitBeautyTabType.advanced) {
            ZegoBeautyEffectValueSetting.resetAdvancedBeauty(tabModel);
            break;
          }
        } else if (type == ZegoUIKitResetEffectType.beautyStyleMakeup) {
          isSelectStyleMakeup.value = false;
          lastStyleMakeupModel?.isSelect.value = false;
          if (tabModel is ZegoBeautyTabModel &&
              tabModel.type == ZegoUIKitBeautyTabType.styleMakeup) {
            ZegoBeautyEffectValueSetting.resetStyleMakeup(tabModel);
            break;
          }
        } else if (type == ZegoUIKitResetEffectType.beautyMakeup) {
          isSelectMakeup.value = false;
          if (tabModel is ZegoBeautyTabModel &&
              tabModel.type == ZegoUIKitBeautyTabType.beautyMakeup) {
            ZegoBeautyEffectValueSetting.resetAllMakeup(tabModel);
            break;
          }
        } else if (type == ZegoUIKitResetEffectType.beautyMakeupLipSticker) {
          if (tabModel is ZegoBeautyTabModel &&
              tabModel.type == ZegoUIKitBeautyTabType.beautyMakeup) {
            ZegoBeautyEffectValueSetting.resetMakeup(
              tabModel,
              ZegoUIKitBeautyMakeupType.lipstick,
            );
            break;
          }
        } else if (type == ZegoUIKitResetEffectType.beautyMakeupBlusher) {
          if (tabModel is ZegoBeautyTabModel &&
              tabModel.type == ZegoUIKitBeautyTabType.beautyMakeup) {
            ZegoBeautyEffectValueSetting.resetMakeup(
              tabModel,
              ZegoUIKitBeautyMakeupType.blusher,
            );
            break;
          }
        } else if (type == ZegoUIKitResetEffectType.beautyMakeupEyelashes) {
          if (tabModel is ZegoBeautyTabModel &&
              tabModel.type == ZegoUIKitBeautyTabType.beautyMakeup) {
            ZegoBeautyEffectValueSetting.resetMakeup(
              tabModel,
              ZegoUIKitBeautyMakeupType.eyelashes,
            );
            break;
          }
        } else if (type == ZegoUIKitResetEffectType.beautyMakeupEyeliner) {
          if (tabModel is ZegoBeautyTabModel &&
              tabModel.type == ZegoUIKitBeautyTabType.beautyMakeup) {
            ZegoBeautyEffectValueSetting.resetMakeup(
              tabModel,
              ZegoUIKitBeautyMakeupType.eyeliner,
            );
            break;
          }
        } else if (type == ZegoUIKitResetEffectType.beautyMakeupEyeshadow) {
          if (tabModel is ZegoBeautyTabModel &&
              tabModel.type == ZegoUIKitBeautyTabType.beautyMakeup) {
            ZegoBeautyEffectValueSetting.resetMakeup(
              tabModel,
              ZegoUIKitBeautyMakeupType.eyeshadow,
            );
            break;
          }
        } else if (type == ZegoUIKitResetEffectType.beautyMakeupColor) {
          if (tabModel is ZegoBeautyTabModel &&
              tabModel.type == ZegoUIKitBeautyTabType.beautyMakeup) {
            ZegoBeautyEffectValueSetting.resetMakeup(
              tabModel,
              ZegoUIKitBeautyMakeupType.color,
            );
            break;
          }
        }
      }
    }
  }

  /// resetFilter
  void resetFilter(ZegoUIKitResetEffectType type) {
    lastFilterModel?.isSelect.value = false;
    lastFilterModel?.effectValue.value = 50;
    ZegoEffectsPlugin.instance.setFilter('');
    for (ZegoBeautyOneLevelModel element in mainModel!.models) {
      for (ZegoTwoLevelBaseTabModel element in element.models) {
        if (element is ZegoFilterTabModel) {
          for (ZegoBeautyItemBaseModel model in element.models) {
            if (model is ZegoBeautyItemModel) {
              ZegoBeautyEffectRecord.instance.delectEffectRecord(model.type);
            }
          }
        }
      }
    }
  }

  /// resetBackground
  void resetBackground(ZegoUIKitResetEffectType type) {
    lastBackgroundModel?.effectValue.value = 50;
    lastBackgroundModel?.isSelect.value = false;
    ZegoEffectsPlugin.instance
        .enablePortraitSegmentationBackgroundMosaic(false);
    ZegoEffectsPlugin.instance.enablePortraitSegmentationBackground(false);
    ZegoEffectsPlugin.instance.enablePortraitSegmentationBackgroundBlur(false);
    ZegoEffectsPlugin.instance.enablePortraitSegmentation(false);
    for (ZegoBeautyOneLevelModel element in mainModel!.models) {
      for (ZegoTwoLevelBaseTabModel element in element.models) {
        if (element is ZegoBackgroundTabModel) {
          for (ZegoBeautyItemBaseModel model in element.models) {
            if (model is ZegoBeautyItemModel) {
              ZegoBeautyEffectRecord.instance.delectEffectRecord(model.type);
            }
          }
        }
      }
    }
  }

  /// initEffects
  Future<void> initEffects(int appID, String appSign) async {
    ZegoBeautyLoggerService.logInfo(
      'ready set resources',
      tag: 'beauty',
      subTag: 'initEffects',
    );
    await ZegoEffectsPlugin.instance.setResources();

    ZegoBeautyLoggerService.logInfo(
      'ready create with appID: $appID',
      tag: 'beauty',
      subTag: 'initEffects',
    );

    // callback of effects sdk.
    await ZegoEffectsPlugin.registerEventCallback(
      onEffectsError: onEffectsError,
      onEffectsFaceDetected: onEffectsFaceDetected,
    );

    /// This API must be called regardless of success or failure;
    /// otherwise, a black screen will appear when it fails
    await ZegoEffectsPlugin.instance.enableImageProcessing(true);

    final createRetCode =
        await ZegoEffectsPlugin.instance.create(appID, appSign);
    ZegoBeautyLoggerService.logInfo(
      'create done, result: $createRetCode',
      tag: 'beauty',
      subTag: 'initEffects',
    );

    if (0 != createRetCode) {
      onEffectsError(createRetCode, '');
    } else {
      await ZegoEffectsPlugin.instance.enableFaceDetection(true);
    }

    await setDefaultBeautyEffects();
  }

  /// setDefaultBeautyEffects
  Future<void> setDefaultBeautyEffects() async {
    Map<String, dynamic> effectRecord =
        await ZegoBeautyEffectRecord.instance.getEffectRecord() ?? {};
    for (String element in effectRecord.keys.toList()) {
      ZegoBeautyPluginEffectsType effectType =
          ZegoBeautyEffectRecord.instance.stringToEnum(element);
      Map? record = effectRecord[element] as Map?;
      int value = record?[effectValueKey] ?? 0;
      updateBasicAndAdvancedSelectStateWithType(effectType);
      setMakeupEffects(effectType, value);
      setFilterEffects(effectType, value);
      setStyleMakeupEffects(effectType);
      setBackgroundEffects(effectType, value);
      setEffectValue(effectType, value);
    }
  }

  /// setEffectValue
  void setEffectValue(ZegoBeautyPluginEffectsType type, int value) {
    ZegoBeautyEffectValueSetting.setEffectValue(type, value);
  }

  /// showBeautyUI
  void showBeautyUI(
    BuildContext context, {
    required Size designSize,
  }) {
    uiDisplay.showBeautyUI(
      context,
      designSize: designSize,
    );
  }

  /// updateSliderModel
  void updateSliderModel(ZegoTwoLevelBaseTabModel model,
      ValueNotifier<ZegoBeautyItemModel?> sliderModel) {
    sliderModel.value = null;
    if (model is ZegoBeautyTabModel) {
      if (model.type == ZegoUIKitBeautyTabType.styleMakeup) {
        for (var itemModel in model.models) {
          if (itemModel is ZegoBeautyItemModel && itemModel.isSelect.value) {
            sliderModel.value = itemModel;
            break;
          }
        }
      }
    } else if (model is ZegoFilterTabModel) {
      for (var itemModel in model.models) {
        if (itemModel is ZegoBeautyItemModel && itemModel.isSelect.value) {
          sliderModel.value = itemModel;
          break;
        }
      }
    } else if (model is ZegoBackgroundTabModel) {
      for (var itemModel in model.models) {
        if (itemModel is ZegoBeautyItemModel &&
            (itemModel.type ==
                    ZegoBeautyPluginEffectsType.backgroundGaussianBlur ||
                itemModel.type ==
                    ZegoBeautyPluginEffectsType.backgroundMosaicing ||
                itemModel.type ==
                    ZegoBeautyPluginEffectsType
                        .backgroundGreenScreenSegmentation) &&
            itemModel.isSelect.value) {
          sliderModel.value = itemModel;
          break;
        }
      }
    }
  }

  /// updateMakeupSliderModel
  void updateMakeupSliderModel(
    ZegoBeautyMakeUpModel model,
    ValueNotifier<ZegoBeautyItemModel?> sliderModel,
  ) {
    sliderModel.value = null;
    for (var itemModel in model.models) {
      if (itemModel is ZegoBeautyItemModel && itemModel.isSelect.value) {
        sliderModel.value = itemModel;
        break;
      }
    }
  }

  /// clear
  void unInit() {
    ZegoBeautyEffectRecord.instance.saveEffectRecord();
    uiDisplay.clear();
    isSelectStyleMakeup.value = false;
    isSelectMakeup.value = false;

    lastStyleMakeupModel = null;
    lastFilterModel = null;
    lastBackgroundModel = null;
  }
}
