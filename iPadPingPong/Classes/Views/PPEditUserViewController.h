//
//  PPEditUserViewController.h
//  iPadPingPong
//
//  Created by Mark Miyashita on 7/26/13.
//  Copyright (c) 2013 Mark Miyashita. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <RestKit/RestKit.h>

#import "PPUser.h"
#import "PPError.h"

@interface PPEditUserViewController : UIViewController <UITextFieldDelegate> {
  UITextField *name;
  NSString *badge;
}

@property (nonatomic, strong) UITextField *name;
@property (nonatomic, strong) NSString *badge;

@end
