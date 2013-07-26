//
//  PPUserEditNavigationController.m
//  iPadPingPong
//
//  Created by Mark Miyashita on 7/25/13.
//  Copyright (c) 2013 Mark Miyashita. All rights reserved.
//

#import "PPUserEditNavigationController.h"

@interface PPUserEditNavigationController ()

@end

@implementation PPUserEditNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    self.title = @"User Sign In";
		self.navigationBar.backgroundColor = [UIColor colorWithRed:174.0/255 green:12.0/255 blue:4/255.0 alpha:1.0];

  }
  return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
