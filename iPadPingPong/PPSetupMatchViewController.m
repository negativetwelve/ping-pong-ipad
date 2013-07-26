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
	UILabel *playerTwo = [[UILabel alloc] initWithFrame:CGRectMake(300, 420, 0, 0)];
	UIImageView *playerTwoImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"player2.jpg"]];
	playerTwoImage.frame = CGRectMake(1200, 450, 170, 300);
	playerTwo.text = secondPlayer.name;
	playerTwo.backgroundColor = [UIColor clearColor];
	playerTwo.textColor = [UIColor redColor];
	playerTwo.font = [UIFont fontWithName:@"Helvetica Neue" size:40.0];
	
	[playerTwo sizeToFit];
	[self.view addSubview:playerTwo];
	[self.view addSubview:playerTwoImage];
	[UIView animateWithDuration:0.6 animations:^{
		playerTwoImage.frame = CGRectMake(300, 450, 170, 300);
	}];
	
	UIButton *player1Button = [[UIButton alloc] initWithFrame:CGRectMake(20, 450, 300, 100)];
	UIButton *player2Button = [[UIButton alloc] initWithFrame:CGRectMake(20, 450, 300, 100)];

//	[player2Button addTarget:self action:@selector(<#selector#>) forControlEvents:<#(UIControlEvents)#>]
	player1Button.titleLabel.text = @"Player 1 Won";
	player2Button.titleLabel.text = @"Player 2 Won";
	
	[self.view addSubview:player1Button];
	[self.view addSubview:player2Button];
	

}


- (void)someoneWon:(PPUser *)winner against:(PPUser *)loser {
  NSLog(@"recording winner/loser");
  
  NSDictionary *params = @{
  @"winner_badge" : @"",
  @"loser_badge" : @"",
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
