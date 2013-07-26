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

- (void)sendRequest:(NSString *)tagID {
  NSLog(@"sending request");
  
//  NSString *badge = [PPUser genRandStringLength:8];
  NSString *badge = tagID;
  
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
    
    if ([self firstUserIsLoggedIn]) {
      // log in second player
      NSLog(@"logging in second user");
      [self.matchController secondPlayerDidBadgeIn:user];
      
      [self setFirstUserIsLoggedIn:NO];
    } else {
      // log in first player
      
      NSLog(@"logging in first user");
      // load modal
      [self.homeViewController.selectedViewController presentModalViewController:self.matchController animated:YES];
      [self.matchController firstPlayerDidBadgeIn:user];
      
      // wait for second user
      [self setFirstUserIsLoggedIn:YES];
    }
    self.processing = NO;
    
  } failure:^(RKObjectRequestOperation *operation, NSError *error) {
    NSLog(@"Error loading user");
    UIAlertView *alert2 = [[UIAlertView alloc] initWithTitle:@"ERROR" message:@"ERROR APP DELEGATE" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
    [alert2 show];
    self.processing = NO;
  }];
  
  [objectManager enqueueObjectRequestOperation:objectRequestOperation];
  
}

- (void)didReceiveRFIDTagId:(NSString *)tagID {
  //UIAlertView *alert2 = [[UIAlertView alloc] initWithTitle:@"app delegate" message:[NSString stringWithFormat:@"app delegate with token: %@", tagID] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
  //[alert2 show];
  // Hopefully this runs when the card is scanned...
  if (!self.processing) {
    self.processing = YES;
    //UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"IT WORKS." message:[NSString stringWithFormat:@"SENDING REQUEST: %@", tagID] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
    //[alert show];
    
    [self sendRequest:tagID];
  }
  // Add handling for view controller here.
}

- (void)kegboard:(KBKegboard *)kegboard didReceiveAuthToken:(KBKegboardMessageAuthToken *)message {
//  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"made it to app delegate." message:[NSString stringWithFormat:@"STATUS: %c", [message status]] delegate:self cancelButtonTitle:@"Cancel BRO" otherButtonTitles:nil, nil];
//  [alert show];
  // Only send a message when the card becomes present
  if ([message status]) [self didReceiveRFIDTagId:[message token]];
}

- (void)testDidReceiveRFIDTagId:(NSString *)tagId {
  PPUser *user = [self.homeViewController.userEditViewController loginWithTagId:tagId];
  if (!user) {
//    [self logout];
    [[NSNotificationCenter defaultCenter] postNotificationName:PPUnknownTagIdNotification object:tagId];
  }
}

- (void)start:(PPUserEditViewController *)controller {
  KBKegBoard *keg = [[KBKegboard alloc] initWithDelegate:self];

}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  self.window = [[PPUIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  
  RKLogConfigureByName("RestKit/Network*", RKLogLevelTrace);
  RKLogConfigureByName("RestKit/ObjectMapping", RKLogLevelTrace);
  
  [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
  
//  NSURL *localURL = [NSURL URLWithString:@"http://10.254.50.36:5000/"];
  NSURL *localURL = [NSURL URLWithString:@"http://poundpong.herokuapp.com/"];
  AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:localURL];
  
  [client setDefaultHeader:@"Accept" value:RKMIMETypeJSON];
  
  RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:client];
  objectManager.requestSerializationMIMEType = RKMIMETypeJSON;

  [RKObjectManager setSharedManager:objectManager];
  
  [self setProcessing:NO];
  [self setFirstUserIsLoggedIn:NO];

  if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
    self.homeViewController = [[PPHomeViewController alloc] init];
  } else {
    self.homeViewController = [[PPHomeViewController alloc] init];
  }
  
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_unknownTagId:) name:PPUnknownTagIdNotification object:nil];

  PPUserEditViewController *userEditViewController = [[PPUserEditViewController alloc] init];
  PPUserEditNavigationController *userEditNavigationController = [[PPUserEditNavigationController alloc] initWithRootViewController:userEditViewController];
  
	PPLeaderboardViewController *leaderBoardViewController = [[PPLeaderboardViewController alloc] init];
	UITabBarItem *leaderBoardTab = [[UITabBarItem alloc] initWithTitle:@"Alton Leaderboard" image:nil tag:1];
	[leaderBoardViewController setTabBarItem:leaderBoardTab];
	
	PPRecentMatchViewController *recentMatchViewController = [[PPRecentMatchViewController alloc] init];
	PPRecentMatchNavController *recentMatchNavController = [[PPRecentMatchNavController alloc] initWithRootViewController:recentMatchViewController];
	
  DebugViewController *debugViewController = [[DebugViewController alloc] init];
  DebugNavigationController *debugNavigationController = [[DebugNavigationController alloc] initWithRootViewController:debugViewController];
	debugViewController.appDelegate = self;
  	
  [self registerTagId:@"test"];
  
  NSLog(@"Loaded home view controller");
  
  PPSetupMatchViewController *setupMatchController = [[PPSetupMatchViewController alloc] init];
  setupMatchController.modalPresentationStyle = UIModalPresentationFormSheet;
  [self setMatchController:setupMatchController];
  
  [self.homeViewController setViewControllers:@[recentMatchNavController, leaderBoardViewController, userEditNavigationController, debugNavigationController]];
  [self.homeViewController setUserEditViewController:userEditViewController];
		
  self.window.rootViewController = self.homeViewController;
  [self.window makeKeyAndVisible];
//  [self.window.rootViewController presentModalViewController:userEditNavigationController animated:YES];

//  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Welcome!" message:@"Scan your Yelp ID" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
  
//  [alert show];
  
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
