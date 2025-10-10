// Package imports:
import 'package:zego_plugin_adapter/zego_plugin_adapter.dart';

// Project imports:
import 'package:zego_uikit_beauty_plugin/src/components/icon_define.dart';
import 'package:zego_uikit_beauty_plugin/src/resource_define.dart';

/// UIKitBeautyMainTabType
enum ZegoUIKitBeautyMainTabType {
  beauty,
  filter,
  sticker,
  background,
}

/// Filter tab type
enum ZegoUIKitFilterTabType {
  nature,
  grayTone,
  dream,
}

/// beauty tab type
enum ZegoUIKitBeautyTabType {
  basic,
  advanced,
  beautyMakeup,
  styleMakeup,
}

/// UIKitStickerTabType
enum ZegoUIKitStickerTabType {
  twoD,
}

/// UIKitBackgroundTabType
enum ZegoUIKitBackgroundTabType {
  background,
}

/// UIKitBeautyMakeupType
enum ZegoUIKitBeautyMakeupType {
  lipstick,
  blusher,
  eyelashes,
  eyeliner,
  eyeshadow,
  color,
}

/// ZegoUIKitBeautyResetType
enum ZegoUIKitBeautyResetType {
  reset,
  originalDraw,
  originalDrawRect,
}

/// UIKitResetEffectType
enum ZegoUIKitResetEffectType {
  beautyBasic,
  beautyAdvanced,
  beautyMakeup,
  beautyMakeupLipSticker,
  beautyMakeupBlusher,
  beautyMakeupEyelashes,
  beautyMakeupEyeliner,
  beautyMakeupEyeshadow,
  beautyMakeupColor,
  beautyStyleMakeup,
  filterNature,
  filterGray,
  filterDreamy,
  background2D,
}

/// UIKitBeautyTranslation
class ZegoUIKitBeautyTranslation {
  final ZegoBeautyPluginInnerText translationText;

  Map<String, String> beautyMap = {};
  Map<String, String> iconUrlMap = {};
  Map<String, String> beautyResourceMap = {};

  static List<ZegoBeautyPluginEffectsType> basicEffectsTypes() =>
      ZegoBeautyPluginEffectsType.values.sublist(
          ZegoBeautyPluginEffectsType.beautyBasicSmoothing.index,
          ZegoBeautyPluginEffectsType.beautyBasicDarkCircles.index + 1);

  static List<ZegoBeautyPluginEffectsType> advancedEffectsTypes() =>
      ZegoBeautyPluginEffectsType.values.sublist(
          ZegoBeautyPluginEffectsType.beautyAdvancedFaceSlimming.index,
          ZegoBeautyPluginEffectsType.beautyAdvancedForeheadSlimming.index + 1);

  static List<ZegoBeautyPluginEffectsType> makeupLipstickEffectsTypes() =>
      ZegoBeautyPluginEffectsType.values.sublist(
          ZegoBeautyPluginEffectsType.beautyMakeupLipstickCameoPink.index,
          ZegoBeautyPluginEffectsType.beautyMakeupLipstickRedVelvet.index + 1);

  static List<ZegoBeautyPluginEffectsType> makeupBlusherEffectsTypes() =>
      ZegoBeautyPluginEffectsType.values.sublist(
          ZegoBeautyPluginEffectsType.beautyMakeupBlusherSlightlyDrunk.index,
          ZegoBeautyPluginEffectsType.beautyMakeupBlusherSweetOrange.index + 1);

  static List<ZegoBeautyPluginEffectsType> makeupEyelashesEffectsTypes() =>
      ZegoBeautyPluginEffectsType.values.sublist(
          ZegoBeautyPluginEffectsType.beautyMakeupEyelashesNatural.index,
          ZegoBeautyPluginEffectsType.beautyMakeupEyelashesThick.index + 1);

  static List<ZegoBeautyPluginEffectsType> makeupEyelinerEffectsTypes() =>
      ZegoBeautyPluginEffectsType.values.sublist(
          ZegoBeautyPluginEffectsType.beautyMakeupEyelinerNatural.index,
          ZegoBeautyPluginEffectsType.beautyMakeupEyelinerDignified.index + 1);

  static List<ZegoBeautyPluginEffectsType> makeupEyeshadowEffectsTypes() =>
      ZegoBeautyPluginEffectsType.values.sublist(
          ZegoBeautyPluginEffectsType.beautyMakeupEyeshadowPinkMist.index,
          ZegoBeautyPluginEffectsType.beautyMakeupEyeshadowMochaBrown.index +
              1);

  static List<ZegoBeautyPluginEffectsType>
      makeupColoredContactsEffectsTypes() => ZegoBeautyPluginEffectsType.values
          .sublist(
              ZegoBeautyPluginEffectsType
                  .beautyMakeupColoredContactsDarknightBlack.index,
              ZegoBeautyPluginEffectsType
                      .beautyMakeupColoredContactsChocolateBrown.index +
                  1);

