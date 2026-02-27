# CLAUDE.md

> **Note**: This library is part of the `zego_uikits` monorepo. See the root [CLAUDE.md](https://github.com/your-org/zego_uikits/blob/main/CLAUDE.md) for cross-library dependencies and architecture overview.

This file provides guidance to Claude Code when working with code in this repository.

## Project Overview

**ZegoUIKitBeautyPlugin** is a Flutter plugin that provides beauty effects (美颜) for ZegoUIKit. It offers:
- Basic beauty filters (磨皮、美白、锐化等)
- Advanced beauty effects
- Makeup effects (妆容)
- Stickers (贴纸)

## Architecture

### Main Class

`ZegoUIKitBeautyPlugin` - Singleton plugin class

```dart
ZegoUIKitBeautyPlugin()  // 获取实例
```

### Key Methods

| Method | Description |
|--------|-------------|
| `init(appID, appSign)` | Initialize the beauty plugin |
| `showBeautyUI(context)` | Show the beauty UI panel |
| `uninit()` | Uninitialize the plugin |
| `setConfig(config)` | Set beauty configuration |
| `setBeautyParams(params)` | Set beauty parameters programmatically |

### Usage with Prebuilt Components

Add as plugin to prebuilt components:

```dart
// With Call
ZegoUIKitPrebuiltCall(
  plugins: [ZegoUIKitBeautyPlugin()],
  config: ZegoCallMenuBarConfig(
    buttons: [ZegoCallMenuBarButtonName.beautyEffectButton],
  ),
)

// With Live Streaming
ZegoLiveStreamingPage(
  plugins: [ZegoUIKitBeautyPlugin()],
)
```

## Video Coding Quick Templates

### Basic Usage with Call

```dart
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_beauty_plugin/zego_uikit_beauty_plugin.dart';

ZegoUIKitPrebuiltCall(
  appID: YOUR_APP_ID,
  appSign: YOUR_APP_SIGN,
  userID: 'user_001',
  userName: 'Alice',
  callID: 'call_001',
  plugins: [ZegoUIKitBeautyPlugin()],
  config: ZegoUIKitPrebuiltCallConfig(
    bottomMenuBar: ZegoCallMenuBarConfig(
      buttons: [
        ZegoCallMenuBarButtonName.beautyEffectButton,  // 美颜按钮
      ],
    ),
  ),
)
```

### Programmatic Beauty Control

```dart
// Set beauty parameters without UI
ZegoUIKitBeautyPlugin().setBeautyParams([
  ZegoBeautyParamConfig(
    type: ZegoBeautyType.smooth,
    intensity: 0.5,  // 0.0 - 1.0
  ),
  ZegoBeautyParamConfig(
    type: ZegoBeautyType.whitening,
    intensity: 0.3,
  ),
]);
```

## Common Tasks

### 1. Add Beauty to Call

- Import both packages
- Add `ZegoUIKitBeautyPlugin()` to plugins list
- Add `beautyEffectButton` to menu bar buttons

### 2. Add Beauty to Live Streaming

- Same as Call, use `ZegoLiveStreamingPage` instead

### 3. Customize Beauty UI

```dart
ZegoUIKitBeautyPlugin().setConfig(
  ZegoBeautyPluginConfig(
    uiConfig: ZegoBeautyPluginUIConfig(
      backgroundColor: Colors.black,
      selectedIconBorderColor: Colors.red,
    ),
  ),
);
```

## Dependencies

This plugin requires:
- `zego_uikit` - Core UIKit
- `zego_plugin_adapter` - Plugin adapter

## File Structure

```
lib/
├── zego_uikit_beauty_plugin.dart    # Main entry
└── src/
    ├── components/                   # UI components
    ├── internal/                     # Core implementation
    ├── config.dart                   # Configuration
    ├── define.dart                   # Definitions
    └── method_channel.dart           # Platform channel
```

## Notes

- Beauty plugin must be added to the `plugins` parameter of prebuilt components
- The beauty button must be added to menu bar config to show the UI
- For iOS, ensure beauty resources are properly bundled
- Some features require specific app ID permissions
