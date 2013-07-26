//
//  PPSetupMatchViewController.m
//  iPadPingPong
//
//  Created by Alton Zheng-Xie on 7/26/13.
//  Copyright (c) 2013 Mark Miyashita. All rights reserved.
//

#import "PPSetupMatchViewController.h"

@interface PPSetupMatchViewController ()

@end

@implementation PPSetupMatchViewController
@synthesize user;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
	[super viewDidLoad];
	self.view.backgroundColor = [UIColor blueColor];
	
	UILabel *playerOne = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 0, 0)];
	UILabel *playerTwo = [[UILabel alloc] initWithFrame:CGRectMake(350, 420, 0, 0)];
	UIImageView *vsImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"vs.png"]];
	vsImage.frame = CGRectMake(200, 220, 100, 100);
	playerOne.text = @"Player 1";
	playerOne.backgroundColor = [UIColor clearColor];
	playerOne.textColor = [UIColor whiteColor];
	playerTwo.text = @"Player 2";
	playerTwo.backgroundColor = [UIColor clearColor];
	playerTwo.textColor = [UIColor whiteColor];
	playerOne.font = [UIFont fontWithName:@"Helvetica Neue" size:40.0];
	playerTwo.font = [UIFont fontWithName:@"Helvetica Neue" size:40.0];

	[playerOne sizeToFit];
	[playerTwo sizeToFit];
	[self.view addSubview:vsImage];
	[self.view addSubview: playerOne];
	[self.view addSubview: playerTwo];
	
	
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
