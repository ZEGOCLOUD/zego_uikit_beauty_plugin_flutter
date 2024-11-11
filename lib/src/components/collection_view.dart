// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:zego_uikit_beauty_plugin/src/components/icon_define.dart';
import 'package:zego_uikit_beauty_plugin/src/define.dart';
import 'package:zego_uikit_beauty_plugin/src/models/model.dart';
import 'package:zego_uikit_beauty_plugin/zego_uikit_beauty_plugin.dart';

/// BeautyItemClick
typedef BeautyItemClick = void Function(ZegoBeautyItemBaseModel model);

/// BeautyItemResetClick
typedef BeautyItemResetClick = void Function(ZegoBeautyItemCleanModel model);

/// ZegoUIKitBeautyCollectionView
class ZegoUIKitBeautyCollectionView extends StatefulWidget {
  const ZegoUIKitBeautyCollectionView(
      {required this.selectItemModelNotifier,
      this.tabModel,
      this.itemClickCallBack,
      this.itemResetCallBack,
      Key? key})
      : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
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
        if (ZegoUIKitBeautyPlugin.instance.core.isSelectSticker.value &&
            ((widget.tabModel is ZegoBeautyTabModel) &&
                (widget.tabModel as ZegoBeautyTabModel).type ==
                    ZegoUIKitBeautyTabType.styleMakeup)) {
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
        width: 90,
        height: 80,
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 15,
                ),
                Column(
                  children: [
                    itemImageView(model),
                    SizedBox(
                      height: 20,
                      width: 75,
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
              ZegoUIKitBeautyTranslation.stickersEffectsTypes()
                  .contains(model.type) ||
              ZegoUIKitBeautyTranslation.backgroundEffectsTypes()
                  .contains(model.type)
          ? 6
          : 22.5;

      if (isBasicOrAdvance(model)) {
        return ValueListenableBuilder<ZegoBeautyItemModel?>(
            valueListenable: basicAndAdvanceSelectModel,
            builder: (context, basicAndAdvanceModel, _) {
              if (basicAndAdvanceModel == model) {
                return Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: ZegoUIKitBeautyPlugin.instance.core.effectsConfig
                                .uiConfig.selectedIconBorderColor ??
                            Colors.red,
                        width: 1),
                    borderRadius: BorderRadius.circular(radius),
                  ),
                  child: ClipRRect(
                    child: SizedBox(
                      width: 44,
                      height: 44,
                      child: imageView(imagePath, model),
                    ),
                  ),
                );
              } else {
                return SizedBox(
                  width: 45,
                  height: 45,
                  child: SizedBox(
                    width: 44,
                    height: 44,
                    child: imageView(imagePath, model),
                  ),
                );
              }
            });
      } else {
        return ValueListenableBuilder<bool>(
            valueListenable: model.isSelect,
            builder: (context, isSelect, _) {
              if (isSelect) {
                return Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: ZegoUIKitBeautyPlugin.instance.core.effectsConfig
                                .uiConfig.selectedIconBorderColor ??
                            Colors.red,
                        width: 1),
                    borderRadius: BorderRadius.circular(radius),
                  ),
                  child: ClipRRect(
                    child: SizedBox(
                      width: 44,
                      height: 44,
                      child: imageView(imagePath, model),
                    ),
                  ),
                );
              } else {
                return SizedBox(
                  width: 45,
                  height: 45,
                  child: SizedBox(
                    width: 44,
                    height: 44,
                    child: imageView(imagePath, model),
                  ),
                );
              }
            });
      }
    } else {
      imagePath =
          ZegoUIKitBeautyPlugin.instance.core.beautyTranslation.iconUrlMap[
                  (model as ZegoBeautyItemCleanModel).type.toString()] ??
              '';

      radius = 22.5;

      return SizedBox(
        width: 45,
        height: 45,
        child: SizedBox(
          width: 44,
          height: 44,
          child: BeautyImage.asset(imagePath),
        ),
      );
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
            return SizedBox(
              width: 45,
              height: 45,
              child: SizedBox(
                width: 44,
                height: 44,
                child: Stack(
                  children: [
                    BeautyImage.asset(imagePath),
                    if (isSelect)
                      Container(
                        color: Colors.black.withOpacity(0.6),
                      ),
                  ],
                ),
              ),
            );
          },
        );
      } else if ((widget.tabModel as ZegoBeautyTabModel).type ==
          ZegoUIKitBeautyTabType.styleMakeup) {
        return ValueListenableBuilder<bool>(
            valueListenable:
                ZegoUIKitBeautyPlugin.instance.core.isSelectSticker,
            builder: (context, isSelect, _) {
              return SizedBox(
                width: 45,
                height: 45,
                child: SizedBox(
                  width: 44,
                  height: 44,
                  child: Stack(
                    children: [
                      BeautyImage.asset(imagePath),
                      if (isSelect)
                        Container(
                          color: Colors.black.withOpacity(0.6),
                        ),
                    ],
                  ),
                ),
              );
            });
      } else {
        return SizedBox(
          width: 45,
          height: 45,
          child: SizedBox(
            width: 44,
            height: 44,
            child: BeautyImage.asset(imagePath),
          ),
        );
      }
    } else if (widget.tabModel is ZegoStickerTabModel) {
      return ValueListenableBuilder<bool>(
        valueListenable:
            ZegoUIKitBeautyPlugin.instance.core.isSelectStyleMakeup,
        builder: (context, isSelect, _) {
          return SizedBox(
            width: 45,
            height: 45,
            child: SizedBox(
              width: 44,
              height: 44,
              child: Stack(
                children: [
                  BeautyImage.asset(imagePath),
                  if (isSelect)
                    Container(
                      color: Colors.black.withOpacity(0.6),
                    ),
                ],
              ),
            ),
          );
        },
      );
    } else {
      return SizedBox(
        width: 45,
        height: 45,
        child: SizedBox(
          width: 44,
          height: 44,
          child: BeautyImage.asset(imagePath),
        ),
      );
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
      } else if (ZegoUIKitBeautyTranslation.stickersEffectsTypes()
          .contains(model.type)) {
        ZegoUIKitBeautyPlugin.instance.core.updateStickerSelectState(model);
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
