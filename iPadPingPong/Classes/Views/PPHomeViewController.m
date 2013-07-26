//
//  PPHomeViewController.m
//  iPadPingPong
//
//  Created by Mark Miyashita on 7/25/13.
//  Copyright (c) 2013 Mark Miyashita. All rights reserved.
//

#import "PPHomeViewController.h"
#import "PPLeaderboardViewController.h"

@interface PPHomeViewController ()

@end

@implementation PPHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    self.view.backgroundColor = [UIColor whiteColor];

    PPLeaderboardViewController *leaderBoardViewController = [[PPLeaderboardViewController alloc] init];
    UITabBarItem *leaderBoardTab = [[UITabBarItem alloc] initWithTitle:@"Leaderboard" image:nil tag:1];
    [leaderBoardViewController setTabBarItem:leaderBoardTab];
    
    
    NSArray *viewControllers = @[leaderBoardViewController];
    [self setViewControllers:viewControllers];
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
