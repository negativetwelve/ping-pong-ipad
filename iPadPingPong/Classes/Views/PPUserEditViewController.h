//
//  PPUserEditViewController.h
//  iPadPingPong
//
//  Created by Mark Miyashita on 7/25/13.
//  Copyright (c) 2013 Mark Miyashita. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"

#import "PPUser.h"
@class AppDelegate;
@interface PPUserEditViewController : UIViewController <UIAlertViewDelegate> {
  AppDelegate *appDelegate;
}

@property (strong, nonatomic) AppDelegate *appDelegate;

- (void)setTagId:(NSString *)tagId editable:(BOOL)editable;
- (PPUser *)loginWithTagId:(NSString *)tagId;

@end