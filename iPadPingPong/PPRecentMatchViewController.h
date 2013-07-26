//
//  PPRecentMatchesViewController.h
//  iPadPingPong
//
//  Created by Alton Zheng-Xie on 7/26/13.
//  Copyright (c) 2013 Mark Miyashita. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PPRecentMatchViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSArray */*of PPMatch*/matches;

@end
