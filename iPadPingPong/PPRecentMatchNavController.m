//
//  PPRecentMatchNavController.m
//  iPadPingPong
//
//  Created by Alton Zheng-Xie on 7/26/13.
//  Copyright (c) 2013 Mark Miyashita. All rights reserved.
//

#import "PPRecentMatchNavController.h"
#import "PPSetupMatchViewController.h"

@interface PPRecentMatchNavController ()

@end

@implementation PPRecentMatchNavController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
			self.title = @"Recent Matches";
    }
    return self;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
