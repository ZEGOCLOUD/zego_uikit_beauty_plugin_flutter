// Flutter imports:
import 'package:flutter/material.dart';

/// BeautyImage
class BeautyImage {
  static Image asset(
    String name, {
    double? width,
    double? height,
  }) {
    return Image.asset(
      name,
      package: 'zego_uikit_beauty_plugin',
      width: width,
      height: height,
    );
  }
}

/// StyleIconUrls
class StyleIconUrls {
  static const String beautySkinningSmoothingUrl =
      'assets/icons/beauty/skin/beauty_skin_smoothing.png';
  static const String beautySkinningToneUrl =
      'assets/icons/beauty/skin/beauty_skin_tone.png';
  static const String beautySkinningBlushUrl =
      'assets/icons/beauty/skin/beauty_skin_blusher.png';
  static const String beautySkinningSharpenUrl =
      'assets/icons/beauty/skin/beauty_skin_sharpening.png';
  static const String beautySkinningDarkCircleUrl =
      'assets/icons/beauty/skin/beauty_skin_dark_circles.png';
  static const String beautySkinningWrinklesUrl =
      'assets/icons/beauty/skin/beauty_skin_wrinkles.png';

  static const String beautyShapeBrighteningUrl =
      'assets/icons/beauty/shape/beauty_brightening.png';
  static const String beautyShapeCheekBoneUrl =
      'assets/icons/beauty/shape/beauty_cheekbone.png';
  static const String beautyShapeEnlargingUrl =
      'assets/icons/beauty/shape/beauty_enlarging.png';
  static const String beautyShapeFaceSlimmingUrl =
      'assets/icons/beauty/shape/beauty_face_slimming.png';
  static const String beautyShapeForeHeadUrl =
      'assets/icons/beauty/shape/beauty_forehead.png';
  static const String beautyShapeLengtheningUrl =
      'assets/icons/beauty/shape/beauty_lengthening.png';
  static const String beautyShapeMandibleUrl =
      'assets/icons/beauty/shape/beauty_mandible.png';
  static const String beautyShapeNoseLengthenUrl =
      'assets/icons/beauty/shape/beauty_nose_lengthening.png';
  static const String beautyShapenNoseSlimmingUrl =
      'assets/icons/beauty/shape/beauty_nose_slimming.png';
  static const String beautyShapeReshapeUrl =
      'assets/icons/beauty/shape/beauty_reshape.png';
  static const String beautyShapeShortenUrl =
      'assets/icons/beauty/shape/beauty_shortening.png';
  static const String beautyShapeWhitenUrl =
      'assets/icons/beauty/shape/beauty_whitening.png';

  static const String beautyMakeupBlushUrl =
      'assets/icons/beauty/makeup/beauty_makeup_blusher.png';
  static const String beautyMakeupEyelashUrl =
      'assets/icons/beauty/makeup/beauty_makeup_eyelash.png';
  static const String beautyMakeupEyelineUrl =
      'assets/icons/beauty/makeup/beauty_makeup_eyeliner.png';
  static const String beautyMakeupEyeshadowUrl =
      'assets/icons/beauty/makeup/beauty_makeup_eyeshadow.png';
  static const String beautyMakeupLipstickUrl =
      'assets/icons/beauty/makeup/beauty_makeup_lipstick.png';
  static const String beautyMakeupColorUrl =
      'assets/icons/beauty/makeup/beauty_makeup_colored_contacts.png';

  static const String beautyMakeupLipstickCameoPinkUrl =
      'assets/icons/beauty/makeup/lipstick/beauty_lipstick_cameo_pink.png';
  static const String beautyMakeupLipstickCoralUrl =
      'assets/icons/beauty/makeup/lipstick/beauty_lipstick_coral.png';
  static const String beautyMakeupLipstickRedVelvetUrl =
      'assets/icons/beauty/makeup/lipstick/beauty_lipstick_red_velvet.png';
  static const String beautyMakeupLipstickRustRedUrl =
      'assets/icons/beauty/makeup/lipstick/beauty_lipstick_rust_red.png';
  static const String beautyMakeupLipstickSweetOrangeUrl =
      'assets/icons/beauty/makeup/lipstick/beauty_lipstick_sweet_orange.png';

  static const String beautyMakeupEyeShadowBrightOrangeUrl =
      'assets/icons/beauty/makeup/eyeshadow/beauty_eyesshadow_bright_orange.png';
  static const String beautyMakeupEyeShadowMochaUrl =
      'assets/icons/beauty/makeup/eyeshadow/beauty_eyesshadow_mocha_brown.png';
  static const String beautyMakeupEyeShadowPinkUrl =
      'assets/icons/beauty/makeup/eyeshadow/beauty_eyesshadow_pink_mist.png';
  static const String beautyMakeupEyeShadowShimmerUrl =
      'assets/icons/beauty/makeup/eyeshadow/beauty_eyesshadow_shimmer_pink.png';
  static const String beautyMakeupEyeShadowTeaUrl =
      'assets/icons/beauty/makeup/eyeshadow/beauty_eyesshadow_tea_brown.png';

  static const String beautyMakeupEyeLineCatUrl =
      'assets/icons/beauty/makeup/eyeline/beauty_eyeline_cat_eye.png';
  static const String beautyMakeupEyeLineDignifiedUrl =
      'assets/icons/beauty/makeup/eyeline/beauty_eyeline_dignified.png';
  static const String beautyMakeupEyeLineInnocentUrl =
      'assets/icons/beauty/makeup/eyeline/beauty_eyeline_innocent.png';
  static const String beautyMakeupEyeLineNatureUrl =
      'assets/icons/beauty/makeup/eyeline/beauty_eyeline_nature.png';
  static const String beautyMakeupEyeLineNaughtyUrl =
      'assets/icons/beauty/makeup/eyeline/beauty_eyeline_naughty.png';

