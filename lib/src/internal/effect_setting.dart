// Package imports:
import 'package:zego_effects_plugin/zego_effects_defines.dart';
import 'package:zego_effects_plugin/zego_effects_plugin.dart';
import 'package:zego_plugin_adapter/zego_plugin_adapter.dart';

// Project imports:
import 'package:zego_uikit_beauty_plugin/src/define.dart';
import 'package:zego_uikit_beauty_plugin/src/internal/effect_cache.dart';
import 'package:zego_uikit_beauty_plugin/src/models/model.dart';

/// ZegoBeautyEffectValueSetting
class ZegoBeautyEffectValueSetting {
  /// resetBasicBeauty
  static void resetBasicBeauty(ZegoBeautyTabModel tabModel) {
    ZegoEffectsPlugin.instance.enableSmooth(false);
    ZegoEffectsPlugin.instance.enableWhiten(false);
    ZegoEffectsPlugin.instance.enableRosy(false);
    ZegoEffectsPlugin.instance.enableSharpen(false);
    ZegoEffectsPlugin.instance.enableWrinklesRemoving(false);
    ZegoEffectsPlugin.instance.enableDarkCirclesRemoving(false);
    for (var element in tabModel.models) {
      if (element is ZegoBeautyItemModel) {
        element.isSelect.value = false;
        element.effectValue.value = 50;
        setEffectValue(element.type, element.effectValue.value);
        ZegoBeautyEffectRecord.instance.delectEffectRecord(element.type);
      }
    }
  }

  /// resetAdvancedBeauty
  static void resetAdvancedBeauty(ZegoBeautyTabModel tabModel) {
    ZegoEffectsPlugin.instance.enableCheekboneSlimming(false);
    ZegoEffectsPlugin.instance.enableLongChin(false);
    ZegoEffectsPlugin.instance.enableLongChin(false);
    ZegoEffectsPlugin.instance.enableEyesBrightening(false);
    ZegoEffectsPlugin.instance.enableBigEyes(false);
    ZegoEffectsPlugin.instance.enableFaceShortening(false);
    ZegoEffectsPlugin.instance.enableFaceLifting(false);
    ZegoEffectsPlugin.instance.enableForeheadShortening(false);
    ZegoEffectsPlugin.instance.enableMandibleSlimming(false);
    ZegoEffectsPlugin.instance.enableSmallMouth(false);
    ZegoEffectsPlugin.instance.enableNoseLengthening(false);
    ZegoEffectsPlugin.instance.enableNoseNarrowing(false);
    ZegoEffectsPlugin.instance.enableTeethWhitening(false);

    for (var element in tabModel.models) {
      if (element is ZegoBeautyItemModel) {
        element.isSelect.value = false;
        if (element.type ==
                ZegoBeautyPluginEffectsType.beautyAdvancedNoseLengthening ||
            element.type ==
                ZegoBeautyPluginEffectsType.beautyAdvancedMouthReshape ||
            element.type ==
                ZegoBeautyPluginEffectsType.beautyAdvancedChinLengthening ||
            element.type ==
                ZegoBeautyPluginEffectsType.beautyAdvancedForeheadSlimming) {
          element.effectValue.value = 0;
        } else {
          element.effectValue.value = 50;
        }
        setEffectValue(element.type, element.effectValue.value);
        ZegoBeautyEffectRecord.instance.delectEffectRecord(element.type);
      }
    }
  }

  /// resetStyleMakeup
  static void resetStyleMakeup(ZegoBeautyTabModel tabModel) {
    ZegoEffectsPlugin.instance.setMakeupPath('');
    for (var element in tabModel.models) {
      if (element is ZegoBeautyItemModel) {
        element.isSelect.value = false;
        element.effectValue.value = 50;
        setEffectValue(element.type, element.effectValue.value);
        ZegoBeautyEffectRecord.instance.delectEffectRecord(element.type);
      }
    }
  }

