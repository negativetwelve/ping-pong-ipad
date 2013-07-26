//
//  DebugViewController.h
//  iPadPingPong
//
//  Created by Mark Miyashita on 7/26/13.
//  Copyright (c) 2013 Mark Miyashita. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>

#import "PPUser.h"
#import "PPError.h"
@class AppDelegate;

@interface DebugViewController : UIViewController

@property (strong, nonatomic) AppDelegate *appDelegate;

@end
