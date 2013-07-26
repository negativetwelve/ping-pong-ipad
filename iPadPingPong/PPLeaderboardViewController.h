//
//  PPLeaderboardViewController.h
//  iPadPingPong
//
//  Created by Alton Zheng-Xie on 7/25/13.
//  Copyright (c) 2013 Mark Miyashita. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PPLeaderboardViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property NSArray */*of PPMatch*/users;

@end
