//
//  AppDelegate.m
//  iPadPingPong
//
//  Created by Mark Miyashita on 7/25/13.
//  Copyright (c) 2013 Mark Miyashita. All rights reserved.
//

#import "AppDelegate.h"
#import <RestKit/RestKit.h>

@implementation AppDelegate

- (void)initializeSounds {
  // Initialize 'glass' sound
  NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"Glass" ofType:@"aiff"];
  CFURLRef soundURL = (__bridge CFURLRef)[NSURL fileURLWithPath:soundPath];
  AudioServicesCreateSystemSoundID(soundURL, &systemSounds_[0]);
}

- (void)playSystemSoundGlass {
  AudioServicesPlaySystemSound(systemSounds_[0]);
}

- (void)registerTagId:(NSString *)tagId {
  NSLog(@"got tagid: %@", tagId);
  [self.homeViewController.userEditViewController setTagId:tagId editable:NO];
}

- (void)_unknownTagId:(NSNotification *)notification {
  [self registerTagId:[notification object]];
  [self playSystemSoundGlass];
}

- (void)login:(PPUser *)user {
  NSLog(@"logging in user: %@", user.name);
  
}

- (void)kegboard:(KBKegboard *)kegboard didReceiveAuthToken:(KBKegboardMessageAuthToken *)message {
  // Only send a message when the card becomes present
//  if ([message status]) [self.delegate kegProcessing:self didReceiveRFIDTagId:[message token]];
}

- (void)didReceiveRFIDTagId:(NSString *)tagId {
  PPUser *user = [self.homeViewController.userEditViewController loginWithTagId:tagId];
  if (!user) {
//    [self logout];
    [[NSNotificationCenter defaultCenter] postNotificationName:PPUnknownTagIdNotification object:tagId];
  }
}

- (void)start:(PPUserEditViewController *)controller {
  KBKegProcessing *keg = [[KBKegProcessing alloc] init];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  self.window = [[PPUIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  
  RKLogConfigureByName("RestKit/Network*", RKLogLevelTrace);
  RKLogConfigureByName("RestKit/ObjectMapping", RKLogLevelTrace);
  
  [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
  
  NSURL *localURL = [NSURL URLWithString:@"http://localhost:3000/"];
  AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:localURL];
  
  [client setDefaultHeader:@"Accept" value:RKMIMETypeJSON];
  
  RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:client];
  [RKObjectManager setSharedManager:objectManager];

  if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
    self.homeViewController = [[PPHomeViewController alloc] init];
  } else {
    self.homeViewController = [[PPHomeViewController alloc] init];
  }
  
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_unknownTagId:) name:PPUnknownTagIdNotification object:nil];

  PPUserEditViewController *userEditViewController = [[PPUserEditViewController alloc] init];
  PPUserEditNavigationController *userEditNavigationController = [[PPUserEditNavigationController alloc] initWithRootViewController:userEditViewController];
  
  [self registerTagId:@"test"];
  
  NSLog(@"Loaded home view controller");
  
  [self.homeViewController setViewControllers:@[userEditNavigationController]];
  [self.homeViewController setUserEditViewController:userEditViewController];
  self.window.rootViewController = self.homeViewController;
  [self.window makeKeyAndVisible];
//  [self.window.rootViewController presentModalViewController:userEditNavigationController animated:YES];

  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Welcome!" message:@"Scan your Yelp ID" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
  
  [alert show];
  
  [self start:userEditViewController];
  
  return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
  // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
  // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
  // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
  // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
