//
//  ZegoBeautyPluginVideoProcess.h
//  Runner
//
//  Created by Kael Ding on 2023/4/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZegoBeautyPluginVideoProcess : NSObject

+ (instancetype)sharedInstance;

- (void)enableCustomVideoProcessing;

@end

NS_ASSUME_NONNULL_END
