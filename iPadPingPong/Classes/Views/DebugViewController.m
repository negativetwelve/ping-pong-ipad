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
  
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
