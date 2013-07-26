//
//  PPSetupMatchViewController.m
//  iPadPingPong
//
//  Created by Alton Zheng-Xie on 7/26/13.
//  Copyright (c) 2013 Mark Miyashita. All rights reserved.
//

#import "PPSetupMatchViewController.h"
#import "PPUser.h"
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
	self.view.backgroundColor = [UIColor whiteColor];
	
	UILabel *playerTwo = [[UILabel alloc] initWithFrame:CGRectMake(180, 420, 0, 0)];
	UIImageView *vsImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"vs.png"]];

	vsImage.frame = CGRectMake(200, 220, 100, 100);
	
	[self.view addSubview:vsImage];
	
	// Do any additional setup after loading the view.
}

-(void)firstPlayerDidBadgeIn:(PPUser *)firstPlayer {
	UILabel *playerOne = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 0, 0)];
	UIImageView *playerOneImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"player1.jpg"]];
	playerOneImage.frame = CGRectMake(-600, 50, 170, 300);
	playerOne.text = firstPlayer.name;
	playerOne.font = [UIFont fontWithName:@"Helvetica Neue" size:40.0];
	playerOne.backgroundColor = [UIColor clearColor];
	playerOne.textColor = [UIColor blueColor];
	[playerOne sizeToFit];
	[self.view addSubview: playerOne];
	[self.view addSubview:playerOneImage];

	[UIView animateWithDuration:0.6 animations:^{
		playerOneImage.frame = CGRectMake(10, 50, 170, 300);
	}];
}

-(void)secondPlayerDidBadgeIn:(PPUser *)secondPlayer {
	UILabel *playerTwo = [[UILabel alloc] initWithFrame:CGRectMake(330, 10, 0, 0)];
	UIImageView *playerTwoImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"player2.jpg"]];
	playerTwoImage.frame = CGRectMake(1200, 50, 170, 300);
	playerTwo.text = secondPlayer.name;
	playerTwo.backgroundColor = [UIColor clearColor];
	playerTwo.textColor = [UIColor redColor];
	playerTwo.font = [UIFont fontWithName:@"Helvetica Neue" size:40.0];
	
	[playerTwo sizeToFit];
	[self.view addSubview:playerTwo];
	[self.view addSubview:playerTwoImage];
	[UIView animateWithDuration:0.6 animations:^{
		playerTwoImage.frame = CGRectMake(350, 50, 170, 300);
	}];
	
	UIButton *player1Button = [UIButton buttonWithType:UIButtonTypeCustom];
	[player1Button setFrame: CGRectMake(20, 440, 200, 70)];
	player1Button.backgroundColor = [UIColor blueColor];
	UIButton *player2Button = [UIButton buttonWithType:UIButtonTypeCustom];
	[player2Button setFrame: CGRectMake(300, 440, 200, 70)];
	player2Button.backgroundColor = [UIColor redColor];

	[player2Button addTarget:self action:@selector(player1buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
	[player1Button addTarget:self action:@selector(player2buttonPressed:) forControlEvents:UIControlEventTouchUpInside];

	[player1Button setTitle:@"Player 1 Won" forState:UIControlStateNormal];
	[player2Button setTitle:@"Player 2 Won" forState:UIControlStateNormal];

	player1Button.titleLabel.textColor = [UIColor whiteColor];
	player2Button.titleLabel.textColor = [UIColor whiteColor];

	
	[self.view addSubview:player1Button];
	[self.view addSubview:player2Button];
	

}

- (void)player1buttonPressed:(id)sender {
	
}

- (void)player2buttonPressed:(id)sender {
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
