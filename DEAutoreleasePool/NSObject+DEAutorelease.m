//
//  NSObject+DEAutorelease.m
//  DEAutoreleasePool
//
//  Created by Domagoj Eklic on 9/24/18.
//  Copyright © 2018 Domagoj Eklic. All rights reserved.
//

#import "NSObject+DEAutorelease.h"

#import "DEAutoreleasePool.h"

NS_ASSUME_NONNULL_BEGIN

@implementation NSObject(DEAutorelease)

- (instancetype)deautorelease {
    [DEAutoreleasePool addObject:self];
    return self;
}

@end

NS_ASSUME_NONNULL_END
