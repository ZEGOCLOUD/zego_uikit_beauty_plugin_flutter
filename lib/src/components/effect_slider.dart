// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:zego_uikit_beauty_plugin/src/models/model.dart';
import 'package:zego_uikit_beauty_plugin/zego_uikit_beauty_plugin.dart';

/// ZegoBeautyEffectSlider
class ZegoBeautyEffectSlider extends StatefulWidget {
  final ZegoBeautyItemModel itemModel;
  final int defaultValue;
  final int maxValue;
  final int minValue;

  final double? thumpHeight;
  final double? trackHeight;
  final String Function(int)? labelFormatFunc;

  const ZegoBeautyEffectSlider({
    Key? key,
    required this.itemModel,
    required this.defaultValue,
    required this.maxValue,
    required this.minValue,
    this.thumpHeight,
    this.trackHeight,
    this.labelFormatFunc,
  }) : super(key: key);

  @override
  State<ZegoBeautyEffectSlider> createState() => _ZegoBeautyEffectSliderState();
}

class _ZegoBeautyEffectSliderState extends State<ZegoBeautyEffectSlider> {
  var valueNotifier = ValueNotifier<int>(50);

  @override
  void initState() {
    super.initState();

    valueNotifier.value = widget.defaultValue;
  }

  @override
  Widget build(BuildContext context) {
    valueNotifier.value = widget.defaultValue;

    final thumpHeight = widget.thumpHeight ?? 32;
    return SizedBox(
      width: 300,
      height: thumpHeight,
      child: SliderTheme(
        data: SliderTheme.of(context).copyWith(
          valueIndicatorTextStyle: ZegoUIKitBeautyPlugin
              .instance.core.effectsConfig.uiConfig.sliderTextStyle,
          valueIndicatorColor: ZegoUIKitBeautyPlugin
              .instance.core.effectsConfig.uiConfig.sliderTextBackgroundColor,
          showValueIndicator: ShowValueIndicator.always,
          activeTrackColor: ZegoUIKitBeautyPlugin
              .instance.core.effectsConfig.uiConfig.sliderActiveTrackColor,
          inactiveTrackColor: ZegoUIKitBeautyPlugin
              .instance.core.effectsConfig.uiConfig.sliderInactiveTrackColor,
          trackHeight: widget.trackHeight ?? 6.0,
          thumbColor: ZegoUIKitBeautyPlugin
              .instance.core.effectsConfig.uiConfig.sliderThumbColor,
          thumbShape: RoundSliderThumbShape(
              enabledThumbRadius: ZegoUIKitBeautyPlugin
                      .instance.core.effectsConfig.uiConfig.sliderThumbRadius ??
                  thumpHeight / 2.0),
        ),
        child: ValueListenableBuilder<int>(
          valueListenable: valueNotifier,
          builder: (context, value, _) {
            return Slider(
              value: value.toDouble(),
              min: widget.minValue.toDouble(),
              max: widget.maxValue.toDouble(),
              divisions: 100,
              autofocus: true,
              label: widget.labelFormatFunc == null
                  ? value.toDouble().round().toString()
                  : widget.labelFormatFunc?.call(value),
              onChanged: (double defaultValue) {
                valueNotifier.value = defaultValue.toInt();
                widget.itemModel.effectValue.value = defaultValue.toInt();
                ZegoUIKitBeautyPlugin.instance.core.setEffectValue(
                    widget.itemModel.type, defaultValue.toInt());
              },
            );
          },
        ),
      ),
    );
  }
}
