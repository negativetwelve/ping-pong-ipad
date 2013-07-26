//
//  PPSetupMatchViewController.h
//  iPadPingPong
//
//  Created by Alton Zheng-Xie on 7/26/13.
//  Copyright (c) 2013 Mark Miyashita. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PPError.h"

#import "PPEditUserViewController.h"

@class PPUser;

@interface PPSetupMatchViewController : UIViewController {
  PPUser *user;
}

@property (strong, nonatomic) PPUser *user;

@property (nonatomic, strong) PPUser *playerOneUser;
@property (nonatomic, strong) PPUser *playerTwoUser;

-(void)firstPlayerDidBadgeIn:(PPUser *)firstPlayer;
-(void)secondPlayerDidBadgeIn:(PPUser *)secondPlayer;

@end
