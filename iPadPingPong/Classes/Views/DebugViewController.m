//
//  DebugViewController.m
//  iPadPingPong
//
//  Created by Mark Miyashita on 7/26/13.
//  Copyright (c) 2013 Mark Miyashita. All rights reserved.
//

#import "DebugViewController.h"
#import "AppDelegate.h"

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
  
  NSString *badge = [PPUser genRandStringLength:8]; 
  
  NSDictionary *params = @{
  @"badge": badge,
  };

  RKObjectManager *objectManager = [RKObjectManager sharedManager];
  NSMutableURLRequest *request = [objectManager requestWithObject:nil method:RKRequestMethodPOST path:@"api/player/" parameters:params];
  
  RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[PPUser.userResponseDescriptor, PPError.responseDescriptor]];
  
  [objectRequestOperation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
    NSLog(@"Recieved player from server");
    PPUser *user = [mappingResult.dictionary objectForKey:@"player"];
    NSLog(@"%@", user.badge);
    
  } failure:^(RKObjectRequestOperation *operation, NSError *error) {
    NSLog(@"Error loading user");
    
		PPSetupMatchViewController *setupMatchController = [[PPSetupMatchViewController alloc] init];
		setupMatchController.modalPresentationStyle = UIModalPresentationFormSheet;
		
		[self.appDelegate.homeViewController.selectedViewController presentModalViewController:setupMatchController animated:YES];
    
//    [self presentModalViewController:navController animated:YES];
  }];
  
  [objectManager enqueueObjectRequestOperation:objectRequestOperation];
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
