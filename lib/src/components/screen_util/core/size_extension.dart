// Dart imports:
import 'dart:math';

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:zego_uikit_beauty_plugin/src/components/screen_util/core/screen_util.dart';

/// @nodoc
extension ZegoBeautySizeExtension on num {
  ///[ZegoBeautyScreenUtil.setWidth]
  double get zW => ZegoBeautyScreenUtil().setWidth(this);

  ///[ZegoBeautyScreenUtil.setHeight]
  double get zH => ZegoBeautyScreenUtil().setHeight(this);

  ///[ZegoBeautyScreenUtil.radius]
  double get zR => ZegoBeautyScreenUtil().radius(this);

  ///[ZegoBeautyScreenUtil.diagonal]
  double get zDG => ZegoBeautyScreenUtil().diagonal(this);

  ///[ZegoBeautyScreenUtil.diameter]
  double get zDM => ZegoBeautyScreenUtil().diameter(this);

  ///[ZegoBeautyScreenUtil.setSp]
  double get zSP => ZegoBeautyScreenUtil().setSp(this);

  ///smart size :  it check your value - if it is bigger than your value it will set your value
  ///for example, you have set 16.sm() , if for your screen 16.sp() is bigger than 16 , then it will set 16 not 16.sp()
  ///I think that it is good for save size balance on big sizes of screen
  double get zSPMin => min(toDouble(), zSP);

  @Deprecated('use spMin instead')
  double get zSM => min(toDouble(), zSP);

  double get zSPMax => max(toDouble(), zSP);

  ///屏幕宽度的倍数
  ///Multiple of screen width
  double get zSW => ZegoBeautyScreenUtil().screenWidth * this;

  ///屏幕高度的倍数
  ///Multiple of screen height
  double get zSH => ZegoBeautyScreenUtil().screenHeight * this;

  ///[ZegoBeautyScreenUtil.setHeight]
  SizedBox get zVerticalSpace =>
      ZegoBeautyScreenUtil().setVerticalSpacing(this);

  ///[ZegoBeautyScreenUtil.setVerticalSpacingFromWidth]
  SizedBox get zVerticalSpaceFromWidth =>
      ZegoBeautyScreenUtil().setVerticalSpacingFromWidth(this);

  ///[ZegoBeautyScreenUtil.setWidth]
  SizedBox get zHorizontalSpace =>
      ZegoBeautyScreenUtil().setHorizontalSpacing(this);

  ///[ZegoBeautyScreenUtil.radius]
  SizedBox get zHorizontalSpaceRadius =>
      ZegoBeautyScreenUtil().setHorizontalSpacingRadius(this);

  ///[ZegoBeautyScreenUtil.radius]
  SizedBox get zVerticalSpacingRadius =>
      ZegoBeautyScreenUtil().setVerticalSpacingRadius(this);

  ///[ZegoBeautyScreenUtil.diameter]
  SizedBox get zHorizontalSpaceDiameter =>
      ZegoBeautyScreenUtil().setHorizontalSpacingDiameter(this);

  ///[ZegoBeautyScreenUtil.diameter]
  SizedBox get zVerticalSpacingDiameter =>
      ZegoBeautyScreenUtil().setVerticalSpacingDiameter(this);

  ///[ZegoBeautyScreenUtil.diagonal]
  SizedBox get zHorizontalSpaceDiagonal =>
      ZegoBeautyScreenUtil().setHorizontalSpacingDiagonal(this);

  ///[ZegoBeautyScreenUtil.diagonal]
  SizedBox get zVerticalSpacingDiagonal =>
      ZegoBeautyScreenUtil().setVerticalSpacingDiagonal(this);
}

/// @nodoc
extension ZegoBeautyEdgeInsetsExtension on EdgeInsets {
  /// Creates adapt insets using r [ZegoBeautySizeExtension].
  EdgeInsets get zR => copyWith(
        top: top.zR,
        bottom: bottom.zR,
        right: right.zR,
        left: left.zR,
      );

  EdgeInsets get dm => copyWith(
        top: top.zDM,
        bottom: bottom.zDM,
        right: right.zDM,
        left: left.zDM,
      );

  EdgeInsets get dg => copyWith(
        top: top.zDG,
        bottom: bottom.zDG,
        right: right.zDG,
        left: left.zDG,
      );

  EdgeInsets get w => copyWith(
        top: top.zW,
        bottom: bottom.zW,
        right: right.zW,
        left: left.zW,
      );

  EdgeInsets get h => copyWith(
        top: top.zH,
        bottom: bottom.zH,
        right: right.zH,
        left: left.zH,
      );
}

/// @nodoc
extension ZegoBeautyBorderRaduisExtension on BorderRadius {
  /// Creates adapt BorderRadius using r [ZegoBeautySizeExtension].
  BorderRadius get r => copyWith(
        bottomLeft: bottomLeft.zR,
        bottomRight: bottomRight.zR,
        topLeft: topLeft.zR,
        topRight: topRight.zR,
      );

  BorderRadius get w => copyWith(
        bottomLeft: bottomLeft.zW,
        bottomRight: bottomRight.zW,
        topLeft: topLeft.zW,
        topRight: topRight.zW,
      );

  BorderRadius get h => copyWith(
        bottomLeft: bottomLeft.zH,
        bottomRight: bottomRight.zH,
        topLeft: topLeft.zH,
        topRight: topRight.zH,
      );
}

/// @nodoc
extension ZegoBeautyRaduisExtension on Radius {
  /// Creates adapt Radius using r [ZegoBeautySizeExtension].
  Radius get zR => Radius.elliptical(x.zR, y.zR);

  Radius get zDM => Radius.elliptical(
        x.zDM,
        y.zDM,
      );

  Radius get zDG => Radius.elliptical(
        x.zDG,
        y.zDG,
      );

  Radius get zW => Radius.elliptical(x.zW, y.zW);

  Radius get zH => Radius.elliptical(x.zH, y.zH);
}

/// @nodoc
extension ZegoBeautyBoxConstraintsExtension on BoxConstraints {
  /// Creates adapt BoxConstraints using r [ZegoBeautySizeExtension].
  BoxConstraints get zR => copyWith(
        maxHeight: maxHeight.zR,
        maxWidth: maxWidth.zR,
        minHeight: minHeight.zR,
        minWidth: minWidth.zR,
      );

  /// Creates adapt BoxConstraints using h-w [ZegoBeautySizeExtension].
  BoxConstraints get zHW => copyWith(
        maxHeight: maxHeight.zH,
        maxWidth: maxWidth.zW,
        minHeight: minHeight.zH,
        minWidth: minWidth.zW,
      );

  BoxConstraints get zW => copyWith(
        maxHeight: maxHeight.zW,
        maxWidth: maxWidth.zW,
        minHeight: minHeight.zW,
        minWidth: minWidth.zW,
      );

  BoxConstraints get zH => copyWith(
        maxHeight: maxHeight.zH,
        maxWidth: maxWidth.zH,
        minHeight: minHeight.zH,
        minWidth: minWidth.zH,
      );
}
