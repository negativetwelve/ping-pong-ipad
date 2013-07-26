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
  
  NSLog(@"Loaded home view controller");
  
  self.window.rootViewController = self.homeViewController;
    [self.window makeKeyAndVisible];
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
