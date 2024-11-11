// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:zego_uikit_beauty_plugin/src/models/model.dart';
import 'package:zego_uikit_beauty_plugin/zego_uikit_beauty_plugin.dart';
import 'effect_slider.dart';
import 'icon_define.dart';

/// BeautyChildItemClick
typedef BeautyChildItemClick = void Function(ZegoBeautyItemBaseModel model);

/// BeautyChildBackClick
typedef BeautyChildBackClick = void Function();

/// ZegoBeautyChildCollectionView
class ZegoBeautyChildCollectionView extends StatefulWidget {
  const ZegoBeautyChildCollectionView(
      {required this.model,
      required this.showSlider,
      this.childItemClickCallBack,
      this.childBackClickCallBack,
      Key? key})
      : super(key: key);

  final ZegoBeautyMakeUpModel model;
  final BeautyChildItemClick? childItemClickCallBack;
  final BeautyChildBackClick? childBackClickCallBack;
  final ValueNotifier<ZegoBeautyItemModel?> showSlider;

  @override
  State<ZegoBeautyChildCollectionView> createState() =>
      _ZegoBeautyChildCollectionViewState();
}

class _ZegoBeautyChildCollectionViewState
    extends State<ZegoBeautyChildCollectionView> {
  @override
  void dispose() {
    super.dispose();
    ZegoUIKitBeautyPlugin.instance.core.uiDisplay.showMakeupItem.value = null;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ZegoBeautyItemModel?>(
        valueListenable: widget.showSlider,
        builder: (context, sliderModel, _) {
          return Container(
            color: Colors.transparent,
            height: 43 + 80 + 0.5 + 50 + 20,
            child: Column(
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
                  color: ZegoUIKitBeautyPlugin
                      .instance.core.effectsConfig.uiConfig.backgroundColor,
                  child: Column(
                    children: [
                      titleView(),
                      Container(
                        height: 0.5,
                        color: ZegoUIKitBeautyPlugin.instance.core.effectsConfig
                            .uiConfig.backgroundColor,
                      ),
                      itemListView(),
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

  /// titleView
  Widget titleView() {
    return Container(
      height: 43,
      color: ZegoUIKitBeautyPlugin
          .instance.core.effectsConfig.uiConfig.backgroundColor,
      child: Row(
        children: [
          const SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: () {
              if (widget.childBackClickCallBack != null) {
                widget.childBackClickCallBack!();
              }
            },
            child: SizedBox(
              height: 40,
              child: ZegoUIKitBeautyPlugin
                      .instance.core.effectsConfig.uiConfig.backIcon ??
                  BeautyImage.asset(StyleIconUrls.iconBackUrl),
            ),
          ),
          const SizedBox(
            width: 1,
            height: 33,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            widget.model.title,
            style: const TextStyle(color: Color(0xffC4C4C4)),
          ),
        ],
      ),
    );
  }

  /// itemListView
  Widget itemListView() {
    return Container(
      height: 80,
      color: ZegoUIKitBeautyPlugin
          .instance.core.effectsConfig.uiConfig.backgroundColor,
      child: ListView.builder(
          itemCount: widget.model.models.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: ((context, index) {
            return itemView(widget.model.models[index]);
          })),
    );
  }

  /// itemView
  Widget itemView(ZegoBeautyItemBaseModel model) {
    return GestureDetector(
      onTap: () {
        if (model is ZegoBeautyItemModel && !model.isSelect.value) {
          ZegoUIKitBeautyPlugin.instance.core
              .updateMakeUpItemSelectState(model, widget.model);
          widget.model.isSelect.value = true;
          if (widget.childItemClickCallBack != null) {
            widget.childItemClickCallBack!(model);
          }
        } else if (model is ZegoBeautyItemCleanModel) {
          ZegoUIKitBeautyPlugin.instance.core.resetEffect(model);
          widget.model.isSelect.value = false;
          widget.showSlider.value = null;
        }
      },
      child: SizedBox(
        width: 75,
        height: 80,
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 15,
                ),
                Column(
                  children: [
                    itemImageView(model),
                    SizedBox(
                      height: 20,
                      width: 60,
                      child: Text(
                        model.title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: ZegoUIKitBeautyPlugin.instance.core.effectsConfig
                            .uiConfig.normalTextStyle,
                        textAlign: TextAlign.center,
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
    if (model is ZegoBeautyItemModel) {
      return ValueListenableBuilder<bool>(
          valueListenable: model.isSelect,
          builder: (context, isSelect, _) {
            var imagePath = ZegoUIKitBeautyPlugin.instance.core
                    .beautyTranslation.iconUrlMap[model.type.toString()] ??
                '';
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
                  borderRadius: BorderRadius.circular(22.5),
                ),
                child: ClipRRect(
                  child: SizedBox(
                    width: 44,
                    height: 44,
                    child: BeautyImage.asset(imagePath),
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
                  child: BeautyImage.asset(imagePath),
                ),
              );
            }
          });
    } else if (model is ZegoBeautyItemCleanModel) {
      var imagePath = ZegoUIKitBeautyPlugin.instance.core.beautyTranslation
              .iconUrlMap[model.type.toString()] ??
          '';
      return SizedBox(
        width: 45,
        height: 45,
        child: SizedBox(
          width: 44,
          height: 44,
          child: BeautyImage.asset(imagePath),
        ),
      );
    } else {
      return Container();
    }
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
