//
//  MouseAutoClick.m
//  LocalizationTools
//
//  Created by iDevFans on 16/9/3.
//  Copyright © 2016年 macdev. All rights reserved.
//

#import "MouseAutoClick.h"
#include <ApplicationServices/ApplicationServices.h>
#include <unistd.h>
@implementation MouseAutoClick
+ (void)postClickAt:(NSPoint)point{
    float x = point.x ;
    float y = point.y;
    float duration = 0.1;
    CGEventRef click_down = CGEventCreateMouseEvent(
                                                    NULL, kCGEventLeftMouseDown,
                                                    CGPointMake(x, y),
                                                    kCGMouseButtonLeft
                                                    );
    
    CGEventRef click_up = CGEventCreateMouseEvent(
                                                  NULL, kCGEventLeftMouseUp,
                                                  CGPointMake(x, y),
                                                  kCGMouseButtonLeft
                                                  );
    
    for (int i = 0; i < 1; i++) {
        CGEventPost(kCGHIDEventTap, click_down);
        sleep(duration);
        CGEventPost(kCGHIDEventTap, click_up);
        sleep(duration);
    }
    
    // Release the events
    CFRelease(click_down);
    CFRelease(click_up);
}
@end