  static const String beautyMakeupEyelashCurlUrl =
      'assets/icons/beauty/makeup/eyelash/beauty_eyelash_curl.png';
  static const String beautyMakeupEyelashEverlongUrl =
      'assets/icons/beauty/makeup/eyelash/beauty_eyelash_everlong.png';
  static const String beautyMakeupEyelashNatureUrl =
      'assets/icons/beauty/makeup/eyelash/beauty_eyelash_natural.png';
  static const String beautyMakeupEyelashTenderUrl =
      'assets/icons/beauty/makeup/eyelash/beauty_eyelash_tender.png';
  static const String beautyMakeupEyelashThickUrl =
      'assets/icons/beauty/makeup/eyelash/beauty_eyelash_thick.png';

  static const String beautyMakeupBlushApricotUrl =
      'assets/icons/beauty/makeup/blush/beauty_blush_apricot_pink.png';
  static const String beautyMakeupBlushMilkyUrl =
      'assets/icons/beauty/makeup/blush/beauty_blush_milky_orange.png';
  static const String beautyMakeupBlushPeachUrl =
      'assets/icons/beauty/makeup/blush/beauty_blush_peach.png';
  static const String beautyMakeupBlushSlightlyUrl =
      'assets/icons/beauty/makeup/blush/beauty_blush_slightly_drunk.png';
  static const String beautyMakeupBlushSweetOrangeUrl =
      'assets/icons/beauty/makeup/blush/beauty_blush_sweet_orange.png';

  static const String beautyMakeupColorDarknightBlackUrl =
      'assets/icons/beauty/makeup/coloredcontacts/beauty_makeup_darknight_black.png';
  static const String beautyMakeupColorStarryBlueUrl =
      'assets/icons/beauty/makeup/coloredcontacts/beauty_makeup_starry_blue.png';
  static const String beautyMakeupColorBrownGreenUrl =
      'assets/icons/beauty/makeup/coloredcontacts/beauty_makeup_brown_green.png';
  static const String beautyMakeupColorLightBrownUrl =
      'assets/icons/beauty/makeup/coloredcontacts/beauty_makeup_lights_brown.png';
  static const String beautyMakeupColorChocolateUrl =
      'assets/icons/beauty/makeup/coloredcontacts/beauty_makeup_chocolate_brown.png';

  static const String beautyStyleMakeupCuitUrl =
      'assets/icons/beauty/style_makeup/beauty_style_makeup_cutie.png';
  static const String beautyStyleMakeupFlawlessUrl =
      'assets/icons/beauty/style_makeup/beauty_style_makeup_flawless.png';
  static const String beautyStyleMakeupInnocentUrl =
      'assets/icons/beauty/style_makeup/beauty_style_makeup_innocent_eyes.png';
  static const String beautyStyleMakeupMilkEyesUrl =
      'assets/icons/beauty/style_makeup/beauty_style_makeup_milky_eyes.png';
  static const String beautyStyleMakeupSexyUrl =
      'assets/icons/beauty/style_makeup/beauty_style_makeup_sexy.png';

  static const String filterDreamyCozilyUrl =
      'assets/icons/filter/dreamy/filter_dreamy_cozily.png';
  static const String filterDreamySunsetUrl =
      'assets/icons/filter/dreamy/filter_dreamy_sunset.png';
  static const String filterDreamySweetUrl =
      'assets/icons/filter/dreamy/filter_dreamy_sweet.png';

  static const String filterGrayfilmlikeUrl =
      'assets/icons/filter/gray/filter_gray_filmlike.png';
  static const String filterGrayMonetUrl =
      'assets/icons/filter/gray/filter_gray_monet.png';
  static const String filterGrayNightUrl =
      'assets/icons/filter/gray/filter_gray_night.png';

  static const String filterNatureAutumnUrl =
      'assets/icons/filter/nature/filter_nature_autumn.png';
  static const String filterNatureBrightenUrl =
      'assets/icons/filter/nature/filter_nature_brighten.png';
  static const String filterNatureCreamyUrl =
      'assets/icons/filter/nature/filter_nature_creamy.png';
  static const String filterNatureFreshUrl =
      'assets/icons/filter/nature/filter_nature_fresh.png';

  static const String backgroundGaussianBlurUrl =
      'assets/icons/background/background_gaussian_blur.png';
  static const String backgroundGreenScreenUrl =
      'assets/icons/background/background_green_screen_segmentation.png';
  static const String backgroundMosaicUrl =
      'assets/icons/background/background_mosaic_hexagon.png';
  static const String backgroundQuadrangleUrl =
      'assets/icons/background/background_mosaic_quadrangle.png';
  static const String backgroundTriangleUrl =
      'assets/icons/background/background_mosaic_triangle.png';
  static const String backgroundMosacingUrl =
      'assets/icons/background/background_mosaicing.png';
  static const String backgroundPortraitUrl =
      'assets/icons/background/background_portrait_Segmentation.png';

  static const String iconResertUrl = 'assets/icons/beauty_reset_icon.png';
  static const String iconBackUrl = 'assets/icons/icon_back.png';
  static const String iconOriginalDrawRectUrl =
      'assets/icons/icon_original_draw_rect.png';
  static const String iconOriginalDrawUrl =
      'assets/icons/icon_original_draw.png';
}
