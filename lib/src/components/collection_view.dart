// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:zego_uikit_beauty_plugin/src/components/icon_define.dart';
import 'package:zego_uikit_beauty_plugin/src/components/screen_util/screen_util.dart';
import 'package:zego_uikit_beauty_plugin/src/define.dart';
import 'package:zego_uikit_beauty_plugin/src/models/model.dart';
import 'package:zego_uikit_beauty_plugin/zego_uikit_beauty_plugin.dart';

/// BeautyItemClick
typedef BeautyItemClick = void Function(ZegoBeautyItemBaseModel model);

/// BeautyItemResetClick
typedef BeautyItemResetClick = void Function(ZegoBeautyItemCleanModel model);

/// ZegoUIKitBeautyCollectionView
class ZegoUIKitBeautyCollectionView extends StatefulWidget {
  const ZegoUIKitBeautyCollectionView({
    required this.selectItemModelNotifier,
    this.tabModel,
    this.itemClickCallBack,
    this.itemResetCallBack,
    Key? key,
  }) : super(key: key);

  final ZegoTwoLevelBaseTabModel? tabModel;
  final BeautyItemClick? itemClickCallBack;
  final BeautyItemResetClick? itemResetCallBack;
  final ValueNotifier<ZegoBeautyItemBaseModel?> selectItemModelNotifier;

  @override
  State<ZegoUIKitBeautyCollectionView> createState() =>
      _ZegoUIKitBeautyCollectionView();
}

