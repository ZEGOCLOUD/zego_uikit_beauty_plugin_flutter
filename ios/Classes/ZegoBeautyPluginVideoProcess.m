//
//  ZegoBeautyPluginVideoProcess.m
//  Runner
//
//  Created by Kael Ding on 2023/4/19.
//

#import "ZegoBeautyPluginVideoProcess.h"
#import <zego_effects_plugin/ZegoEffectsMethodHandler.h>
#import <zego_express_engine/ZegoCustomVideoProcessManager.h>

@interface ZegoBeautyPluginVideoProcess()<ZegoFlutterCustomVideoProcessHandler>

@end

@implementation ZegoBeautyPluginVideoProcess

+ (instancetype)sharedInstance {
    static ZegoBeautyPluginVideoProcess *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ZegoBeautyPluginVideoProcess alloc] init];
    });
    return instance;
}

- (void)enableCustomVideoProcessing {
    [ZegoCustomVideoProcessManager.sharedInstance setCustomVideoProcessHandler:self];
}

- (void)onStart:(ZGFlutterPublishChannel)channel {
    
}

- (void)onStop:(ZGFlutterPublishChannel)channel {
    
}

- (void)onCapturedUnprocessedCVPixelBuffer:(CVPixelBufferRef)buffer timestamp:(CMTime)timestamp channel:(ZGFlutterPublishChannel)channel {
    [[ZegoEffectsMethodHandler sharedInstance] processImageBuffer:buffer];
    [[ZegoCustomVideoProcessManager sharedInstance] sendProcessedCVPixelBuffer:buffer timestamp:timestamp channel:channel];
}


@end
