//
//  CAStreamFormatTestViewController.m
//  Audio1
//
//  Created by yumeng tang on 2018/7/1.
//  Copyright © 2018年 yumeng tang. All rights reserved.
//

#import "CAStreamFormatTestViewController.h"
#import <AudioToolbox/AudioToolbox.h>

@interface CAStreamFormatTestViewController ()

@end

@implementation CAStreamFormatTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self test];
}


-(void)test
{
    AudioFileTypeAndFormatID fileTypeAndFormat;
    fileTypeAndFormat.mFileType = kAudioFileAIFFType;
    fileTypeAndFormat.mFormatID = kAudioFormatLinearPCM;
    
    OSStatus audioErr = noErr;
    UInt32 infoSize =0;
    
    audioErr = AudioFileGetGlobalInfoSize (kAudioFileGlobalInfo_AvailableStreamDescriptionsForFormat,
                                           sizeof (fileTypeAndFormat),
                                           &fileTypeAndFormat,
                                           &infoSize);
    assert(audioErr == noErr);
    
    AudioStreamBasicDescription *asbds = malloc(infoSize);
    audioErr = AudioFileGetGlobalInfo(kAudioFileGlobalInfo_AvailableStreamDescriptionsForFormat,
                                      sizeof(fileTypeAndFormat),
                                      &fileTypeAndFormat,
                                      &infoSize,
                                      asbds);
    
    assert(audioErr == noErr);
    int asbdCount = infoSize / sizeof(AudioStreamBasicDescription);
    for (int i = 0; i < asbdCount; i++) {
        UInt32 format4cc = CFSwapInt32HostToBig(asbds[i].mFormatID);
        NSLog(@"%d: mFormatId: %4.4s, mFormatFlags: %d, mBitsPerChannel: %d", i ,
              (char *)&format4cc,
              asbds[i].mFormatFlags,
              asbds[i].mBitsPerChannel);
    }
    free(asbds);
    
}

@end
