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

// Navigation Controllers
#import "PPUserEditNavigationController.h"
#import "DebugNavigationController.h"
#import "PPRecentMatchNavController.h"
#import "PPSetupMatchViewController.h"

// View Controllers
#import "PPUserEditViewController.h"
#import "DebugViewController.h"
#import "PPLeaderboardViewController.h"
#import "PPRecentMatchViewController.h"

#import "PPNotifications.h"

#import "KBKegProcessing.h"


@class PPHomeViewController;
@class KBKegboard;
@interface AppDelegate : NSObject <UIApplicationDelegate> {
  SystemSoundID systemSounds_[1];
  bool processing;
  bool firstUserIsLoggedIn;
}

@property (strong, nonatomic) PPUIWindow *window;
@property (assign, nonatomic) bool processing;
@property (assign, nonatomic) bool firstUserIsLoggedIn;

@property (strong, nonatomic) PPHomeViewController *homeViewController;

- (void)kegboard:(KBKegboard *)kegboard didReceiveAuthToken:(KBKegboardMessageAuthToken *)message;

@end
