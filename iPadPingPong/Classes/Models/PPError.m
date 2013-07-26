//
//  PPError.m
//  iPadPingPong
//
//  Created by Mark Miyashita on 7/26/13.
//  Copyright (c) 2013 Mark Miyashita. All rights reserved.
//

#import "PPError.h"

@implementation PPError

+ (RKObjectMapping *)mapping {
  RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[self class]];
  [mapping addAttributeMappingsFromDictionary:@{

   }];
  return mapping;
}

+ (RKResponseDescriptor *)responseDescriptor {
  RKResponseDescriptor *descriptor = [RKResponseDescriptor responseDescriptorWithMapping:self.mapping pathPattern:nil keyPath:@"error" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassClientError)];
  return descriptor;
}

@end
