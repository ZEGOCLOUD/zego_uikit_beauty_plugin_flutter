// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:zego_uikit_beauty_plugin/src/models/model.dart';
import 'package:zego_uikit_beauty_plugin/zego_uikit_beauty_plugin.dart';

/// MainTabButtonClick
typedef MainTabButtonClick = void Function(ZegoBeautyOneLevelModel model);

/// ZegoUIKitBeautyMainTab
class ZegoUIKitBeautyMainTab extends StatefulWidget {
  const ZegoUIKitBeautyMainTab(
      {Key? key,
      required this.mainTabList,
      required this.defaultSelectNoti,
      this.tabClickCallBack})
      : super(key: key);

  final List<ZegoBeautyOneLevelModel> mainTabList;
  final ValueNotifier<ZegoBeautyOneLevelModel> defaultSelectNoti;
  final MainTabButtonClick? tabClickCallBack;

  @override
  State<ZegoUIKitBeautyMainTab> createState() => _ZegoUIKitBeautyMainTabState();
}

class _ZegoUIKitBeautyMainTabState extends State<ZegoUIKitBeautyMainTab> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ZegoUIKitBeautyPlugin
          .instance.core.effectsConfig.uiConfig.backgroundColor,
      height: 47.5,
      child: Column(
        children: [
          tabSizeBox(),
          Container(
            height: 0.5,
            color: const Color(0xffC4C4C4),
          ),
        ],
      ),
    );
  }

  /// tabSizeBox
  Widget tabSizeBox() {
    return ValueListenableBuilder<ZegoBeautyOneLevelModel>(
        valueListenable: widget.defaultSelectNoti,
        builder: (context, selectModel, _) {
          return SizedBox(
            height: 47,
            child: Row(
              children: tabButtons(),
            ),
          );
        });
  }

  /// tabButtons
  List<Widget> tabButtons() {
    var buttonSize =
        Size(MediaQuery.of(context).size.width / widget.mainTabList.length, 47);
    List<Widget> tabList = [];
    for (var model in widget.mainTabList) {
      tabList.add(TabButton(
        model: model,
        buttonSize: buttonSize,
        isSelect: (widget.defaultSelectNoti.value.type == model.type)
            ? ValueNotifier(true)
            : ValueNotifier(false),
        tabClickCallBack: (ZegoBeautyOneLevelModel model) {
          widget.defaultSelectNoti.value = model;
          if (widget.tabClickCallBack != null) {
            widget.tabClickCallBack!(model);
          }
        },
      ));
    }
    return tabList;
  }
}

/// TabButton
class TabButton extends StatefulWidget {
  const TabButton(
      {Key? key,
      required this.model,
      required this.buttonSize,
      required this.isSelect,
      this.tabClickCallBack})
      : super(key: key);

  final ZegoBeautyOneLevelModel model;
  final Size buttonSize;
  final MainTabButtonClick? tabClickCallBack;
  final ValueNotifier<bool> isSelect;

  @override
  State<TabButton> createState() => _TabButtonState();
}

class _TabButtonState extends State<TabButton> {
  @override
  Widget build(Object context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        if (widget.tabClickCallBack != null) {
          widget.isSelect.value = true;
          widget.tabClickCallBack!(widget.model);
        }
      },
      child: tabContainer(),
    );
  }

  /// tabContainer
  Widget tabContainer() {
    return ValueListenableBuilder<bool>(
        valueListenable: widget.isSelect,
        builder: (context, isSelect, _) {
          return SizedBox(
            width: widget.buttonSize.width,
            height: widget.buttonSize.height,
            child: Column(
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 15,
                    ),
                    SizedBox(
                      width: (widget.buttonSize.width - 15 > 100)
                          ? 100
                          : widget.buttonSize.width - 15,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            height: 16,
                            child: Center(
                              child: Text(
                                widget.model.title,
                                style: (isSelect
                                    ? ZegoUIKitBeautyPlugin
                                        .instance
                                        .core
                                        .effectsConfig
                                        .uiConfig
                                        .selectHeaderTitleTextStyle
                                    : ZegoUIKitBeautyPlugin
                                        .instance
                                        .core
                                        .effectsConfig
                                        .uiConfig
                                        .normalHeaderTitleTextStyle),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          if (isSelect) selectLine(),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }

  /// selectLine
  Widget selectLine() {
    return Center(
      child: Container(
        width: 14,
        height: 1,
        color: Colors.white,
      ),
    );
  }
}
