//
//  PPEditUserViewController.m
//  iPadPingPong
//
//  Created by Mark Miyashita on 7/26/13.
//  Copyright (c) 2013 Mark Miyashita. All rights reserved.
//

#import "PPEditUserViewController.h"

@interface PPEditUserViewController ()

@end

@implementation PPEditUserViewController
@synthesize name;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
      [self.view setBackgroundColor:[UIColor whiteColor]];
      UIButton *editName = [UIButton buttonWithType:UIButtonTypeCustom];
      [editName setFrame: CGRectMake(200, 400, 100, 50)];
      editName.font = [UIFont fontWithName:@"Helvetica Neue" size:40.0];
      [editName setTitle:@"Save!" forState:UIControlStateNormal];
      [editName addTarget:self action:@selector(save:) forControlEvents:UIControlEventTouchUpInside];
      editName.titleLabel.textColor = [UIColor blackColor];
      editName.backgroundColor = [UIColor whiteColor];
      
      [self.view addSubview:editName];
      
      UITextField *nameField = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, 400, 50)];
      [nameField setDelegate:self];
      [self setName:nameField];
      [self.view addSubview:nameField];
      
      
        // Custom initialization
    }
    return self;
}

- (void)save:(id)selector {
  NSLog(@"save");
  NSLog(@"%@ %@", self.name.text, self.badge);
  
  NSDictionary *params = @{
                           @"name" : self.name.text,
                           @"badge": self.badge,
                           };
  
  RKObjectManager *objectManager = [RKObjectManager sharedManager];
  NSMutableURLRequest *request = [objectManager requestWithObject:nil method:RKRequestMethodPOST path:@"api/player/" parameters:params];
  
  RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[PPUser.userResponseDescriptor, PPError.responseDescriptor]];
  
  [objectRequestOperation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
    NSLog(@"Recieved player from server");
    PPUser *user = [mappingResult.dictionary objectForKey:@"player"];
    NSLog(@"%@", user.badge);
  
    [self dismissViewControllerAnimated:YES completion:nil];

  } failure:^(RKObjectRequestOperation *operation, NSError *error) {
    NSLog(@"Error loading user");
    UIAlertView *alert2 = [[UIAlertView alloc] initWithTitle:@"ERROR" message:@"ERROR APP DELEGATE" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
    [alert2 show];
    [self dismissViewControllerAnimated:YES completion:nil];

  }];
  [objectManager enqueueObjectRequestOperation:objectRequestOperation];

  
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
