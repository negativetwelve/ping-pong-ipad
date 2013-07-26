//
//  PPSetupMatchViewController.h
//  iPadPingPong
//
//  Created by Alton Zheng-Xie on 7/26/13.
//  Copyright (c) 2013 Mark Miyashita. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PPError.h"

@class PPUser;

@interface PPSetupMatchViewController : UIViewController {
  PPUser *user;
}

@property (strong, nonatomic) PPUser *user;

@property (nonatomic, copy) PPUser *playerOneUser;
@property (nonatomic, copy) PPUser *playerTwoUser;

-(void)firstPlayerDidBadgeIn:(PPUser *)firstPlayer;
-(void)secondPlayerDidBadgeIn:(PPUser *)secondPlayer;

@end