  /// resetAllMakeup
  static void resetAllMakeup(ZegoBeautyTabModel tabModel) {
    ZegoEffectsPlugin.instance.setLipstick('');
    ZegoEffectsPlugin.instance.setBlusher('');
    ZegoEffectsPlugin.instance.setEyelashes('');
    ZegoEffectsPlugin.instance.setEyeliner('');
    ZegoEffectsPlugin.instance.setEyeshadow('');
    ZegoEffectsPlugin.instance.setColoredcontacts('');

    for (var makeupElement in tabModel.makeupModels) {
      for (var element in makeupElement.models) {
        if (element is ZegoBeautyItemModel) {
          element.isSelect.value = false;
          switch (makeupElement.type) {
            case ZegoUIKitBeautyMakeupType.lipstick:
            case ZegoUIKitBeautyMakeupType.blusher:
            case ZegoUIKitBeautyMakeupType.eyeshadow:
            case ZegoUIKitBeautyMakeupType.color:
              element.effectValue.value = 80;
              break;
            case ZegoUIKitBeautyMakeupType.eyelashes:
              element.effectValue.value = 100;
              break;
            case ZegoUIKitBeautyMakeupType.eyeliner:
              element.effectValue.value = 60;
              break;
          }
          ZegoBeautyEffectRecord.instance.delectEffectRecord(element.type);
        }
      }
      makeupElement.isSelect.value = false;
    }
  }

  /// resetMakeup
  static void resetMakeup(
      ZegoBeautyTabModel tabModel, ZegoUIKitBeautyMakeupType type) {
    switch (type) {
      case ZegoUIKitBeautyMakeupType.lipstick:
        ZegoEffectsPlugin.instance.setLipstick('');
        break;
      case ZegoUIKitBeautyMakeupType.blusher:
        ZegoEffectsPlugin.instance.setBlusher('');
        break;
      case ZegoUIKitBeautyMakeupType.eyelashes:
        ZegoEffectsPlugin.instance.setEyelashes('');
        break;
      case ZegoUIKitBeautyMakeupType.eyeliner:
        ZegoEffectsPlugin.instance.setEyeliner('');
        break;
      case ZegoUIKitBeautyMakeupType.eyeshadow:
        ZegoEffectsPlugin.instance.setEyeshadow('');
        break;
      case ZegoUIKitBeautyMakeupType.color:
        ZegoEffectsPlugin.instance.setColoredcontacts('');
        break;
    }

    for (var makeupElement in tabModel.makeupModels) {
      if (makeupElement.type == type) {
        for (var element in makeupElement.models) {
          if (element is ZegoBeautyItemModel) {
            element.isSelect.value = false;
            ZegoBeautyEffectRecord.instance.delectEffectRecord(element.type);
            switch (makeupElement.type) {
              case ZegoUIKitBeautyMakeupType.lipstick:
              case ZegoUIKitBeautyMakeupType.blusher:
              case ZegoUIKitBeautyMakeupType.eyeshadow:
              case ZegoUIKitBeautyMakeupType.color:
                element.effectValue.value = 80;
                break;
              case ZegoUIKitBeautyMakeupType.eyelashes:
                element.effectValue.value = 100;
                break;
              case ZegoUIKitBeautyMakeupType.eyeliner:
                element.effectValue.value = 60;
                break;
            }
          }
        }
        makeupElement.isSelect.value = false;
      }
    }
  }

