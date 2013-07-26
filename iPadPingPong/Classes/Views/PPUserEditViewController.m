//
//  PPUserEditViewController.m
//  iPadPingPong
//
//  Created by Mark Miyashita on 7/25/13.
//  Copyright (c) 2013 Mark Miyashita. All rights reserved.
//

#import "PPUserEditViewController.h"

@interface PPUserEditViewController ()

@end

@implementation PPUserEditViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
      self.title = @"Leaderboard";
        // Custom initialization
    }
    return self;
}

- (PPUser *)loginWithTagId:(NSString *)tagId {
  NSLog(@"log in with tag id");
  return [[PPUser alloc] init];
}

- (void)setTagId:(NSString *)tagId editable:(BOOL)editable {
  NSLog(@"setting tag id: %@", tagId);
//  tagField_.text = tagId;
//  tagField_.editable = editable;
//  isAdminField_.on = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
