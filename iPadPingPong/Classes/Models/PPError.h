//
//  PPError.h
//  iPadPingPong
//
//  Created by Mark Miyashita on 7/26/13.
//  Copyright (c) 2013 Mark Miyashita. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>

@interface PPError : NSObject


+ (RKObjectMapping *)mapping;
+ (RKResponseDescriptor *)responseDescriptor;

@end
