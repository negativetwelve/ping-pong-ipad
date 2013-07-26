//
//  PPMatch.m
//  iPadPingPong
//
//  Created by Mark Miyashita on 7/25/13.
//  Copyright (c) 2013 Mark Miyashita. All rights reserved.
//

#import "PPMatch.h"

@implementation PPMatch

+ (RKObjectMapping *)mapping {
  RKObjectMapping *matchMapping = [RKObjectMapping mappingForClass:[self class]];
  [matchMapping addAttributeMappingsFromDictionary:@{
   @"timestamp" : @"timeStamp",
   @"points_exchanged" : @"pointsExchanged"}];
  
  [matchMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"winner" toKeyPath:@"winner" withMapping:PPUser.mapping]];
  [matchMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"loser" toKeyPath:@"loser" withMapping:PPUser.mapping]];
  
  return matchMapping;
}

+ (RKResponseDescriptor *)getMatchResponseDescriptor {
  RKResponseDescriptor *descriptor = [RKResponseDescriptor responseDescriptorWithMapping:self.mapping method:RKRequestMethodGET pathPattern:nil keyPath:@"match" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
  return descriptor;
}

+ (RKResponseDescriptor *)postMatchResponseDescriptor {
  RKResponseDescriptor *descriptor = [RKResponseDescriptor responseDescriptorWithMapping:self.mapping method:RKRequestMethodPOST pathPattern:nil keyPath:@"match" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
  return descriptor;
}

+ (RKResponseDescriptor *)getMatchesResponseDescriptor {
  RKResponseDescriptor *descriptor = [RKResponseDescriptor responseDescriptorWithMapping:self.mapping method:RKRequestMethodGET pathPattern:nil keyPath:@"matches" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
  return descriptor;
}

@end
