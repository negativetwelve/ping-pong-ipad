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
  
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];

  CGRect tableViewFrame = CGRectMake(self.view.bounds.size.width/2 - self.view.bounds.size.width/4, 200,  self.view.bounds.size.width/2, 400);
  
  self.tableView = [[UITableView alloc] initWithFrame:tableViewFrame style:UITableViewStylePlain];
  self.tableView.delegate = self;
  self.tableView.dataSource = self;
  self.tableView.backgroundColor = [UIColor whiteColor];
  [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];

  [self.view addSubview:self.tableView];
    
  RKObjectManager *objectManager = [RKObjectManager sharedManager];

  NSMutableURLRequest *request = [objectManager requestWithObject:nil method:RKRequestMethodGET path:@"test" parameters:nil];
  
  RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[PPUser.usersResponseDescriptor]];
  
  [objectRequestOperation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
    NSLog(@"Recieved matches from server");
    NSArray */*of PPUser*/users = [mappingResult.dictionary objectForKey:@"users"];
    self.users = users;
    [self.tableView reloadData];
//    [self.tableView sizeToFit];
  } failure:^(RKObjectRequestOperation *operation, NSError *error) {
    NSLog(@"Error loading matches");
  }];
  
  [objectManager enqueueObjectRequestOperation:objectRequestOperation];
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
  
  if (self.users) {
    PPUser *user = [self.users objectAtIndex:[indexPath row]];
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
    nameLabel.text = user.name;
    [cell addSubview:nameLabel];
  }
  
  return cell;
}

@end
