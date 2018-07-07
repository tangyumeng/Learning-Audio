//
//  DIYSamplesViewController.m
//  Audio1
//
//  Created by yumeng tang on 2018/6/30.
//  Copyright © 2018年 yumeng tang. All rights reserved.
//

#import "DIYSamplesViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#define DURATION 5.0f
#define FILENAME_FORMAT @"%0.3f-square.aif"
#define SAMPLE_RATE 44100

@interface DIYSamplesViewController ()

@end

@implementation DIYSamplesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self diySample];
}

-(void)diySample
{
    double hz = 440;

    NSString *fileName = [NSString stringWithFormat: FILENAME_FORMAT, hz];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];

    NSString *filePath = [documentsDir stringByAppendingPathComponent: fileName];
    NSURL *fileURL = [NSURL fileURLWithPath: filePath];
    
    AudioStreamBasicDescription asbd;
    memset(&asbd, 0, sizeof(asbd));
    asbd.mSampleRate = SAMPLE_RATE;
    asbd.mFormatID = kAudioFormatLinearPCM;
    asbd.mFormatFlags = kAudioFormatFlagIsBigEndian | kAudioFormatFlagIsSignedInteger | kAudioFormatFlagIsPacked;
    asbd.mBitsPerChannel = 16;
    asbd.mChannelsPerFrame = 1;
    asbd.mFramesPerPacket = 1;
    asbd.mBytesPerFrame = 2;
    asbd.mBytesPerPacket = 2;
    
    
    AudioFileID audioFile;
    OSStatus audioErr = noErr;
    audioErr = AudioFileCreateWithURL((__bridge CFURLRef)fileURL, kAudioFileAIFFType, &asbd, kAudioFileFlags_EraseFile, &audioFile);
    assert(audioErr == noErr);
    
    long maxSampleCount = SAMPLE_RATE * DURATION;
    long sampleCount = 0;
    UInt32 bytesToWrite = 2;
    double waveLengthInSamples = SAMPLE_RATE / hz;
    while (sampleCount < maxSampleCount) {
        for (int i = 0 ; i < waveLengthInSamples; i++) {
            //square wave
            SInt16 sample ;
            if (i < waveLengthInSamples  / 2 ){
                sample = CFSwapInt16HostToBig(SHRT_MAX);
            }else{
                sample = CFSwapInt16HostToBig(SHRT_MIN);
            }
            audioErr = AudioFileWriteBytes(audioFile, false, sampleCount * 2, &bytesToWrite, &sample);
            assert(audioErr == noErr);
            sampleCount++;
        }
    }
    audioErr = AudioFileClose(audioFile);
    assert(audioErr == noErr);
    NSLog(@"wrote %ld samples ",sampleCount);
    
}
@end
