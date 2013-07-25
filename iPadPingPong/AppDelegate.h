//
//  AppDelegate.h
//  iPadPingPong
//
//  Created by Mark Miyashita on 7/25/13.
//  Copyright (c) 2013 Mark Miyashita. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PPUIWindow.h"
#import "PPHomeViewController.h"

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) PPUIWindow *window;

@property (strong, nonatomic) PPHomeViewController *homeViewController;

@end
