#import "ZegoUIKitBeautyPlugin.h"

@implementation ZegoUIKitBeautyPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"zego_uikit_beauty_plugin"
            binaryMessenger:[registrar messenger]];
  ZegoUIKitBeautyPlugin* instance = [[ZegoUIKitBeautyPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getPlatformVersion" isEqualToString:call.method]) {

  
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  } 

  
  else {
    result(FlutterMethodNotImplemented);
  }
}

@end