  static List<ZegoBeautyPluginEffectsType> stypeMakeupEffectsTypes() =>
      ZegoBeautyPluginEffectsType.values.sublist(
          ZegoBeautyPluginEffectsType.beautyStyleMakeupInnocentEyes.index,
          ZegoBeautyPluginEffectsType.beautyStyleMakeupFlawless.index + 1);

  static List<ZegoBeautyPluginEffectsType> filterNaturalEffectsTypes() =>
      ZegoBeautyPluginEffectsType.values.sublist(
          ZegoBeautyPluginEffectsType.filterNaturalCreamy.index,
          ZegoBeautyPluginEffectsType.filterNaturalAutumn.index + 1);

  static List<ZegoBeautyPluginEffectsType> filterGrayEffectsTypes() =>
      ZegoBeautyPluginEffectsType.values.sublist(
          ZegoBeautyPluginEffectsType.filterGrayMonet.index,
          ZegoBeautyPluginEffectsType.filterGrayFilmlike.index + 1);

  static List<ZegoBeautyPluginEffectsType> filterDreamyEffectsTypes() =>
      ZegoBeautyPluginEffectsType.values.sublist(
          ZegoBeautyPluginEffectsType.filterDreamySunset.index,
          ZegoBeautyPluginEffectsType.filterDreamySweet.index + 1);

  static List<ZegoBeautyPluginEffectsType> backgroundEffectsTypes() =>
      ZegoBeautyPluginEffectsType.values.sublist(
          ZegoBeautyPluginEffectsType.backgroundGreenScreenSegmentation.index,
          ZegoBeautyPluginEffectsType.backgroundGaussianBlur.index + 1);

