//
//  PPUser.m
//  iPadPingPong
//
//  Created by Mark Miyashita on 7/25/13.
//  Copyright (c) 2013 Mark Miyashita. All rights reserved.
//

#import "PPUser.h"

@implementation PPUser

+ (RKObjectMapping *)mapping {
  RKObjectMapping *userMapping = [RKObjectMapping mappingForClass:[self class]];
  [userMapping addAttributeMappingsFromDictionary:@{
   @"user_id" : @"userId",
   @"badge_id" : @"badgeId",
   @"name" : @"name",
   @"skill_level" : @"skillLevel",
   }];
  return userMapping;
}

+ (RKResponseDescriptor *)userResponseDescriptor {
  RKResponseDescriptor *descriptor = [RKResponseDescriptor responseDescriptorWithMapping:self.mapping pathPattern:nil keyPath:@"user" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
  return descriptor;
}

+ (RKResponseDescriptor *)usersResponseDescriptor {
  RKResponseDescriptor *descriptor = [RKResponseDescriptor responseDescriptorWithMapping:self.mapping pathPattern:nil keyPath:@"users" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
  return descriptor;
}

@end
