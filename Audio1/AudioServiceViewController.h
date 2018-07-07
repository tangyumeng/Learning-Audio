//
//  AudioServiceViewController.h
//  Audio1
//
//  Created by yumeng tang on 2018/7/2.
//  Copyright © 2018年 yumeng tang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>

#define NUM_BUFFERS 3
#define SECONDS_TO_RECORD 10

// Struct defining recording state
typedef struct
{
    AudioStreamBasicDescription  dataFormat;
    AudioQueueRef                queue;
    AudioQueueBufferRef          buffers[NUM_BUFFERS];
    AudioFileID                  audioFile;
    SInt64                       currentPacket;
    bool                         recording;
} RecordState;

// Struct defining playback state
typedef struct
{
    AudioStreamBasicDescription  dataFormat;
    AudioQueueRef                queue;
    AudioQueueBufferRef          buffers[NUM_BUFFERS];
    AudioFileID                  audioFile;
    SInt64                       currentPacket;
    bool                         playing;
} PlayState;
@interface AudioServiceViewController : UIViewController
{
    UILabel* labelStatus;
    UIButton* buttonRecord;
    UIButton* buttonPlay;
    RecordState recordState;
    PlayState playState;
    CFURLRef fileURL;
}
@end
