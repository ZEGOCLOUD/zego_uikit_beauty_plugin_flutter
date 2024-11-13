#import "ZegoUIKitBeautyPlugin.h"
#import "ZegoBeautyPluginVideoProcess.h"

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

  else if ([@"enableCustomVideoProcessing" isEqualToString:call.method]) {
  
    [ZegoBeautyPluginVideoProcess.sharedInstance enableCustomVideoProcessing];
    result(nil);
  }

  else if ([@"getResourcesFolder" isEqualToString:call.method]) {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"BeautyResources" ofType:nil];
    result(path);
  }
  
  else {
    result(FlutterMethodNotImplemented);
  }
}

@end
