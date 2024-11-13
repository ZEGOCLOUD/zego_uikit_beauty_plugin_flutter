// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:zego_uikit_beauty_plugin/src/components/icon_define.dart';
import 'package:zego_uikit_beauty_plugin/src/define.dart';
import 'package:zego_uikit_beauty_plugin/src/models/model.dart';
import 'package:zego_uikit_beauty_plugin/zego_uikit_beauty_plugin.dart';

/// MakeupItemClick
typedef MakeupItemClick = void Function(ZegoBeautyMakeUpModel model);

/// MakeupCleanClick
typedef MakeupCleanClick = void Function(ZegoBeautyItemCleanModel model);

/// ZegoUIKitBeautyMakeupView
class ZegoUIKitBeautyMakeupView extends StatefulWidget {
  const ZegoUIKitBeautyMakeupView({
    this.tabModel,
    this.makeClickCallBack,
    this.makeupCleanClickCallBack,
    Key? key,
  }) : super(key: key);

  final ZegoBeautyTabModel? tabModel;
  final MakeupItemClick? makeClickCallBack;
  final MakeupCleanClick? makeupCleanClickCallBack;

  @override
  State<ZegoUIKitBeautyMakeupView> createState() =>
      _ZegoUIKitBeautyMakeupView();
}

class _ZegoUIKitBeautyMakeupView extends State<ZegoUIKitBeautyMakeupView> {
  List<dynamic> showList = [];

  @override
  void initState() {
    super.initState();
    showList.add(ZegoBeautyItemCleanModel(
        ZegoUIKitBeautyPlugin.instance.core.beautyTranslation
                .beautyMap[ZegoUIKitBeautyResetType.originalDraw.toString()] ??
            '',
        ZegoUIKitBeautyResetType.originalDraw,
        ZegoUIKitResetEffectType.beautyMakeup));
    showList.addAll(widget.tabModel?.makeupModels ?? []);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 84,
      color: ZegoUIKitBeautyPlugin
          .instance.core.effectsConfig.uiConfig.backgroundColor,
      child: ListView.builder(
          itemCount: showList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return itemView(showList[index]);
          }),
    );
  }

  /// itemView
  Widget itemView(dynamic model) {
    return GestureDetector(
      onTap: () {
        if (ZegoUIKitBeautyPlugin.instance.core.isSelectStyleMakeup.value) {
          return;
        }
        if (widget.makeClickCallBack != null &&
            (model is ZegoBeautyMakeUpModel)) {
          widget.makeClickCallBack!(model);
        } else if (model is ZegoBeautyItemCleanModel) {
          ZegoUIKitBeautyPlugin.instance.core.resetEffect(model);
          if (widget.makeupCleanClickCallBack != null) {
            widget.makeupCleanClickCallBack!(model);
          }
        }
      },
      child: SizedBox(
        width: 90,
        height: 84,
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
                itemColumView(model),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// itemColumView
  Widget itemColumView(dynamic model) {
    if (model is ZegoBeautyMakeUpModel) {
      return ValueListenableBuilder<bool>(
          valueListenable: model.isSelect,
          builder: (context, isSelect, _) {
            return Column(
              children: [
                itemImageView(model),
                SizedBox(
                  height: 20,
                  width: 75,
                  child: Text(
                    model.title,
                    style: ZegoUIKitBeautyPlugin
                        .instance.core.effectsConfig.uiConfig.normalTextStyle,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                  ),
                ),
                if (isSelect) redDot(),
              ],
            );
          });
    } else if (model is ZegoBeautyItemCleanModel) {
      return Column(
        children: [
          itemImageView(model),
          SizedBox(
            height: 20,
            width: 75,
            child: Text(
              model.title,
              style: ZegoUIKitBeautyPlugin
                  .instance.core.effectsConfig.uiConfig.normalTextStyle,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
          ),
        ],
      );
    } else {
      return Container();
    }
  }

  /// itemImageView
  Widget itemImageView(dynamic model) {
    if (model is ZegoBeautyMakeUpModel) {
      String imagePath = ZegoUIKitBeautyPlugin.instance.core.beautyTranslation
              .iconUrlMap[model.type.toString()] ??
          '';
      return imageView(imagePath, model);
    } else if (model is ZegoBeautyItemCleanModel) {
      String imagePath = ZegoUIKitBeautyPlugin.instance.core.beautyTranslation
              .iconUrlMap[model.type.toString()] ??
          '';
      return imageView(imagePath, model);
    } else {
      return Container();
    }
  }

  /// imageView
  Widget imageView(String imagePath, dynamic model) {
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
        });
  }

  /// redDot
  Widget redDot() {
    return Container(
      width: 4,
      height: 4,
      decoration: BoxDecoration(
          color: ZegoUIKitBeautyPlugin
              .instance.core.effectsConfig.uiConfig.selectedIconDotColor,
          borderRadius: BorderRadius.circular(2)),
    );
  }
}
