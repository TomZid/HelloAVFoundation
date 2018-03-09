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
@property (nonatomic, strong) NSArray *messages;
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
        self.messages = @[@"对，你无情你残酷你无理取闹！",
                          @"那你就不无情！？不残酷！？不无理 取闹！？",
                          @"我哪里无情！？哪里残酷 ！？哪里无理取闹！？",
                          @"你哪里不无 情！？哪里不残酷！？哪里不无理取闹！ ？",
                          @"我就算在怎么无情再怎么残酷再 怎么无理取闹也不会比你更无情更残酷更 无理取闹！",
                          @"我会比你无情！？比你 残酷！？比你无理取闹！？你才是我见过 最无情最残酷最无理取闹的人！",
                          @"哼 ，我绝对没你无情没你残酷没你无理取闹 ！",
                          @"好，既然你说我无情我残酷我无 理取闹我就无情给你看残酷给你看无理取 闹给你看！",
                          @"看吧，还说你不无情不 残酷不无理取闹现在完全展现你无情残酷 无理取的一面了吧",
                          @"啊啊啊啊啊啊",
                          @"呀呀呀呀",
                          ];
//        self.messages = @[@"Hello AV Foundation. How are you?",
//                          @"I'm well! Thanks for asking.",
//                          @"Are you excited about the book?",
//                          @"Very! I have always felt so misunderstood.",
//                          @"What's your favorite feature?",
//                          @"Oh, they're all my babies.  I couldn't possibly choose.",
//                          @"It was great to speak with you!",
//                          @"The pleasure was all mine!  Have fun!",
//                          @"Hello AV Foundation. How are you?",
//                          @"I'm well! Thanks for asking.",
//                          @"Are you excited about the book?",
//                          @"Very! I have always felt so misunderstood.",
//                          @"What's your favorite feature?",
//                          @"Oh, they're all my babies.  I couldn't possibly choose.",
//                          @"It was great to speak with you!",
//                          @"The pleasure was all mine!  Have fun!",
//                          @"Hello AV Foundation. How are you?",
//                          @"I'm well! Thanks for asking.",
//                          @"Are you excited about the book?",
//                          @"Very! I have always felt so misunderstood.",
//                          @"What's your favorite feature?",
//                          @"Oh, they're all my babies.  I couldn't possibly choose.",
//                          @"It was great to speak with you!",
//                          @"The pleasure was all mine!  Have fun!",
//                          @"Hello AV Foundation. How are you?",
//                          @"I'm well! Thanks for asking.",
//                          @"Are you excited about the book?",
//                          @"Very! I have always felt so misunderstood.",
//                          @"What's your favorite feature?",
//                          @"Oh, they're all my babies.  I couldn't possibly choose.",
//                          @"It was great to speak with you!",
//                          @"The pleasure was all mine!  Have fun!",
//                          ];
        self.speectSynthesizer = [AVSpeechSynthesizer new];
        self.voices = @[
                        [AVSpeechSynthesisVoice voiceWithLanguage:@"ZH-cn"],
                        [AVSpeechSynthesisVoice voiceWithLanguage:@"zh-HK"],
//                        [AVSpeechSynthesisVoice voiceWithLanguage:@"en-US"],
//                        [AVSpeechSynthesisVoice voiceWithLanguage:@"en-US"],
                        ];
    }
    return self;
}

- (void)speakContinuously {
    for (int i = 0; i < self.messages.count; i++) {
        AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc] initWithString:self.messages[i]];
        utterance.voice = self.voices[i % 2];
        utterance.rate = 1;
        [self.speectSynthesizer speakUtterance:utterance];
    }
}

@end
