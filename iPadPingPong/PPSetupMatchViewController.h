//
//  PPSetupMatchViewController.h
//  iPadPingPong
//
//  Created by Alton Zheng-Xie on 7/26/13.
//  Copyright (c) 2013 Mark Miyashita. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPUser.h"

@interface PPSetupMatchViewController : UIViewController {
  PPUser *user;
}

@property (strong, nonatomic) PPUser *user;

@end
