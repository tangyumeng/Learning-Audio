//
//  ListViewController.m
//  Audio1
//
//  Created by yumeng tang on 2018/6/30.
//  Copyright © 2018年 yumeng tang. All rights reserved.
//

#import "ListViewController.h"
#import <AudioToolbox/AudioToolbox.h>

@interface ListViewController ()

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self printFileMetaData];
}

-(void)printFileMetaData
{
    NSString * path =  [[NSBundle mainBundle] pathForResource:@"任贤齐-伤心太平洋" ofType:@"mp3"];
    NSURL *audioUrl = [NSURL fileURLWithPath:path];
    
    AudioFileID audioFile ;
    OSStatus theErr = noErr;
    theErr = AudioFileOpenURL((__bridge CFURLRef)audioUrl, kAudioFileReadPermission, 0, & audioFile);
    assert(theErr == noErr);
    UInt32 dictionarySize= 0;
    theErr = AudioFileGetPropertyInfo(audioFile, kAudioFilePropertyInfoDictionary, &dictionarySize, 0);
    assert(theErr == noErr);
    CFDictionaryRef dictionary;
    theErr = AudioFileGetProperty(audioFile, kAudioFilePropertyInfoDictionary, &dictionarySize, &dictionary);
    assert(theErr == noErr);
    NSLog(@"file dict is:%@",dictionary);
    CFRelease(dictionary);
    theErr = AudioFileClose(audioFile);
    assert(theErr == noErr);
    
}
@end
