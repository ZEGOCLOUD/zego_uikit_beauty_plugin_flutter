// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:zego_uikit_beauty_plugin/src/components/screen_util/screen_util.dart';
import 'package:zego_uikit_beauty_plugin/src/models/model.dart';
import 'package:zego_uikit_beauty_plugin/zego_uikit_beauty_plugin.dart';

/// TwoLevelTabButtonClick
typedef TwoLevelTabButtonClick = void Function(ZegoTwoLevelBaseTabModel model);

/// ZegoUIKitBeautySecondLevelTab
class ZegoUIKitBeautySecondLevelTab extends StatefulWidget {
  const ZegoUIKitBeautySecondLevelTab({
    super.key,
    required this.tabList,
    required this.defaultSelectNoti,
    this.tabButtonClick,
  });

  final List<ZegoTwoLevelBaseTabModel> tabList;
  final TwoLevelTabButtonClick? tabButtonClick;
  final ValueNotifier<ZegoTwoLevelBaseTabModel?> defaultSelectNoti;

  @override
  State<ZegoUIKitBeautySecondLevelTab> createState() =>
      _ZegoUIKitBeautySecondLevelTabState();
}

class _ZegoUIKitBeautySecondLevelTabState
    extends State<ZegoUIKitBeautySecondLevelTab> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ZegoUIKitBeautyPlugin
          .instance.core.effectsConfig.uiConfig.backgroundColor,
      height: 47.5.zH,
      child: Column(
        children: [
          tabSizeBox(),
          Container(height: 0.5.zH, color: const Color(0xffC4C4C4)),
        ],
      ),
    );
  }

  /// tabSizeBox
  Widget tabSizeBox() {
    return ValueListenableBuilder<ZegoTwoLevelBaseTabModel?>(
      valueListenable: widget.defaultSelectNoti,
      builder: (context, selectModel, _) {
        return SizedBox(
          height: 47.zH,
          child: Row(
            children: tabButtons(),
          ),
        );
      },
    );
  }

  /// tabButtons
  List<Widget> tabButtons() {
    var buttonSize = Size(
      MediaQuery.of(context).size.width / widget.tabList.length,
      47.zH,
    );
    List<Widget> tabList = [];
    for (var model in widget.tabList) {
      tabList.add(
        TabButton(
          model: model,
          buttonSize: buttonSize,
          isSelect: (widget.defaultSelectNoti.value == model)
              ? ValueNotifier(true)
              : ValueNotifier(false),
          tabButtonClick: (ZegoTwoLevelBaseTabModel model) {
            widget.defaultSelectNoti.value = model;
            if (widget.tabButtonClick != null) {
              widget.tabButtonClick!(model);
            }
          },
        ),
      );
    }
    return tabList;
  }
}

/// TabButton
class TabButton extends StatefulWidget {
  const TabButton({
    super.key,
    required this.model,
    required this.buttonSize,
    required this.isSelect,
    this.tabButtonClick,
  });

  final ZegoTwoLevelBaseTabModel model;
  final TwoLevelTabButtonClick? tabButtonClick;
  final Size buttonSize;
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
        if (widget.tabButtonClick != null) {
          widget.tabButtonClick!(widget.model);
        }
      },
      child: SizedBox(
        width: widget.buttonSize.width,
        height: widget.buttonSize.height,
        child: Row(
          children: [
            SizedBox(width: 15.zW),
            SizedBox(
              width: (widget.buttonSize.width - 15.zW > 100.zW)
                  ? 100.zW
                  : widget.buttonSize.width - 15.zW,
              child: Column(
                children: [
                  SizedBox(height: 15.zH),
                  SizedBox(
                    height: 16.zH,
                    child: Center(
                      child: Text(
                        widget.model.title,
                        style: (widget.isSelect.value
                            ? ZegoUIKitBeautyPlugin.instance.core.effectsConfig
                                .uiConfig.selectHeaderTitleTextStyle
                            : ZegoUIKitBeautyPlugin.instance.core.effectsConfig
                                .uiConfig.normalHeaderTitleTextStyle),
                      ),
                    ),
                  ),
                  SizedBox(height: 15.zH),
                  if (widget.isSelect.value) selectLine(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// selectLine
  Widget selectLine() {
    return Center(
      child: Container(width: 14.zW, height: 1.zH, color: Colors.white),
    );
  }

  /// tapClick
  void tapClick() {
    // if (widget.model is ZegoTwoLevelBaseTabModel) {}
  }
}
