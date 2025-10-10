// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// Project imports:
import 'package:zego_uikit_beauty_plugin/src/components/screen_util/core/size_extension.dart';

/// @nodoc
class ZegoBeautyRSizedBox extends SizedBox {
  const ZegoBeautyRSizedBox({
    Key? key,
    double? height,
    double? width,
    Widget? child,
  })  : _square = false,
        super(key: key, child: child, width: width, height: height);

  const ZegoBeautyRSizedBox.zVertical(
    double? height, {
    Key? key,
    Widget? child,
  })  : _square = false,
        super(key: key, child: child, height: height);

  const ZegoBeautyRSizedBox.zHorizontal(
    double? width, {
    Key? key,
    Widget? child,
  })  : _square = false,
        super(key: key, child: child, width: width);

  const ZegoBeautyRSizedBox.zSquare({
    Key? key,
    double? height,
    double? dimension,
    Widget? child,
  })  : _square = true,
        super.square(key: key, child: child, dimension: dimension);

  ZegoBeautyRSizedBox.fromSize({
    Key? key,
    Size? size,
    Widget? child,
  })  : _square = false,
        super.fromSize(key: key, child: child, size: size);

  @override
  RenderConstrainedBox createRenderObject(BuildContext context) {
    return RenderConstrainedBox(
      additionalConstraints: _additionalConstraints,
    );
  }

  final bool _square;

  BoxConstraints get _additionalConstraints {
    final boxConstraints =
        BoxConstraints.tightFor(width: width, height: height);
    return _square ? boxConstraints.zR : boxConstraints.zHW;
  }

  @override
  void updateRenderObject(
      BuildContext context, RenderConstrainedBox renderObject) {
    renderObject.additionalConstraints = _additionalConstraints;
  }
}