  ZegoUIKitBeautyTranslation(this.translationText) {
    beautyMap = {
      ZegoBeautyPluginEffectsType.beautyBasicSmoothing.toString():
          translationText.beautyBasicSmoothing,
      ZegoBeautyPluginEffectsType.beautyBasicSkinTone.toString():
          translationText.beautyBasicSkinTone,
      ZegoBeautyPluginEffectsType.beautyBasicBlusher.toString():
          translationText.beautyBasicBlusher,
      ZegoBeautyPluginEffectsType.beautyBasicSharpening.toString():
          translationText.beautyBasicSharpening,
      ZegoBeautyPluginEffectsType.beautyBasicWrinkles.toString():
          translationText.beautyBasicWrinkles,
      ZegoBeautyPluginEffectsType.beautyBasicDarkCircles.toString():
          translationText.beautyBasicDarkCircles,
      ZegoBeautyPluginEffectsType.beautyAdvancedFaceSlimming.toString():
          translationText.beautyAdvancedFaceSlimming,
      ZegoBeautyPluginEffectsType.beautyAdvancedEyesEnlarging.toString():
          translationText.beautyAdvancedEyesEnlarging,
      ZegoBeautyPluginEffectsType.beautyAdvancedEyesBrightening.toString():
          translationText.beautyAdvancedEyesBrightening,
      ZegoBeautyPluginEffectsType.beautyAdvancedChinLengthening.toString():
          translationText.beautyAdvancedChinLengthening,
      ZegoBeautyPluginEffectsType.beautyAdvancedMouthReshape.toString():
          translationText.beautyAdvancedMouthReshape,
      ZegoBeautyPluginEffectsType.beautyAdvancedTeethWhitening.toString():
          translationText.beautyAdvancedTeethWhitening,
      ZegoBeautyPluginEffectsType.beautyAdvancedNoseSlimming.toString():
          translationText.beautyAdvancedNoseSlimming,
      ZegoBeautyPluginEffectsType.beautyAdvancedNoseLengthening.toString():
          translationText.beautyAdvancedNoseLengthening,
      ZegoBeautyPluginEffectsType.beautyAdvancedFaceShortening.toString():
          translationText.beautyAdvancedFaceShortening,
      ZegoBeautyPluginEffectsType.beautyAdvancedMandibleSlimming.toString():
          translationText.beautyAdvancedMandibleSlimming,
      ZegoBeautyPluginEffectsType.beautyAdvancedCheekboneSlimming.toString():
          translationText.beautyAdvancedCheekboneSlimming,
      ZegoBeautyPluginEffectsType.beautyAdvancedForeheadSlimming.toString():
          translationText.beautyAdvancedForeheadSlimming,
      ZegoBeautyPluginEffectsType.beautyMakeupLipstickCameoPink.toString():
          translationText.beautyMakeupLipstickCameoPink,
      ZegoBeautyPluginEffectsType.beautyMakeupLipstickSweetOrange.toString():
          translationText.beautyMakeupLipstickSweetOrange,
      ZegoBeautyPluginEffectsType.beautyMakeupLipstickRustRed.toString():
          translationText.beautyMakeupLipstickRustRed,
      ZegoBeautyPluginEffectsType.beautyMakeupLipstickCoral.toString():
          translationText.beautyMakeupLipstickCoral,
      ZegoBeautyPluginEffectsType.beautyMakeupLipstickRedVelvet.toString():
          translationText.beautyMakeupLipstickRedVelvet,
      ZegoBeautyPluginEffectsType.beautyMakeupBlusherSlightlyDrunk.toString():
          translationText.beautyMakeupBlusherSlightlyDrunk,
      ZegoBeautyPluginEffectsType.beautyMakeupBlusherPeach.toString():
          translationText.beautyMakeupBlusherPeach,
      ZegoBeautyPluginEffectsType.beautyMakeupBlusherMilkyOrange.toString():
          translationText.beautyMakeupBlusherMilkyOrange,
      ZegoBeautyPluginEffectsType.beautyMakeupBlusherApricotPink.toString():
          translationText.beautyMakeupBlusherApricotPink,
      ZegoBeautyPluginEffectsType.beautyMakeupBlusherSweetOrange.toString():
          translationText.beautyMakeupBlusherSweetOrange,
      ZegoBeautyPluginEffectsType.beautyMakeupEyelashesNatural.toString():
          translationText.beautyMakeupEyelashesNatural,
      ZegoBeautyPluginEffectsType.beautyMakeupEyelashesTender.toString():
          translationText.beautyMakeupEyelashesTender,
      ZegoBeautyPluginEffectsType.beautyMakeupEyelashesCurl.toString():
          translationText.beautyMakeupEyelashesCurl,
      ZegoBeautyPluginEffectsType.beautyMakeupEyelashesEverlong.toString():
          translationText.beautyMakeupEyelashesEverlong,
      ZegoBeautyPluginEffectsType.beautyMakeupEyelashesThick.toString():
          translationText.beautyMakeupEyelashesThick,
      ZegoBeautyPluginEffectsType.beautyMakeupEyelinerNatural.toString():
          translationText.beautyMakeupEyelashesNatural,
      ZegoBeautyPluginEffectsType.beautyMakeupEyelinerCatEye.toString():
          translationText.beautyMakeupEyelinerCatEye,
      ZegoBeautyPluginEffectsType.beautyMakeupEyelinerNaughty.toString():
          translationText.beautyMakeupEyelinerNaughty,
      ZegoBeautyPluginEffectsType.beautyMakeupEyelinerInnocent.toString():
          translationText.beautyMakeupEyelinerInnocent,
      ZegoBeautyPluginEffectsType.beautyMakeupEyelinerDignified.toString():
          translationText.beautyMakeupEyelinerDignified,
      ZegoBeautyPluginEffectsType.beautyMakeupEyeshadowPinkMist.toString():
          translationText.beautyMakeupEyeshadowPinkMist,
      ZegoBeautyPluginEffectsType.beautyMakeupEyeshadowShimmerPink.toString():
          translationText.beautyMakeupEyeshadowShimmerPink,
      ZegoBeautyPluginEffectsType.beautyMakeupEyeshadowTeaBrown.toString():
          translationText.beautyMakeupEyeshadowTeaBrown,
      ZegoBeautyPluginEffectsType.beautyMakeupEyeshadowBrightOrange.toString():
          translationText.beautyMakeupEyeshadowBrightOrange,
      ZegoBeautyPluginEffectsType.beautyMakeupEyeshadowMochaBrown.toString():
          translationText.beautyMakeupEyeshadowMochaBrown,
      ZegoBeautyPluginEffectsType.beautyMakeupColoredContactsDarknightBlack
              .toString():
          translationText.beautyMakeupColoredContactsDarknightBlack,
      ZegoBeautyPluginEffectsType.beautyMakeupColoredContactsStarryBlue
          .toString(): translationText.beautyMakeupColoredContactsStarryBlue,
      ZegoBeautyPluginEffectsType.beautyMakeupColoredContactsBrownGreen
          .toString(): translationText.beautyMakeupColoredContactsBrownGreen,
      ZegoBeautyPluginEffectsType.beautyMakeupColoredContactsLightsBrown
          .toString(): translationText.beautyMakeupColoredContactsLightsBrown,
      ZegoBeautyPluginEffectsType.beautyMakeupColoredContactsChocolateBrown
              .toString():
          translationText.beautyMakeupColoredContactsChocolateBrown,
      ZegoBeautyPluginEffectsType.beautyStyleMakeupInnocentEyes.toString():
          translationText.beautyStyleMakeupInnocentEyes,
      ZegoBeautyPluginEffectsType.beautyStyleMakeupMilkyEyes.toString():
          translationText.beautyStyleMakeupMilkyEyes,
      ZegoBeautyPluginEffectsType.beautyStyleMakeupCutieCool.toString():
          translationText.beautyStyleMakeupCutieCool,
      ZegoBeautyPluginEffectsType.beautyStyleMakeupPureSexy.toString():
          translationText.beautyStyleMakeupPureSexy,
      ZegoBeautyPluginEffectsType.beautyStyleMakeupFlawless.toString():
          translationText.beautyStyleMakeupFlawless,
      ZegoBeautyPluginEffectsType.filterNaturalCreamy.toString():
          translationText.filterNaturalCreamy,
      ZegoBeautyPluginEffectsType.filterNaturalBrighten.toString():
          translationText.filterNaturalBrighten,
      ZegoBeautyPluginEffectsType.filterNaturalFresh.toString():
          translationText.filterNaturalFresh,
      ZegoBeautyPluginEffectsType.filterNaturalAutumn.toString():
          translationText.filterNaturalAutumn,
      ZegoBeautyPluginEffectsType.filterGrayMonet.toString():
          translationText.filterGrayMonet,
      ZegoBeautyPluginEffectsType.filterGrayNight.toString():
          translationText.filterGrayNight,
      ZegoBeautyPluginEffectsType.filterGrayFilmlike.toString():
          translationText.filterGrayFilmlike,
      ZegoBeautyPluginEffectsType.filterDreamySunset.toString():
          translationText.filterDreamySunset,
      ZegoBeautyPluginEffectsType.filterDreamyCozily.toString():
          translationText.filterDreamyCozily,
      ZegoBeautyPluginEffectsType.filterDreamySweet.toString():
          translationText.filterDreamySweet,
      ZegoBeautyPluginEffectsType.backgroundGreenScreenSegmentation.toString():
          translationText.backgroundGreenScreenSegmentation,
      ZegoBeautyPluginEffectsType.backgroundPortraitSegmentation.toString():
          translationText.backgroundPortraitSegmentation,
      ZegoBeautyPluginEffectsType.backgroundMosaicing.toString():
          translationText.backgroundMosaicing,
      ZegoBeautyPluginEffectsType.backgroundGaussianBlur.toString():
          translationText.backgroundGaussianBlur,
      ZegoUIKitBeautyMakeupType.lipstick.toString():
          translationText.beautyMakeupLipstick,
      ZegoUIKitBeautyMakeupType.eyelashes.toString():
          translationText.beautyMakeupEyelashe,
      ZegoUIKitBeautyMakeupType.eyeliner.toString():
          translationText.beautyMakeupEyeliner,
      ZegoUIKitBeautyMakeupType.eyeshadow.toString():
          translationText.beautyMakeupEyeshadow,
      ZegoUIKitBeautyMakeupType.color.toString():
          translationText.beautyMakeupColoredContacts,
      ZegoUIKitBeautyMakeupType.blusher.toString():
          translationText.beautyMakeupBlusher,
      ZegoUIKitBeautyMainTabType.beauty.toString():
          translationText.titleBeautify,
      ZegoUIKitBeautyTabType.basic.toString(): translationText.titleBeautyBasic,
      ZegoUIKitBeautyTabType.advanced.toString():
          translationText.titleBeautyAdvanced,
      ZegoUIKitBeautyTabType.beautyMakeup.toString():
          translationText.titleBeautyMakeup,
      ZegoUIKitBeautyTabType.styleMakeup.toString():
          translationText.titleBeautyStyleMakeup,
      ZegoUIKitBeautyMainTabType.filter.toString(): translationText.titleFilter,
      ZegoUIKitFilterTabType.nature.toString():
          translationText.titleFilterNatural,
      ZegoUIKitFilterTabType.grayTone.toString():
          translationText.titleFilterGray,
      ZegoUIKitFilterTabType.dream.toString():
          translationText.titleFilterDreamy,
      ZegoUIKitBeautyMainTabType.sticker.toString():
          translationText.titleStickers,
      ZegoUIKitStickerTabType.twoD.toString(): translationText.titleStickers,
      ZegoUIKitBeautyMainTabType.background.toString():
          translationText.titleBackground,
      ZegoUIKitBackgroundTabType.background.toString():
          translationText.titleBackground,
      ZegoUIKitBeautyResetType.reset.toString(): translationText.beautyReset,
      ZegoUIKitBeautyResetType.originalDraw.toString():
          translationText.beautyNone,
      ZegoUIKitBeautyResetType.originalDrawRect.toString():
          translationText.beautyNone,
    };

    iconUrlMap = {
      ZegoBeautyPluginEffectsType.beautyBasicSmoothing.toString():
          StyleIconUrls.beautySkinningSmoothingUrl,
      ZegoBeautyPluginEffectsType.beautyBasicSkinTone.toString():
          StyleIconUrls.beautySkinningToneUrl,
      ZegoBeautyPluginEffectsType.beautyBasicBlusher.toString():
          StyleIconUrls.beautySkinningBlushUrl,
      ZegoBeautyPluginEffectsType.beautyBasicSharpening.toString():
          StyleIconUrls.beautySkinningSharpenUrl,
      ZegoBeautyPluginEffectsType.beautyBasicWrinkles.toString():
          StyleIconUrls.beautySkinningWrinklesUrl,
      ZegoBeautyPluginEffectsType.beautyBasicDarkCircles.toString():
          StyleIconUrls.beautySkinningDarkCircleUrl,
      ZegoBeautyPluginEffectsType.beautyAdvancedFaceSlimming.toString():
          StyleIconUrls.beautyShapeFaceSlimmingUrl,
      ZegoBeautyPluginEffectsType.beautyAdvancedEyesEnlarging.toString():
          StyleIconUrls.beautyShapeEnlargingUrl,
      ZegoBeautyPluginEffectsType.beautyAdvancedEyesBrightening.toString():
          StyleIconUrls.beautyShapeBrighteningUrl,
      ZegoBeautyPluginEffectsType.beautyAdvancedChinLengthening.toString():
          StyleIconUrls.beautyShapeLengtheningUrl,
      ZegoBeautyPluginEffectsType.beautyAdvancedMouthReshape.toString():
          StyleIconUrls.beautyShapeReshapeUrl,
      ZegoBeautyPluginEffectsType.beautyAdvancedTeethWhitening.toString():
          StyleIconUrls.beautyShapeWhitenUrl,
      ZegoBeautyPluginEffectsType.beautyAdvancedNoseSlimming.toString():
          StyleIconUrls.beautyShapenNoseSlimmingUrl,
      ZegoBeautyPluginEffectsType.beautyAdvancedNoseLengthening.toString():
          StyleIconUrls.beautyShapeNoseLengthenUrl,
      ZegoBeautyPluginEffectsType.beautyAdvancedFaceShortening.toString():
          StyleIconUrls.beautyShapeShortenUrl,
      ZegoBeautyPluginEffectsType.beautyAdvancedMandibleSlimming.toString():
          StyleIconUrls.beautyShapeMandibleUrl,
      ZegoBeautyPluginEffectsType.beautyAdvancedCheekboneSlimming.toString():
          StyleIconUrls.beautyShapeCheekBoneUrl,
      ZegoBeautyPluginEffectsType.beautyAdvancedForeheadSlimming.toString():
          StyleIconUrls.beautyShapeForeHeadUrl,
      ZegoBeautyPluginEffectsType.beautyMakeupLipstickCameoPink.toString():
          StyleIconUrls.beautyMakeupLipstickCameoPinkUrl,
      ZegoBeautyPluginEffectsType.beautyMakeupLipstickSweetOrange.toString():
          StyleIconUrls.beautyMakeupLipstickSweetOrangeUrl,
      ZegoBeautyPluginEffectsType.beautyMakeupLipstickRustRed.toString():
          StyleIconUrls.beautyMakeupLipstickRustRedUrl,
      ZegoBeautyPluginEffectsType.beautyMakeupLipstickCoral.toString():
          StyleIconUrls.beautyMakeupLipstickCoralUrl,
      ZegoBeautyPluginEffectsType.beautyMakeupLipstickRedVelvet.toString():
          StyleIconUrls.beautyMakeupLipstickRedVelvetUrl,
      ZegoBeautyPluginEffectsType.beautyMakeupBlusherSlightlyDrunk.toString():
          StyleIconUrls.beautyMakeupBlushSlightlyUrl,
      ZegoBeautyPluginEffectsType.beautyMakeupBlusherPeach.toString():
          StyleIconUrls.beautyMakeupBlushPeachUrl,
      ZegoBeautyPluginEffectsType.beautyMakeupBlusherMilkyOrange.toString():
          StyleIconUrls.beautyMakeupBlushMilkyUrl,
      ZegoBeautyPluginEffectsType.beautyMakeupBlusherApricotPink.toString():
          StyleIconUrls.beautyMakeupBlushApricotUrl,
      ZegoBeautyPluginEffectsType.beautyMakeupBlusherSweetOrange.toString():
          StyleIconUrls.beautyMakeupBlushSweetOrangeUrl,
      ZegoBeautyPluginEffectsType.beautyMakeupEyelashesNatural.toString():
          StyleIconUrls.beautyMakeupEyelashNatureUrl,
      ZegoBeautyPluginEffectsType.beautyMakeupEyelashesTender.toString():
          StyleIconUrls.beautyMakeupEyelashTenderUrl,
      ZegoBeautyPluginEffectsType.beautyMakeupEyelashesCurl.toString():
          StyleIconUrls.beautyMakeupEyelashCurlUrl,
      ZegoBeautyPluginEffectsType.beautyMakeupEyelashesEverlong.toString():
          StyleIconUrls.beautyMakeupEyelashEverlongUrl,
      ZegoBeautyPluginEffectsType.beautyMakeupEyelashesThick.toString():
          StyleIconUrls.beautyMakeupEyelashThickUrl,
      ZegoBeautyPluginEffectsType.beautyMakeupEyeshadowPinkMist.toString():
          StyleIconUrls.beautyMakeupEyeShadowPinkUrl,
      ZegoBeautyPluginEffectsType.beautyMakeupEyeshadowShimmerPink.toString():
          StyleIconUrls.beautyMakeupEyeShadowShimmerUrl,
      ZegoBeautyPluginEffectsType.beautyMakeupEyeshadowTeaBrown.toString():
          StyleIconUrls.beautyMakeupEyeShadowTeaUrl,
      ZegoBeautyPluginEffectsType.beautyMakeupEyeshadowBrightOrange.toString():
          StyleIconUrls.beautyMakeupEyeShadowBrightOrangeUrl,
      ZegoBeautyPluginEffectsType.beautyMakeupEyeshadowMochaBrown.toString():
          StyleIconUrls.beautyMakeupEyeShadowMochaUrl,
      ZegoBeautyPluginEffectsType.beautyMakeupEyelinerNatural.toString():
          StyleIconUrls.beautyMakeupEyeLineNatureUrl,
      ZegoBeautyPluginEffectsType.beautyMakeupEyelinerCatEye.toString():
          StyleIconUrls.beautyMakeupEyeLineCatUrl,
      ZegoBeautyPluginEffectsType.beautyMakeupEyelinerNaughty.toString():
          StyleIconUrls.beautyMakeupEyeLineNaughtyUrl,
      ZegoBeautyPluginEffectsType.beautyMakeupEyelinerInnocent.toString():
          StyleIconUrls.beautyMakeupEyeLineInnocentUrl,
      ZegoBeautyPluginEffectsType.beautyMakeupEyelinerDignified.toString():
          StyleIconUrls.beautyMakeupEyeLineDignifiedUrl,
      ZegoBeautyPluginEffectsType.beautyMakeupColoredContactsDarknightBlack
          .toString(): StyleIconUrls.beautyMakeupColorDarknightBlackUrl,
      ZegoBeautyPluginEffectsType.beautyMakeupColoredContactsStarryBlue
          .toString(): StyleIconUrls.beautyMakeupColorStarryBlueUrl,
      ZegoBeautyPluginEffectsType.beautyMakeupColoredContactsBrownGreen
          .toString(): StyleIconUrls.beautyMakeupColorBrownGreenUrl,
      ZegoBeautyPluginEffectsType.beautyMakeupColoredContactsLightsBrown
          .toString(): StyleIconUrls.beautyMakeupColorLightBrownUrl,
      ZegoBeautyPluginEffectsType.beautyMakeupColoredContactsChocolateBrown
          .toString(): StyleIconUrls.beautyMakeupColorChocolateUrl,
      ZegoBeautyPluginEffectsType.beautyStyleMakeupInnocentEyes.toString():
          StyleIconUrls.beautyStyleMakeupInnocentUrl,
      ZegoBeautyPluginEffectsType.beautyStyleMakeupMilkyEyes.toString():
          StyleIconUrls.beautyStyleMakeupMilkEyesUrl,
      ZegoBeautyPluginEffectsType.beautyStyleMakeupCutieCool.toString():
          StyleIconUrls.beautyStyleMakeupCuitUrl,
      ZegoBeautyPluginEffectsType.beautyStyleMakeupPureSexy.toString():
          StyleIconUrls.beautyStyleMakeupSexyUrl,
      ZegoBeautyPluginEffectsType.beautyStyleMakeupFlawless.toString():
          StyleIconUrls.beautyStyleMakeupFlawlessUrl,
      ZegoBeautyPluginEffectsType.filterNaturalCreamy.toString():
          StyleIconUrls.filterNatureCreamyUrl,
      ZegoBeautyPluginEffectsType.filterNaturalBrighten.toString():
          StyleIconUrls.filterNatureBrightenUrl,
      ZegoBeautyPluginEffectsType.filterNaturalFresh.toString():
          StyleIconUrls.filterNatureFreshUrl,
      ZegoBeautyPluginEffectsType.filterNaturalAutumn.toString():
          StyleIconUrls.filterNatureAutumnUrl,
      ZegoBeautyPluginEffectsType.filterGrayMonet.toString():
          StyleIconUrls.filterGrayMonetUrl,
      ZegoBeautyPluginEffectsType.filterGrayNight.toString():
          StyleIconUrls.filterGrayNightUrl,
      ZegoBeautyPluginEffectsType.filterGrayFilmlike.toString():
          StyleIconUrls.filterGrayfilmlikeUrl,
      ZegoBeautyPluginEffectsType.filterDreamySunset.toString():
          StyleIconUrls.filterDreamySunsetUrl,
      ZegoBeautyPluginEffectsType.filterDreamyCozily.toString():
          StyleIconUrls.filterDreamyCozilyUrl,
      ZegoBeautyPluginEffectsType.filterDreamySweet.toString():
          StyleIconUrls.filterDreamySweetUrl,
      ZegoBeautyPluginEffectsType.backgroundGreenScreenSegmentation.toString():
          StyleIconUrls.backgroundGreenScreenUrl,
      ZegoBeautyPluginEffectsType.backgroundPortraitSegmentation.toString():
          StyleIconUrls.backgroundPortraitUrl,
      ZegoBeautyPluginEffectsType.backgroundMosaicing.toString():
          StyleIconUrls.backgroundMosacingUrl,
      ZegoBeautyPluginEffectsType.backgroundGaussianBlur.toString():
          StyleIconUrls.backgroundGaussianBlurUrl,
      ZegoUIKitBeautyMakeupType.lipstick.toString():
          StyleIconUrls.beautyMakeupLipstickUrl,
      ZegoUIKitBeautyMakeupType.eyelashes.toString():
          StyleIconUrls.beautyMakeupEyelashUrl,
      ZegoUIKitBeautyMakeupType.eyeliner.toString():
          StyleIconUrls.beautyMakeupEyelineUrl,
      ZegoUIKitBeautyMakeupType.eyeshadow.toString():
          StyleIconUrls.beautyMakeupEyeshadowUrl,
      ZegoUIKitBeautyMakeupType.color.toString():
          StyleIconUrls.beautyMakeupColorUrl,
      ZegoUIKitBeautyMakeupType.blusher.toString():
          StyleIconUrls.beautyMakeupBlushUrl,
      ZegoUIKitBeautyResetType.reset.toString(): StyleIconUrls.iconResertUrl,
      ZegoUIKitBeautyResetType.originalDraw.toString():
          StyleIconUrls.iconOriginalDrawUrl,
      ZegoUIKitBeautyResetType.originalDrawRect.toString():
          StyleIconUrls.iconOriginalDrawRectUrl,
    };

    beautyResourceMap = {
      ZegoBeautyPluginEffectsType.beautyMakeupBlusherApricotPink.toString():
          BeautyResource.makeupBlusherApricotPink,
      ZegoBeautyPluginEffectsType.beautyMakeupBlusherMilkyOrange.toString():
          BeautyResource.makeupBlusherMilkyOrange,
      ZegoBeautyPluginEffectsType.beautyMakeupBlusherPeach.toString():
          BeautyResource.makeupBlusherPeach,
      ZegoBeautyPluginEffectsType.beautyMakeupBlusherSlightlyDrunk.toString():
          BeautyResource.makeupBlusherSlightlyDrunk,
      ZegoBeautyPluginEffectsType.beautyMakeupBlusherSweetOrange.toString():
          BeautyResource.makeupBlusherSweetOrange,
      ZegoBeautyPluginEffectsType.beautyMakeupColoredContactsBrownGreen
          .toString(): BeautyResource.makeupColoredContactsBrownGreen,
      ZegoBeautyPluginEffectsType.beautyMakeupColoredContactsDarknightBlack
          .toString(): BeautyResource.makeupColoredContactsDarknightBlack,
      ZegoBeautyPluginEffectsType.beautyMakeupColoredContactsLightsBrown
          .toString(): BeautyResource.makeupColoredContactsLightsBrown,
      ZegoBeautyPluginEffectsType.beautyMakeupColoredContactsStarryBlue
          .toString(): BeautyResource.makeupColoredContactsStarryBlue,
      ZegoBeautyPluginEffectsType.beautyMakeupEyelashesCurl.toString():
          BeautyResource.makeupEyelashesCurl,
      ZegoBeautyPluginEffectsType.beautyMakeupEyelashesEverlong.toString():
          BeautyResource.makeupEyelashesEverlong,
      ZegoBeautyPluginEffectsType.beautyMakeupEyelashesNatural.toString():
          BeautyResource.makeupEyelashesNatural,
      ZegoBeautyPluginEffectsType.beautyMakeupEyelashesTender.toString():
          BeautyResource.makeupEyelashesTender,
      ZegoBeautyPluginEffectsType.beautyMakeupEyelashesThick.toString():
          BeautyResource.makeupEyelashesThick,
      ZegoBeautyPluginEffectsType.beautyMakeupEyelinerCatEye.toString():
          BeautyResource.makeupEyelinerCatEye,
      ZegoBeautyPluginEffectsType.beautyMakeupEyelinerDignified.toString():
          BeautyResource.makeupEyelinerDignified,
      ZegoBeautyPluginEffectsType.beautyMakeupEyelinerInnocent.toString():
          BeautyResource.makeupEyelinerInnocent,
      ZegoBeautyPluginEffectsType.beautyMakeupEyelinerNatural.toString():
          BeautyResource.makeupEyelinerNatural,
      ZegoBeautyPluginEffectsType.beautyMakeupEyelinerNaughty.toString():
          BeautyResource.makeupEyelinerNaughty,
      ZegoBeautyPluginEffectsType.beautyMakeupEyeshadowBrightOrange.toString():
          BeautyResource.makeupEyeshadowBrightOrange,
      ZegoBeautyPluginEffectsType.beautyMakeupEyeshadowMochaBrown.toString():
          BeautyResource.makeupEyeshadowMochaBrown,
      ZegoBeautyPluginEffectsType.beautyMakeupEyeshadowPinkMist.toString():
          BeautyResource.makeupEyeshadowPinkMist,
      ZegoBeautyPluginEffectsType.beautyMakeupEyeshadowShimmerPink.toString():
          BeautyResource.makeupEyeshadowShimmerPink,
      ZegoBeautyPluginEffectsType.beautyMakeupEyeshadowTeaBrown.toString():
          BeautyResource.makeupEyeshadowTeaBrown,
      ZegoBeautyPluginEffectsType.beautyMakeupLipstickCameoPink.toString():
          BeautyResource.makeupLipstickCameoPink,
      ZegoBeautyPluginEffectsType.beautyMakeupLipstickCoral.toString():
          BeautyResource.makeupLipstickCoral,
      ZegoBeautyPluginEffectsType.beautyMakeupLipstickRedVelvet.toString():
          BeautyResource.makeupLipstickRedVelvet,
      ZegoBeautyPluginEffectsType.beautyMakeupLipstickRustRed.toString():
          BeautyResource.makeupLipstickRustRed,
      ZegoBeautyPluginEffectsType.beautyMakeupLipstickSweetOrange.toString():
          BeautyResource.makeupLipstickSweetOrange,
      ZegoBeautyPluginEffectsType.beautyStyleMakeupFlawless.toString():
          BeautyResource.styleMakeupFlawless,
      ZegoBeautyPluginEffectsType.beautyStyleMakeupInnocentEyes.toString():
          BeautyResource.styleMakeupInnocentEyes,
      ZegoBeautyPluginEffectsType.beautyStyleMakeupMilkyEyes.toString():
          BeautyResource.styleMakeupMilkyEyes,
      ZegoBeautyPluginEffectsType.beautyStyleMakeupPureSexy.toString():
          BeautyResource.styleMakeupPureSexy,
      ZegoBeautyPluginEffectsType.beautyStyleMakeupCutieCool.toString():
          BeautyResource.styleMakeupCutieCool,
      ZegoBeautyPluginEffectsType.filterDreamyCozily.toString():
          BeautyResource.filterDreamyCozily,
      ZegoBeautyPluginEffectsType.filterDreamySunset.toString():
          BeautyResource.filterDreamySunset,
      ZegoBeautyPluginEffectsType.filterDreamySweet.toString():
          BeautyResource.filterDreamySweet,
      ZegoBeautyPluginEffectsType.filterGrayFilmlike.toString():
          BeautyResource.filterGrayFilmlike,
      ZegoBeautyPluginEffectsType.filterGrayMonet.toString():
          BeautyResource.filterGrayMonet,
      ZegoBeautyPluginEffectsType.filterGrayNight.toString():
          BeautyResource.filterGrayNight,
      ZegoBeautyPluginEffectsType.filterNaturalAutumn.toString():
          BeautyResource.filterNaturalAutumn,
      ZegoBeautyPluginEffectsType.filterNaturalBrighten.toString():
          BeautyResource.filterNaturalBrighten,
      ZegoBeautyPluginEffectsType.filterNaturalCreamy.toString():
          BeautyResource.filterNaturalCreamy,
      ZegoBeautyPluginEffectsType.filterNaturalFresh.toString():
          BeautyResource.filterNaturalFresh,
    };
  }
}

/// UIKitBeautyType
enum ZegoUIKitBeautyType {
  none,
}

/// BeautyMainType
enum ZegoBeautyMainType {
  filter,
  beauty,
  sticker,
  background,
}

/// BeautyType
enum ZegoBeautyType {
  basic,
  advanced,
  beautyMakeup,
  styleMakeup,
}

/// FilterType
enum ZegoFilterType {
  nature,
  grayTone,
  dream,
}

/// StickerType
enum ZegoStickerType {
  twoD,
}

/// BackgroundType
enum ZegoBackgroundType {
  background,
}
