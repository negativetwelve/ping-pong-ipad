//
//  DebugViewController.m
//  iPadPingPong
//
//  Created by Mark Miyashita on 7/26/13.
//  Copyright (c) 2013 Mark Miyashita. All rights reserved.
//

#import "DebugViewController.h"

@interface DebugViewController ()

@end

@implementation DebugViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
      self.title = @"Debug";
    }
    return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  NSLog(@"view did load debug");
  
  UIButton *sendRequest = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 120, 60)];
  [sendRequest setBackgroundColor:[UIColor grayColor]];
  [sendRequest setTitle:@"Send Request" forState:UIControlStateNormal];
  [sendRequest addTarget:self action:@selector(sendRequest:) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:sendRequest];
	// Do any additional setup after loading the view.
}

- (void)sendRequest:(id)selector {
  NSLog(@"sending request");
  
  NSString *badge = @"123";
  
  NSDictionary *params = @{
  @"name": @"bob",
  @"badge": badge,
  };

  RKObjectManager *objectManager = [RKObjectManager sharedManager];
  NSMutableURLRequest *request = [objectManager requestWithObject:nil method:RKRequestMethodPOST path:@"api/player/" parameters:params];
  
  RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[PPUser.usersResponseDescriptor, PPError.responseDescriptor]];
  
  [objectRequestOperation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
    NSLog(@"Recieved player from server");
    PPUser *user = [mappingResult.dictionary objectForKey:@"user"];
    NSLog(@"%@", user.badge);
  } failure:^(RKObjectRequestOperation *operation, NSError *error) {
    NSLog(@"Error loading user");
  }];
  
  [objectManager enqueueObjectRequestOperation:objectRequestOperation];
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
