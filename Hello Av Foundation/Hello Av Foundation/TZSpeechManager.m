//
//  TZSpeechManager.m
//  Hello Av Foundation
//
//  Created by tom on 09/03/2018.
//  Copyright © 2018 TZ. All rights reserved.
//

#import "TZSpeechManager.h"

static TZSpeechManager *s = nil;

@interface TZSpeechManager ()
@property (nonatomic, strong) NSMutableArray *messages;
@property (nonatomic, strong) AVSpeechSynthesizer *speectSynthesizer;
@property (nonatomic, strong) NSArray *voices;
@end

@implementation TZSpeechManager
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (s == nil) {
            s = [super allocWithZone:zone];
        }
    });
    return s;
}

+ (instancetype)share {
    return [[self alloc] init];
}

- (instancetype)init {
    self =  [super init];
    if (self) {
        self.messages = @[].mutableCopy;
        for (int i = 0; i++ < 12;) {
            NSString *string = [NSString stringWithFormat:@"string%d", i];
            [self.messages addObject:NSLocalizedString(string, nil)];
        }
        self.speectSynthesizer = [AVSpeechSynthesizer new];
        self.voices = @[
                        [AVSpeechSynthesisVoice voiceWithLanguage:@"ZH-cn"],
                        [AVSpeechSynthesisVoice voiceWithLanguage:@"en-US"],
                        ];
    }
    return self;
}

- (void)speakContinuously {
    for (int i = 0; i < self.messages.count; i++) {
        AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc] initWithString:self.messages[i]];
        utterance.voice = self.voices[i % 2];
        utterance.rate = 0.7;
        [self.speectSynthesizer speakUtterance:utterance];
    }
}

@end
