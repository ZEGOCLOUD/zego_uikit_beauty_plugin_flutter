// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:zego_uikit_beauty_plugin/src/components/child_collection_view.dart';
import 'package:zego_uikit_beauty_plugin/src/components/view.dart';
import 'package:zego_uikit_beauty_plugin/src/define.dart';
import 'package:zego_uikit_beauty_plugin/src/models/model.dart';
import 'package:zego_uikit_beauty_plugin/zego_uikit_beauty_plugin.dart';

/// ZegoBeautyUIDisplay
class ZegoBeautyUIDisplay {
  ZegoBeautyMainModel? mainModel;
  ValueNotifier<ZegoTwoLevelBaseTabModel?> twoLevelSelect = ValueNotifier(null);
  ValueNotifier<ZegoBeautyMakeUpModel?> makeupItemSelect = ValueNotifier(null);
  ValueNotifier<ZegoBeautyItemModel?> showSlider = ValueNotifier(null);
  ValueNotifier<ZegoBeautyMakeUpModel?> showMakeupItem = ValueNotifier(null);

  /// showBeautyUI
  void showBeautyUI(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      builder: (BuildContext context) {
        return ValueListenableBuilder<ZegoBeautyMakeUpModel?>(
          valueListenable: showMakeupItem,
          builder: (context, makeupItemModel, _) {
            return SafeArea(
              child: makeupItemModel != null
                  ? showMakeupUI(makeupItemModel)
                  : showEffectUI(),
            );
          },
        );
      },
    );
  }

  /// showEffectUI
  Widget showEffectUI() {
    return effectSheet();
  }

  /// effectSheet
  Widget effectSheet() {
    return SizedBox(
      height: 235 + 15,
      child: AnimatedPadding(
        padding: const EdgeInsets.all(0),
        duration: const Duration(milliseconds: 50),
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
            child: ZegoUIKitBeautyView(
              mainModel: mainModel!,
              showSlider: showSlider,
              twoLevelSelect: twoLevelSelect,
            )),
      ),
    );
  }

  /// showMakeupUI
  Widget showMakeupUI(ZegoBeautyMakeUpModel makeupItemModel) {
    return makeupCollectionView(makeupItemModel);
  }

  /// makeupCollectionView
  Widget makeupCollectionView(ZegoBeautyMakeUpModel makeupItemModel) {
    return ZegoBeautyChildCollectionView(
      model: makeupItemModel,
      showSlider: showSlider,
      childItemClickCallBack: (model) {
        showSlider.value = (model as ZegoBeautyItemModel);
      },
      childBackClickCallBack: () {
        showMakeupItem.value = null;
        showSlider.value = null;
        for (var element
            in ZegoUIKitBeautyPlugin.instance.core.mainModel!.models) {
          if (element.type == ZegoUIKitBeautyMainTabType.beauty) {
            ZegoUIKitBeautyPlugin.instance.core.mainModel!.selectType.value =
                element;
            for (var makeupElement in element.models) {
              if ((makeupElement is ZegoBeautyTabModel) &&
                  makeupElement.type == ZegoUIKitBeautyTabType.beautyMakeup) {
                twoLevelSelect.value = makeupElement;
                break;
              }
            }
          }
        }
      },
    );
  }

  /// clear
  void clear() {
    twoLevelSelect.value = null;
    makeupItemSelect.value = null;
    showSlider.value = null;
    showSlider.value = null;
  }
}
