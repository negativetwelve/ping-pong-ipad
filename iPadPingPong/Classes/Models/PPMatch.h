//
//  PPMatch.h
//  iPadPingPong
//
//  Created by Mark Miyashita on 7/25/13.
//  Copyright (c) 2013 Mark Miyashita. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>

@class PPUser;

@interface PPMatch : NSObject

@property (nonatomic, retain) PPUser *winner;
@property (nonatomic, retain) PPUser *loser;
@property (nonatomic, copy) NSDate *timeStamp;
@property (nonatomic, copy) NSNumber *pointsExchanged;

+ (RKObjectMapping *)mapping;
+ (RKResponseDescriptor *)getMatchResponseDescriptor;
+ (RKResponseDescriptor *)postMatchResponseDescriptor;
+ (RKResponseDescriptor *)getMatchesResponseDescriptor;

@end
