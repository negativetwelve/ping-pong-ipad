//
//  PPLeaderboardViewController.m
//  iPadPingPong
//
//  Created by Alton Zheng-Xie on 7/25/13.
//  Copyright (c) 2013 Mark Miyashita. All rights reserved.
//

#import "PPLeaderboardViewController.h"
#import <RestKit/RestKit.h>
#import "PPMatch.h"
#import "PPUser.h"

@interface PPLeaderboardViewController ()

@end

@implementation PPLeaderboardViewController

- (id)init 
{
  self = [super init];
  if (self) {
      // Custom initialization
		self.title = @"Leaderboard";
  }
  return self;
}

- (void)viewWillAppear:(BOOL)animated {
	RKObjectManager *objectManager = [RKObjectManager sharedManager];
	
  NSMutableURLRequest *request = [objectManager requestWithObject:nil method:RKRequestMethodGET path:@"api/leaderboard" parameters:nil];
  
  RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[PPUser.usersResponseDescriptor]];
  
  [objectRequestOperation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
    NSLog(@"Recieved leaderboard from server");
    NSArray */*of PPUser*/users = [mappingResult.dictionary objectForKey:@"players"];
    self.users = users;
    [self.tableView reloadData];
		//    [self.tableView sizeToFit];
  } failure:^(RKObjectRequestOperation *operation, NSError *error) {
    NSLog(@"Error loading matches");
  }];
  
  [objectManager enqueueObjectRequestOperation:objectRequestOperation];
}

- (void)viewDidLoad
{
  [super viewDidLoad];
	CGRect tableViewFrame = CGRectMake(0, 0,  self.view.bounds.size.width, self.view.bounds.size.height);

  
  self.tableView = [[UITableView alloc] initWithFrame:tableViewFrame style:UITableViewStylePlain];
  self.tableView.delegate = self;
  self.tableView.dataSource = self;
  self.tableView.backgroundColor = [UIColor whiteColor];

  [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  if (self.users) {
    return self.users.count;
  }
  return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 80.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell;
  static NSString *tableViewCellIdentifier = @"CellIdentifier";
  cell = [tableView dequeueReusableCellWithIdentifier:tableViewCellIdentifier];
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:tableViewCellIdentifier];
  }
	
	for (UIView *subView in [cell subviews]) {
		[subView removeFromSuperview];
	}
	
  if (self.users) {
    PPUser *user = [self.users objectAtIndex:[indexPath row]];
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
		if (!user.name) {
			nameLabel.text = @"Anonymous";
		} else {
			nameLabel.text = user.name;
		}
		nameLabel.font = [UIFont systemFontOfSize:30.0];
		[nameLabel sizeToFit];
    [cell addSubview:nameLabel];
  
		UILabel *skillLabel = [[UILabel alloc] initWithFrame:CGRectMake(500, 10, 0, 0)];
		skillLabel.text = [NSString stringWithFormat:@"Skill Level: %1.2f", [user.skill floatValue]];
		skillLabel.font = [UIFont systemFontOfSize:30.0];
		skillLabel.textColor = [UIColor blueColor];
		[skillLabel sizeToFit];
		[cell addSubview:skillLabel];
		
	}
  
  return cell;
}

@end
