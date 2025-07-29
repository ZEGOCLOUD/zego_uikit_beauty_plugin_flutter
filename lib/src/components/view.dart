// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:zego_plugin_adapter/zego_plugin_adapter.dart';

// Project imports:
import 'package:zego_uikit_beauty_plugin/src/components/collection_view.dart';
import 'package:zego_uikit_beauty_plugin/src/components/effect_slider.dart';
import 'package:zego_uikit_beauty_plugin/src/components/main_tab.dart';
import 'package:zego_uikit_beauty_plugin/src/components/makeup_view.dart';
import 'package:zego_uikit_beauty_plugin/src/components/second_level_tab.dart';
import 'package:zego_uikit_beauty_plugin/src/define.dart';
import 'package:zego_uikit_beauty_plugin/src/models/model.dart';
import 'package:zego_uikit_beauty_plugin/zego_uikit_beauty_plugin.dart';

/// ZegoUIKitBeautyView
class ZegoUIKitBeautyView extends StatefulWidget {
  const ZegoUIKitBeautyView({
    required this.mainModel,
    required this.showSlider,
    required this.twoLevelSelect,
    Key? key,
  }) : super(key: key);
  final ZegoBeautyMainModel mainModel;
  final ValueNotifier<ZegoTwoLevelBaseTabModel?> twoLevelSelect;
  final ValueNotifier<ZegoBeautyItemModel?> showSlider;

  @override
  State<ZegoUIKitBeautyView> createState() => _ZegoUIKitBeautyViewState();
}

class _ZegoUIKitBeautyViewState extends State<ZegoUIKitBeautyView> {
  ValueNotifier<ZegoBeautyMakeUpModel?> makeupItemSelect = ValueNotifier(null);
  ValueNotifier<ZegoBeautyItemBaseModel?> itemSelect = ValueNotifier(null);

  @override
  void initState() {
    super.initState();
    widget.twoLevelSelect.value ??= widget.mainModel.models.first.models.first;
    if (widget.mainModel.selectType.value.type ==
            ZegoUIKitBeautyMainTabType.beauty ||
        widget.mainModel.selectType.value.type ==
            ZegoUIKitBeautyMainTabType.sticker) {
      widget.showSlider.value = null;
    }
  }

  @override
  void dispose() {
    super.dispose();
    widget.mainModel.selectType.value = widget.mainModel.models.first;
    widget.twoLevelSelect.value = widget.mainModel.models.first.models.first;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ZegoBeautyItemModel?>(
        valueListenable: widget.showSlider,
        builder: (context, sliderModel, _) {
          return Container(
            color: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (sliderModel != null) slider(sliderModel, 30),
                if (sliderModel != null)
                  const SizedBox(
                    height: 20,
                  ),
                if (sliderModel == null)
                  const SizedBox(
                    height: 50,
                  ),
                Container(
                  color: const Color.fromARGB(230, 9, 17, 28),
                  child: Column(
                    children: [
                      createOneLevelTab(),
                      createTwoLevelTab(),
                      createItemView(),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  /// createOneLevelTab
  Widget createOneLevelTab() {
    return ValueListenableBuilder<ZegoBeautyOneLevelModel>(
        valueListenable: widget.mainModel.selectType,
        builder: (context, selectType, _) {
          return ZegoUIKitBeautyMainTab(
            mainTabList: widget.mainModel.models,
            defaultSelectNoti: widget.mainModel.selectType,
            tabClickCallBack: (model) {
              widget.mainModel.selectType.value = model;
              widget.twoLevelSelect.value = model.models.first;
              ZegoUIKitBeautyPlugin.instance.core
                  .updateSliderModel(model.models.first, widget.showSlider);
            },
          );
        });
  }

  /// createTwoLevelTab
  Widget createTwoLevelTab() {
    return ValueListenableBuilder<ZegoBeautyOneLevelModel>(
        valueListenable: widget.mainModel.selectType,
        builder: (context, selectModel, _) {
          return ZegoUIKitBeautySecondLevelTab(
            tabList: selectModel.models,
            defaultSelectNoti: widget.twoLevelSelect,
            tabButtonClick: (model) {
              widget.twoLevelSelect.value = model;
              ZegoUIKitBeautyPlugin.instance.core
                  .updateSliderModel(model, widget.showSlider);
            },
          );
        });
  }

  /// createItemView
  Widget createItemView() {
    return ValueListenableBuilder<ZegoTwoLevelBaseTabModel?>(
        valueListenable: widget.twoLevelSelect,
        builder: (context, selectModel, _) {
          if (selectModel is ZegoBeautyTabModel &&
              selectModel.type == ZegoUIKitBeautyTabType.beautyMakeup) {
            ZegoUIKitBeautyMakeupView view = ZegoUIKitBeautyMakeupView(
              tabModel: selectModel,
              makeClickCallBack: (model) {
                ZegoUIKitBeautyPlugin
                    .instance.core.uiDisplay.showMakeupItem.value = model;
                ZegoUIKitBeautyPlugin.instance.core
                    .updateMakeupSliderModel(model, widget.showSlider);
              },
              makeupCleanClickCallBack: (model) {
                // ZegoUIKitBeautyPlugin.instance.core.uiDiaplay.showMakeupItem.value = model;
              },
            );
            return view;
          } else {
            ZegoUIKitBeautyCollectionView view = ZegoUIKitBeautyCollectionView(
              selectItemModelNotifier: ValueNotifier(null),
              tabModel: selectModel ?? widget.mainModel.models[0].models[0],
              itemClickCallBack: (model) {
                itemSelect.value = model;
                if (selectModel is ZegoStickerTabModel) {
                  widget.showSlider.value = null;
                } else {
                  if (model is ZegoBeautyItemModel &&
                      model.type ==
                          ZegoBeautyPluginEffectsType
                              .backgroundPortraitSegmentation) {
                    widget.showSlider.value = null;
                  } else {
                    widget.showSlider.value = (model as ZegoBeautyItemModel);
                  }
                }
              },
              itemResetCallBack: (model) {
                widget.showSlider.value = null;
              },
            );
            return view;
          }
        });
  }

  /// slider
  Widget slider(ZegoBeautyItemModel model, double height) {
    return ZegoBeautyEffectSlider(
      itemModel: model,
      thumpHeight: height,
      defaultValue: model.effectValue.value,
      maxValue: model.maxValue,
      minValue: model.minValue,
    );
  }
}
