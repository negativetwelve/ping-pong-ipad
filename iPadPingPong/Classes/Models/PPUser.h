//
//  PPUser.h
//  iPadPingPong
//
//  Created by Mark Miyashita on 7/25/13.
//  Copyright (c) 2013 Mark Miyashita. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>

@interface PPUser : NSObject

@property (nonatomic, copy) NSNumber *userId;
@property (nonatomic, copy) NSString *badgeId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSNumber *skillLevel;

+ (RKObjectMapping *)mapping;
+ (RKResponseDescriptor *)usersResponseDescriptor;
+ (RKResponseDescriptor *)userResponseDescriptor;

@end
