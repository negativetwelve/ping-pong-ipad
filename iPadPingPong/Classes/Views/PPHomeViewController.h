//
//  PPHomeViewController.h
//  iPadPingPong
//
//  Created by Mark Miyashita on 7/25/13.
//  Copyright (c) 2013 Mark Miyashita. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PPUserEditViewController.h"

@class PPUserEditViewController;
@interface PPHomeViewController : UITabBarController {
  PPUserEditViewController *userEditViewController;
}

@property (nonatomic, strong) PPUserEditViewController *userEditViewController;

@end
