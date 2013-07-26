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
      
        // Custom initialization
    }
    return self;
}

- (void)save:(id)selector {
  NSLog(@"save");
  [self dismissViewControllerAnimated:YES completion:nil];
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
