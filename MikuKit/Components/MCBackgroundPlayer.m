//
//  MCBackgroundPlayer.m
//  MotionCamera
//
//  Created by 原鹏飞 on 2019/10/14.
//  Copyright © 2019 Apeman. All rights reserved.
//

#import "MCBackgroundPlayer.h"
#import <AVFoundation/AVFoundation.h>

@interface MCBackgroundPlayer ()

@property(strong, nonatomic) AVAudioPlayer *mPlayer;
@property(assign, nonatomic) CGFloat mCount;

@end

@implementation MCBackgroundPlayer

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _mCount = 0;
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(countTime) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)countTime {
    _mCount += 10;
    PFLog(@"🐶%f", _mCount);
    if ([[UIApplication sharedApplication] backgroundTimeRemaining] < 60.) {
        // 当剩余时间小于60时，开如播放音乐，并用这个假前台状态再次申请后台 PFLog(@"播放%@",[NSThread currentThread]);
        
        [self playMusic]; // 申请后台
        
        
        [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
            PFLog(@"我要挂起了"); }];
    }
}

- (void)playMusic {
    //1.音频文件的url路径，实际开发中，用无声音乐
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"Little luck-Hebe.mp3" withExtension:Nil];
    //2.创建播放器（注意：一个AVAudioPlayer只能播放一个url）
    _mPlayer= [[AVAudioPlayer alloc] initWithContentsOfURL:url error:Nil];
    //3.缓冲
    [_mPlayer prepareToPlay];
    //4.播放
    [_mPlayer play];
}

- (void)stopMusic {
    [_mPlayer stop];
}


@end