class _ZegoUIKitBeautyCollectionView
    extends State<ZegoUIKitBeautyCollectionView> {
  ValueNotifier<ZegoBeautyItemModel?> basicAndAdvanceSelectModel =
      ValueNotifier(null);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// 创建图标容器的通用方法
  Widget _buildIconContainer({
    required String imagePath,
    double? radius,
    bool hasBorder = false,
    Color? borderColor,
    Widget? overlay,
  }) {
    return SizedBox(
      width: 45.zR,
      height: 45.zR,
      child: Container(
        width: 44.zR,
        height: 44.zR,
        decoration: hasBorder && radius != null
            ? BoxDecoration(
                border: Border.all(
                  color: borderColor ?? Colors.red,
                  width: 1.zW,
                ),
                borderRadius: BorderRadius.circular(radius),
              )
            : null,
        child: Stack(
          children: [
            BeautyImage.asset(imagePath),
            if (overlay != null) overlay,
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.zH,
      color: ZegoUIKitBeautyPlugin
          .instance.core.effectsConfig.uiConfig.backgroundColor,
      child: ListView.builder(
          itemCount: widget.tabModel?.models.length ?? 0,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return itemView(widget.tabModel!.models[index]);
          }),
    );
  }

  /// itemView
  Widget itemView(ZegoBeautyItemBaseModel model) {
    // ValueNotifier<bool> isSelect = ValueNotifier(false);
    return GestureDetector(
      onTap: () {
        if (ZegoUIKitBeautyPlugin.instance.core.isSelectStyleMakeup.value &&
            (widget.tabModel is ZegoStickerTabModel)) {
          return;
        }
        if (model is ZegoBeautyItemModel) {
          widget.selectItemModelNotifier.value = model;
          itemClickUpdateState(model);
          if (widget.itemClickCallBack != null) {
            widget.itemClickCallBack!(model);
          }
        } else if (model is ZegoBeautyItemCleanModel) {
          widget.selectItemModelNotifier.value = null;
          if (model.resetType == ZegoUIKitResetEffectType.beautyBasic ||
              model.resetType == ZegoUIKitResetEffectType.beautyAdvanced) {
            basicAndAdvanceSelectModel.value = null;
          }
          itemClickUpdateState(model);
          if (widget.itemResetCallBack != null) {
            widget.itemResetCallBack!(model);
          }
        }
      },
      child: SizedBox(
        width: 90.zW,
        height: 80.zH,
        child: Column(
          children: [
            SizedBox(height: 15.zH),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: 15.zW),
                Column(
                  children: [
                    itemImageView(model),
                    SizedBox(
                      height: 20.zH,
                      width: 75.zW,
                      child: Text(
                        model.title,
                        style: ZegoUIKitBeautyPlugin.instance.core.effectsConfig
                            .uiConfig.normalTextStyle,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// itemImageView
  Widget itemImageView(ZegoBeautyItemBaseModel model) {
    var imagePath = '';
    double radius = 0;
    if (model is ZegoBeautyItemModel) {
      imagePath = ZegoUIKitBeautyPlugin.instance.core.beautyTranslation
              .iconUrlMap[model.type.toString()] ??
          '';

      radius = ZegoUIKitBeautyTranslation.stypeMakeupEffectsTypes()
                  .contains(model.type) ||
              ZegoUIKitBeautyTranslation.filterNaturalEffectsTypes()
                  .contains(model.type) ||
              ZegoUIKitBeautyTranslation.filterGrayEffectsTypes()
                  .contains(model.type) ||
              ZegoUIKitBeautyTranslation.filterDreamyEffectsTypes()
                  .contains(model.type) ||
              ZegoUIKitBeautyTranslation.backgroundEffectsTypes()
                  .contains(model.type)
          ? 6.zR
          : 22.5.zR;

      if (isBasicOrAdvance(model)) {
        return ValueListenableBuilder<ZegoBeautyItemModel?>(
            valueListenable: basicAndAdvanceSelectModel,
            builder: (context, basicAndAdvanceModel, _) {
              if (basicAndAdvanceModel == model) {
                return _buildIconContainer(
                  imagePath: imagePath,
                  radius: radius,
                  hasBorder: true,
                  borderColor: ZegoUIKitBeautyPlugin.instance.core.effectsConfig
                          .uiConfig.selectedIconBorderColor ??
                      Colors.red,
                  overlay: ClipRRect(
                    borderRadius: BorderRadius.circular(radius),
                    child: imageView(imagePath, model),
                  ),
                );
              } else {
                return _buildIconContainer(
                  imagePath: imagePath,
                  overlay: imageView(imagePath, model),
                );
              }
            });
      } else {
        return ValueListenableBuilder<bool>(
            valueListenable: model.isSelect,
            builder: (context, isSelect, _) {
              if (isSelect) {
                return _buildIconContainer(
                  imagePath: imagePath,
                  radius: radius,
                  hasBorder: true,
                  borderColor: ZegoUIKitBeautyPlugin.instance.core.effectsConfig
                          .uiConfig.selectedIconBorderColor ??
                      Colors.red,
                  overlay: ClipRRect(
                    borderRadius: BorderRadius.circular(radius),
                    child: imageView(imagePath, model),
                  ),
                );
              } else {
                return _buildIconContainer(
                  imagePath: imagePath,
                  overlay: imageView(imagePath, model),
                );
              }
            });
      }
    } else {
      imagePath =
          ZegoUIKitBeautyPlugin.instance.core.beautyTranslation.iconUrlMap[
                  (model as ZegoBeautyItemCleanModel).type.toString()] ??
              '';

      radius = 22.5.zR;

      return _buildIconContainer(imagePath: imagePath);
    }
  }

  /// imageView
  Widget imageView(String imagePath, ZegoBeautyItemBaseModel model) {
    if ((widget.tabModel is ZegoBeautyTabModel)) {
      if ((widget.tabModel as ZegoBeautyTabModel).type ==
          ZegoUIKitBeautyTabType.beautyMakeup) {
        return ValueListenableBuilder<bool>(
          valueListenable:
              ZegoUIKitBeautyPlugin.instance.core.isSelectStyleMakeup,
          builder: (context, isSelect, _) {
            return _buildIconContainer(
              imagePath: imagePath,
              overlay: isSelect
                  ? Container(
                      color: Colors.black.withValues(alpha: 0.6),
                    )
                  : null,
            );
          },
        );
      } else if ((widget.tabModel as ZegoBeautyTabModel).type ==
          ZegoUIKitBeautyTabType.styleMakeup) {
        return _buildIconContainer(imagePath: imagePath);
      } else {
        return _buildIconContainer(imagePath: imagePath);
      }
    } else if (widget.tabModel is ZegoStickerTabModel) {
      return ValueListenableBuilder<bool>(
        valueListenable:
            ZegoUIKitBeautyPlugin.instance.core.isSelectStyleMakeup,
        builder: (context, isSelect, _) {
          return _buildIconContainer(
            imagePath: imagePath,
            overlay: isSelect
                ? Container(
                    color: Colors.black.withValues(alpha: 0.6),
                  )
                : null,
          );
        },
      );
    } else {
      return _buildIconContainer(imagePath: imagePath);
    }
  }

  /// isBasicOrAdvance
  bool isBasicOrAdvance(ZegoBeautyItemModel model) {
    if (ZegoUIKitBeautyTranslation.basicEffectsTypes().contains(model.type) ||
        ZegoUIKitBeautyTranslation.advancedEffectsTypes()
            .contains(model.type)) {
      return true;
    } else {
      return false;
    }
  }

  /// itemClickUpdateState
  void itemClickUpdateState(ZegoBeautyItemBaseModel model) {
    if (model is ZegoBeautyItemModel) {
      if (ZegoUIKitBeautyTranslation.filterNaturalEffectsTypes()
              .contains(model.type) ||
          ZegoUIKitBeautyTranslation.filterGrayEffectsTypes()
              .contains(model.type) ||
          ZegoUIKitBeautyTranslation.filterDreamyEffectsTypes()
              .contains(model.type)) {
        ZegoUIKitBeautyPlugin.instance.core.updateFilterSelectState(model);
      } else if (ZegoUIKitBeautyTranslation.backgroundEffectsTypes()
          .contains(model.type)) {
        ZegoUIKitBeautyPlugin.instance.core.updateBackgroundSelectState(model);
      } else if (isBasicOrAdvance(model)) {
        basicAndAdvanceSelectModel.value = model;
        ZegoUIKitBeautyPlugin.instance.core
            .updateBasicAndAdvancedSelectState(model);
      } else if (ZegoUIKitBeautyTranslation.stypeMakeupEffectsTypes()
          .contains(model.type)) {
        ZegoUIKitBeautyPlugin.instance.core.updateStyleMakeupSelectState(model);
      }
    } else if (model is ZegoBeautyItemCleanModel) {
      ZegoUIKitBeautyPlugin.instance.core.resetEffect(model);
    }
  }
}
