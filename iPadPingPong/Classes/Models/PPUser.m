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
   @"badge" : @"badge",
   @"name" : @"name",
   @"confidence" : @"confidence",
   @"skill" : @"skill",
   @"updated" : @"updated",
   }];
  return userMapping;
}

+ (RKResponseDescriptor *)userResponseDescriptor {
  RKResponseDescriptor *descriptor = [RKResponseDescriptor responseDescriptorWithMapping:self.mapping pathPattern:nil keyPath:@"player" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
  return descriptor;
}

+ (RKResponseDescriptor *)usersResponseDescriptor {
  RKResponseDescriptor *descriptor = [RKResponseDescriptor responseDescriptorWithMapping:self.mapping pathPattern:nil keyPath:@"users" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
  return descriptor;
}

NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

+ (NSString *) genRandStringLength:(int)len {
  
  NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
  
  for (int i=0; i<len; i++) {
    [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random() % [letters length]]];
  }
  
  return randomString;
}

@end
