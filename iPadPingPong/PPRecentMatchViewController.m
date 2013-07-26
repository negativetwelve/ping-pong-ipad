//
//  PPRecentMatchesViewController.m
//  iPadPingPong
//
//  Created by Alton Zheng-Xie on 7/26/13.
//  Copyright (c) 2013 Mark Miyashita. All rights reserved.
//

#import "PPRecentMatchViewController.h"
#import "PPMatch.h"
#import <RestKit/RestKit.h>
#import "PPSetupMatchViewController.h"
#import "PPUser.h"


@interface PPRecentMatchViewController ()

@end

@implementation PPRecentMatchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		// Custom initialization
		self.title = @"Recent Matches";
	}
	return self;
}

- (void)viewWillAppear:(BOOL)animated	{
	RKObjectManager *objectManager = [RKObjectManager sharedManager];
	
	NSMutableURLRequest *request = [objectManager requestWithObject:nil method:RKRequestMethodGET path:@"api/match" parameters:nil];
	
	RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[PPMatch.getMatchesResponseDescriptor]];
	
	[objectRequestOperation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
		NSLog(@"Recieved matches from server");
		NSArray */*of PPUser*/matches = [mappingResult.dictionary objectForKey:@"matches"];
		self.matches = matches;
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


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if (self.matches) {
		return self.matches.count;
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
	if (self.matches) {
		PPMatch* match = [self.matches objectAtIndex:[indexPath row]];
		UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 40, 40)];
		nameLabel.text = [NSString stringWithFormat:@"%@ beat %@", match.winner.name, match.loser.name];
		nameLabel.font = [UIFont systemFontOfSize:30.0];
		[nameLabel sizeToFit];
		[cell addSubview:nameLabel];

		UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(600, 30, 0, 0)];
		NSDate *date = [NSDate dateWithTimeIntervalSince1970:[match.timeStamp floatValue]];
		NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setDateStyle: NSDateFormatterMediumStyle];
		timeLabel.text = [dateFormatter stringFromDate:date];
		timeLabel.font = [UIFont systemFontOfSize:20.0];
		[timeLabel sizeToFit];
		[cell addSubview:timeLabel];
		

	}
	
	return cell;
}

@end
