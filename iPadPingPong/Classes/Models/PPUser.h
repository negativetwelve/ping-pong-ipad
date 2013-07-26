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

@property (nonatomic, copy) NSString *badge;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *confidence;
@property (nonatomic, copy) NSNumber *skill;
@property (nonatomic, copy) NSNumber *updated;

+ (RKObjectMapping *)mapping;
+ (RKResponseDescriptor *)usersResponseDescriptor;
+ (RKResponseDescriptor *)userResponseDescriptor;
+ (NSString *) genRandStringLength: (int) len;

@end