  /// setEffectValue
  static void setEffectValue(
      ZegoBeautyPluginEffectsType type, int effectValue) {
    ZegoBeautyEffectRecord.instance.setEffectRecordValue(type, effectValue);
    switch (type) {
      case ZegoBeautyPluginEffectsType.beautyBasicSmoothing:
        ZegoEffectsSmoothParam param = ZegoEffectsSmoothParam();
        param.intensity = effectValue;
        ZegoEffectsPlugin.instance.setSmoothParam(param);
        break;
      case ZegoBeautyPluginEffectsType.beautyBasicSkinTone:
        ZegoEffectsWhitenParam param = ZegoEffectsWhitenParam();
        param.intensity = effectValue;
        ZegoEffectsPlugin.instance.setWhitenParam(param);
        break;
      case ZegoBeautyPluginEffectsType.beautyBasicBlusher:
        ZegoEffectsRosyParam param = ZegoEffectsRosyParam();
        param.intensity = effectValue;
        ZegoEffectsPlugin.instance.setRosyParam(param);
        break;
      case ZegoBeautyPluginEffectsType.beautyBasicSharpening:
        ZegoEffectsSharpenParam param = ZegoEffectsSharpenParam();
        param.intensity = effectValue;
        ZegoEffectsPlugin.instance.setSharpenParam(param);
        break;
      case ZegoBeautyPluginEffectsType.beautyBasicWrinkles:
        ZegoEffectsWrinklesRemovingParam param =
            ZegoEffectsWrinklesRemovingParam();
        param.intensity = effectValue;
        ZegoEffectsPlugin.instance.setWrinklesRemovingParam(param);
        break;
      case ZegoBeautyPluginEffectsType.beautyBasicDarkCircles:
        ZegoEffectsDarkCirclesRemovingParam param =
            ZegoEffectsDarkCirclesRemovingParam();
        param.intensity = effectValue;
        ZegoEffectsPlugin.instance.setDarkCirclesRemovingParam(param);
        break;
      case ZegoBeautyPluginEffectsType.beautyAdvancedFaceSlimming:
        ZegoEffectsFaceLiftingParam param = ZegoEffectsFaceLiftingParam();
        param.intensity = effectValue;
        ZegoEffectsPlugin.instance.setFaceLiftingParam(param);
        break;
      case ZegoBeautyPluginEffectsType.beautyAdvancedChinLengthening:
        ZegoEffectsLongChinParam param = ZegoEffectsLongChinParam();
        param.intensity = effectValue;
        ZegoEffectsPlugin.instance.setLongChinParam(param);
        break;
      case ZegoBeautyPluginEffectsType.beautyAdvancedEyesEnlarging:
        ZegoEffectsBigEyesParam param = ZegoEffectsBigEyesParam();
        param.intensity = effectValue;
        ZegoEffectsPlugin.instance.setBigEyesParam(param);
        break;
      case ZegoBeautyPluginEffectsType.beautyAdvancedEyesBrightening:
        ZegoEffectsEyesBrighteningParam param =
            ZegoEffectsEyesBrighteningParam();
        param.intensity = effectValue;
        ZegoEffectsPlugin.instance.setEyesBrighteningParam(param);
        break;
      case ZegoBeautyPluginEffectsType.beautyAdvancedMouthReshape:
        ZegoEffectsSmallMouthParam param = ZegoEffectsSmallMouthParam();
        param.intensity = effectValue;
        ZegoEffectsPlugin.instance.setSmallMouthParam(param);
        break;
      case ZegoBeautyPluginEffectsType.beautyAdvancedTeethWhitening:
        ZegoEffectsTeethWhiteningParam param = ZegoEffectsTeethWhiteningParam();
        param.intensity = effectValue;
        ZegoEffectsPlugin.instance.setTeethWhiteningParam(param);
        break;
      case ZegoBeautyPluginEffectsType.beautyAdvancedNoseSlimming:
        ZegoEffectsNoseNarrowingParam param = ZegoEffectsNoseNarrowingParam();
        param.intensity = effectValue;
        ZegoEffectsPlugin.instance.setNoseNarrowingParam(param);
        break;
      case ZegoBeautyPluginEffectsType.beautyAdvancedNoseLengthening:
        ZegoEffectsNoseLengtheningParam param =
            ZegoEffectsNoseLengtheningParam();
        param.intensity = effectValue;
        ZegoEffectsPlugin.instance.setNoseLengtheningParam(param);
        break;
      case ZegoBeautyPluginEffectsType.beautyAdvancedFaceShortening:
        ZegoEffectsFaceShorteningParam param = ZegoEffectsFaceShorteningParam();
        param.intensity = effectValue;
        ZegoEffectsPlugin.instance.setFaceShorteningParam(param);
        break;
      case ZegoBeautyPluginEffectsType.beautyAdvancedMandibleSlimming:
        ZegoEffectsMandibleSlimmingParam param =
            ZegoEffectsMandibleSlimmingParam();
        param.intensity = effectValue;
        ZegoEffectsPlugin.instance.setMandibleSlimmingParam(param);
        break;
      case ZegoBeautyPluginEffectsType.beautyAdvancedCheekboneSlimming:
        ZegoEffectsCheekboneSlimmingParam param =
            ZegoEffectsCheekboneSlimmingParam();
        param.intensity = effectValue;
        ZegoEffectsPlugin.instance.setCheekboneSlimmingParam(param);
        break;
      case ZegoBeautyPluginEffectsType.beautyAdvancedForeheadSlimming:
        ZegoEffectsForeheadShorteningParam param =
            ZegoEffectsForeheadShorteningParam();
        param.intensity = effectValue;
        ZegoEffectsPlugin.instance.setForeheadShorteningParam(param);
        break;
      case ZegoBeautyPluginEffectsType.beautyMakeupLipstickCameoPink:
      case ZegoBeautyPluginEffectsType.beautyMakeupLipstickCoral:
      case ZegoBeautyPluginEffectsType.beautyMakeupLipstickRedVelvet:
      case ZegoBeautyPluginEffectsType.beautyMakeupLipstickRustRed:
      case ZegoBeautyPluginEffectsType.beautyMakeupLipstickSweetOrange:
        ZegoEffectsLipstickParam param = ZegoEffectsLipstickParam();
        param.intensity = effectValue;
        ZegoEffectsPlugin.instance.setLipstickParam(param);
        break;
      case ZegoBeautyPluginEffectsType.beautyMakeupBlusherSlightlyDrunk:
      case ZegoBeautyPluginEffectsType.beautyMakeupBlusherApricotPink:
      case ZegoBeautyPluginEffectsType.beautyMakeupBlusherPeach:
      case ZegoBeautyPluginEffectsType.beautyMakeupBlusherMilkyOrange:
      case ZegoBeautyPluginEffectsType.beautyMakeupBlusherSweetOrange:
        ZegoEffectsBlusherParam param = ZegoEffectsBlusherParam();
        param.intensity = effectValue;
        ZegoEffectsPlugin.instance.setBlusherParam(param);
        break;
      case ZegoBeautyPluginEffectsType.beautyMakeupEyelashesNatural:
      case ZegoBeautyPluginEffectsType.beautyMakeupEyelashesTender:
      case ZegoBeautyPluginEffectsType.beautyMakeupEyelashesCurl:
      case ZegoBeautyPluginEffectsType.beautyMakeupEyelashesThick:
      case ZegoBeautyPluginEffectsType.beautyMakeupEyelashesEverlong:
        ZegoEffectsEyelashesParam param = ZegoEffectsEyelashesParam();
        param.intensity = effectValue;
        ZegoEffectsPlugin.instance.setEyelashesParam(param);
        break;
      case ZegoBeautyPluginEffectsType.beautyMakeupEyelinerNatural:
      case ZegoBeautyPluginEffectsType.beautyMakeupEyelinerCatEye:
      case ZegoBeautyPluginEffectsType.beautyMakeupEyelinerDignified:
      case ZegoBeautyPluginEffectsType.beautyMakeupEyelinerInnocent:
      case ZegoBeautyPluginEffectsType.beautyMakeupEyelinerNaughty:
        ZegoEffectsEyelinerParam param = ZegoEffectsEyelinerParam();
        param.intensity = effectValue;
        ZegoEffectsPlugin.instance.setEyelinerParam(param);
        break;
      case ZegoBeautyPluginEffectsType.beautyMakeupEyeshadowBrightOrange:
      case ZegoBeautyPluginEffectsType.beautyMakeupEyeshadowMochaBrown:
      case ZegoBeautyPluginEffectsType.beautyMakeupEyeshadowPinkMist:
      case ZegoBeautyPluginEffectsType.beautyMakeupEyeshadowShimmerPink:
      case ZegoBeautyPluginEffectsType.beautyMakeupEyeshadowTeaBrown:
        ZegoEffectsEyeshadowParam param = ZegoEffectsEyeshadowParam();
        param.intensity = effectValue;
        ZegoEffectsPlugin.instance.setEyeshadowParam(param);
        break;
      case ZegoBeautyPluginEffectsType.beautyMakeupColoredContactsBrownGreen:
      case ZegoBeautyPluginEffectsType
            .beautyMakeupColoredContactsChocolateBrown:
      case ZegoBeautyPluginEffectsType
            .beautyMakeupColoredContactsDarknightBlack:
      case ZegoBeautyPluginEffectsType.beautyMakeupColoredContactsLightsBrown:
      case ZegoBeautyPluginEffectsType.beautyMakeupColoredContactsStarryBlue:
        ZegoEffectsColoredcontactsParam param =
            ZegoEffectsColoredcontactsParam();
        param.intensity = effectValue;
        ZegoEffectsPlugin.instance.setColoredcontactsParam(param);
        break;
      case ZegoBeautyPluginEffectsType.beautyStyleMakeupCutieCool:
      case ZegoBeautyPluginEffectsType.beautyStyleMakeupFlawless:
      case ZegoBeautyPluginEffectsType.beautyStyleMakeupInnocentEyes:
      case ZegoBeautyPluginEffectsType.beautyStyleMakeupMilkyEyes:
      case ZegoBeautyPluginEffectsType.beautyStyleMakeupPureSexy:
        ZegoEffectsMakeupParam param = ZegoEffectsMakeupParam();
        param.intensity = effectValue;
        ZegoEffectsPlugin.instance.setMakeupParam(param);
        break;
      case ZegoBeautyPluginEffectsType.backgroundPortraitSegmentation:
        ZegoEffectsChromaKeyParam param = ZegoEffectsChromaKeyParam();
        param.smoothness = 80;
        param.opacity = 100;
        param.keyColor = 65280;
        param.similarity = 67;
        ZegoEffectsPlugin.instance.setChromaKeyParam(param);
        break;
      case ZegoBeautyPluginEffectsType.backgroundGaussianBlur:
        ZegoEffectsBlurParam param = ZegoEffectsBlurParam();
        param.intensity = effectValue;
        ZegoEffectsPlugin.instance
            .setPortraitSegmentationBackgroundBlurParam(param);
        break;
      case ZegoBeautyPluginEffectsType.backgroundMosaicing:
        ZegoEffectsMosaicParam param = ZegoEffectsMosaicParam();
        param.intesity = effectValue;
        ZegoEffectsPlugin.instance
            .setPortraitSegmentationBackgroundMosaicParam(param);
        break;
      case ZegoBeautyPluginEffectsType.backgroundGreenScreenSegmentation:
        break;
      case ZegoBeautyPluginEffectsType.filterNaturalCreamy:
      case ZegoBeautyPluginEffectsType.filterNaturalAutumn:
      case ZegoBeautyPluginEffectsType.filterNaturalBrighten:
      case ZegoBeautyPluginEffectsType.filterNaturalFresh:
      case ZegoBeautyPluginEffectsType.filterDreamyCozily:
      case ZegoBeautyPluginEffectsType.filterDreamySunset:
      case ZegoBeautyPluginEffectsType.filterDreamySweet:
      case ZegoBeautyPluginEffectsType.filterGrayFilmlike:
      case ZegoBeautyPluginEffectsType.filterGrayMonet:
      case ZegoBeautyPluginEffectsType.filterGrayNight:
        ZegoEffectsFilterParam param = ZegoEffectsFilterParam();
        param.intensity = effectValue;
        ZegoEffectsPlugin.instance.setFilterParam(param);
        break;
    }
  }
}
