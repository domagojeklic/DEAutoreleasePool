//
//  DEObject.m
//  DEAutoreleasePool
//
//  Created by Domagoj Eklic on 9/24/18.
//  Copyright © 2018 Domagoj Eklic. All rights reserved.
//

#import "DEObject.h"
#import "NSObject+DEAutorelease.h"

NS_ASSUME_NONNULL_BEGIN

@implementation DEObject {
    NSString *_identifier;
}

+ (instancetype)createWithIdentifier:(NSString *)identifier {
    DEObject *object = [[DEObject alloc] initWithIdentifier:identifier];
    [object deautorelease];

    return object;
}

- (instancetype)initWithIdentifier:(NSString *)identifier {
    self = [super init];
    if (self) {
        NSLog(@"DEObject %@ created", identifier);
        _identifier = identifier;
        [_identifier retain];
    }

    return self;
}

- (void)dealloc {
    [_identifier release];

    [super dealloc];

    NSLog(@"DEObject %@ deallocated", _identifier);
}

- (NSString *)description {
    return _identifier;
}

@end

NS_ASSUME_NONNULL_END
