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
	
	
	// Do any additional setup after loading the view.
}

-(void)firstPlayerDidBadgeIn:(PPUser *)firstPlayer {
  [self setPlayerOneUser:firstPlayer];
	UILabel *playerOne = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 0, 0)];
	UIImageView *playerOneImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"player1.jpg"]];
	playerOneImage.frame = CGRectMake(-600, 50, 170, 300);
//	playerOne.text = firstPlayer.name;
	playerOne.font = [UIFont fontWithName:@"Helvetica Neue" size:40.0];
	playerOne.backgroundColor = [UIColor clearColor];
	playerOne.textColor = [UIColor blueColor];
	[playerOne sizeToFit];
  
  UIButton *editName = [UIButton buttonWithType:UIButtonTypeCustom];
	[editName setFrame: CGRectMake(0, 0, 150, 50)];
  editName.font = [UIFont fontWithName:@"Helvetica Neue" size:40.0];
  [editName setTitle:firstPlayer.name forState:UIControlStateNormal];
  [editName addTarget:self action:@selector(editName1:) forControlEvents:UIControlEventTouchUpInside];
  editName.titleLabel.textColor = [UIColor blackColor];
	editName.backgroundColor = [UIColor whiteColor];
  
  [self.view addSubview:editName];
	[self.view addSubview: playerOne];
	[self.view addSubview:playerOneImage];

	[UIView animateWithDuration:0.6 animations:^{
		playerOneImage.frame = CGRectMake(10, 50, 170, 300);
	}];
}

-(void)secondPlayerDidBadgeIn:(PPUser *)secondPlayer {
  [self setPlayerTwoUser:secondPlayer];
	UILabel *playerTwo = [[UILabel alloc] initWithFrame:CGRectMake(330, 10, 0, 0)];
	UIImageView *playerTwoImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"player2.jpg"]];
	playerTwoImage.frame = CGRectMake(1200, 50, 170, 300);
	playerTwo.backgroundColor = [UIColor clearColor];
	playerTwo.textColor = [UIColor redColor];
	playerTwo.font = [UIFont fontWithName:@"Helvetica Neue" size:40.0];
  
  UIButton *editName = [UIButton buttonWithType:UIButtonTypeCustom];
	[editName setFrame: CGRectMake(300, 0, 150, 50)];
  editName.font = [UIFont fontWithName:@"Helvetica Neue" size:40.0];
  [editName setTitle:secondPlayer.name forState:UIControlStateNormal];
  [editName addTarget:self action:@selector(editName2:) forControlEvents:UIControlEventTouchUpInside];
  editName.titleLabel.textColor = [UIColor blackColor];
	editName.backgroundColor = [UIColor whiteColor];
	
	[playerTwo sizeToFit];
  [self.view addSubview:editName];
	[self.view addSubview:playerTwo];
	[self.view addSubview:playerTwoImage];
	[UIView animateWithDuration:0.6 animations:^{
		playerTwoImage.frame = CGRectMake(350, 60, 170, 300);
	}];
	
	UIImageView *vsImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"vs.png"]];
	
	vsImage.frame = CGRectMake(0, 0, 1000, 1000);
	[UIView animateWithDuration:1.0 animations:^{
		vsImage.frame = CGRectMake(200, 220, 100, 100);
	}];
	
	[self.view addSubview:vsImage];
	
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
	[self someoneWon:self.playerOneUser against:self.playerTwoUser];
	[self resetView];
	[self.presentingViewController dismissModalViewControllerAnimated:YES];
}

- (void)player2buttonPressed:(id)sender {
	[self someoneWon:self.playerTwoUser against:self.playerOneUser];
	[self resetView];
	[self.presentingViewController dismissModalViewControllerAnimated:YES];

}

- (void)editName1:(id)sender {
  NSLog(@"edit name 1");
  [self editName:self.playerOneUser];
}

- (void)editName2:(id)sender {
  NSLog(@"edit name 2");
  [self editName:self.playerTwoUser];
}

- (void)editName:(PPUser *)user {
  PPEditUserViewController *editController = [[PPEditUserViewController alloc] init];
  editController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
  editController.modalPresentationStyle = UIModalPresentationFormSheet;
  [self presentViewController:editController animated:YES completion:nil];
}

- (void)resetView {
	for (UIView *subView in [self.view subviews]) {
		[subView removeFromSuperview];
	}
}

- (void)someoneWon:(PPUser *)winner against:(PPUser *)loser {
  NSLog(@"recording winner/loser");
  NSLog(@"winner %@, loser %@", winner, loser);
  
  NSDictionary *params = @{
                           @"winner" : @{@"badge" : winner.badge},
                           @"loser" : @{@"badge" : loser.badge},
  };
  
  RKObjectManager *objectManager = [RKObjectManager sharedManager];
  NSMutableURLRequest *request = [objectManager requestWithObject:nil method:RKRequestMethodPOST path:@"api/match/" parameters:params];
  
  RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[PPUser.userResponseDescriptor, PPError.responseDescriptor]];
  
  [objectRequestOperation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
//    PPUser *user = [mappingResult.dictionary objectForKey:@"player"];
    
  } failure:^(RKObjectRequestOperation *operation, NSError *error) {
    NSLog(@"Error.");
    
    
  }];
  
  [objectManager enqueueObjectRequestOperation:objectRequestOperation];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
