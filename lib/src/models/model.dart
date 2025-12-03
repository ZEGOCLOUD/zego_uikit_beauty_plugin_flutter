// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:zego_plugin_adapter/zego_plugin_adapter.dart';

// Project imports:
import 'package:zego_uikit_beauty_plugin/src/define.dart';

/// BeautyMainModel
class ZegoBeautyMainModel {
  final List<ZegoBeautyOneLevelModel> models;
  ValueNotifier<ZegoBeautyOneLevelModel> selectType;

  ZegoBeautyMainModel(this.models, this.selectType);
}

/// BeautyOneLevelModel
class ZegoBeautyOneLevelModel {
  final String title;
  final ZegoUIKitBeautyMainTabType type;
  final List<ZegoTwoLevelBaseTabModel> models;
  ValueNotifier<bool> isSelect;

  ZegoBeautyOneLevelModel(this.title, this.type, this.models, this.isSelect);
}

/// TwoLevelBaseTabModel
class ZegoTwoLevelBaseTabModel {
  final String title;
  final List<ZegoBeautyItemBaseModel> models;
  final ValueNotifier<bool> isSelect;

  ZegoTwoLevelBaseTabModel(this.title, this.models, this.isSelect);
}

/// BeautyTabModel
class ZegoBeautyTabModel extends ZegoTwoLevelBaseTabModel {
  final ZegoUIKitBeautyTabType type;
  final List<ZegoBeautyMakeUpModel> makeupModels;

  ZegoBeautyTabModel(
      String title,
      this.type,
      List<ZegoBeautyItemBaseModel> models,
      this.makeupModels,
      ValueNotifier<bool> isSelect)
      : super(title, models, isSelect);
}

/// FilterTabModel
class ZegoFilterTabModel extends ZegoTwoLevelBaseTabModel {
  final ZegoUIKitFilterTabType type;

  ZegoFilterTabModel(String title, this.type,
      List<ZegoBeautyItemBaseModel> models, ValueNotifier<bool> isSelect)
      : super(title, models, isSelect);
}

/// StickerTabModel
class ZegoStickerTabModel extends ZegoTwoLevelBaseTabModel {
  final ZegoUIKitStickerTabType type;

  ZegoStickerTabModel(String title, this.type,
      List<ZegoBeautyItemBaseModel> models, ValueNotifier<bool> isSelect)
      : super(title, models, isSelect);
}

/// BackgroundTabModel
class ZegoBackgroundTabModel extends ZegoTwoLevelBaseTabModel {
  final ZegoUIKitBackgroundTabType type;

  ZegoBackgroundTabModel(String title, this.type,
      List<ZegoBeautyItemBaseModel> models, ValueNotifier<bool> isSelect)
      : super(title, models, isSelect);
}

/// BeautyMakeUpModel
class ZegoBeautyMakeUpModel extends ZegoTwoLevelBaseTabModel {
  final ZegoUIKitBeautyMakeupType type;

  ZegoBeautyMakeUpModel(String title, this.type,
      List<ZegoBeautyItemBaseModel> models, ValueNotifier<bool> isSelect)
      : super(title, models, isSelect);
}

/// BeautyItemBaseModel
class ZegoBeautyItemBaseModel {
  final String title;

  ZegoBeautyItemBaseModel(this.title);
}

/// BeautyItemCleanModel
class ZegoBeautyItemCleanModel extends ZegoBeautyItemBaseModel {
  final ZegoUIKitBeautyResetType type;
  final ZegoUIKitResetEffectType resetType;

  ZegoBeautyItemCleanModel(super.title, this.type, this.resetType);
}

/// BeautyItemModel
class ZegoBeautyItemModel extends ZegoBeautyItemBaseModel {
  final ZegoBeautyPluginEffectsType type;
  final ValueNotifier<bool> isSelect;
  final ValueNotifier<int> effectValue;
  final int maxValue;
  final int minValue;

  ZegoBeautyItemModel(super.title, this.isSelect, this.type, this.effectValue,
      {this.maxValue = 100, this.minValue = 0});
}
