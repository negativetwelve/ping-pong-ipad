//
//  AppDelegate.h
//  iPadPingPong
//
//  Created by Mark Miyashita on 7/25/13.
//  Copyright (c) 2013 Mark Miyashita. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioServices.h>

#import "PPUIWindow.h"
#import "PPHomeViewController.h"
#import <RestKit/RestKit.h>

@class PPHomeViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
  SystemSoundID systemSounds_[1];
}

@property (strong, nonatomic) PPUIWindow *window;

@property (strong, nonatomic) PPHomeViewController *homeViewController;

@end
