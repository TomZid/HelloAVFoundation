//
//  TZSpeechManager.h
//  Hello Av Foundation
//
//  Created by tom on 09/03/2018.
//  Copyright © 2018 TZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface TZSpeechManager : NSObject

+ (instancetype)share;

@property (nonatomic, strong, readonly) AVSpeechSynthesizer *speectSynthesizer;

- (void)speakContinuously;

@end
