//
//  DEAutoreleasePool.m
//  DEAutoreleasePool
//
//  Created by Domagoj Eklic on 9/24/18.
//  Copyright © 2018 Domagoj Eklic. All rights reserved.
//

#import "DEAutoreleasePool.h"

NS_ASSUME_NONNULL_BEGIN

static NSString * const DEThreadAutoreleasePoolStackKey = @"DEThreadAutoreleasePoolStackKey";

@implementation DEAutoreleasePool {
    NSString *_identifier;
    CFMutableArrayRef _objects;
}

- (instancetype)initWithIdentifier:(NSString *)identifier {
    self = [super init];
    if (self) {
        NSLog(@"DEAutoreleasePool %@ created", identifier);

        _identifier = [identifier retain];

        _objects = CFArrayCreateMutable(NULL, 0, NULL);

        // Push newly created pool on top of the current thread pool stack
        CFMutableArrayRef stack = [DEAutoreleasePool threadPoolStack];
        CFArrayAppendValue(stack, (__bridge const void *)(self));
    }

    return self;
}

- (void)dealloc {
    [_identifier release];

    [self drain];
    CFRelease(_objects);

    CFMutableArrayRef stack = [DEAutoreleasePool threadPoolStack];
    CFIndex stackCount = CFArrayGetCount(stack);

    CFIndex index = stackCount - 1;
    while (index > 0) {
        DEAutoreleasePool *pool = CFArrayGetValueAtIndex(stack, index);
        if (pool == self) {
            CFArrayRemoveValueAtIndex(stack, index);
        } else {
            [pool release];
        }

        index--;
    }

    [super dealloc];

    NSLog(@"DEAutoreleasePool %@ deallocated", _identifier);
}

+ (CFMutableArrayRef)threadPoolStack {
    NSMutableDictionary *threadDictionary = [[NSThread currentThread] threadDictionary];

    CFMutableArrayRef stack = (__bridge CFMutableArrayRef)[threadDictionary objectForKey:DEThreadAutoreleasePoolStackKey];
    if (!stack) {
        stack = CFArrayCreateMutable(NULL, 0, NULL);
        [threadDictionary setObject:(__bridge id)stack forKey:DEThreadAutoreleasePoolStackKey];
        CFRelease(stack);
    }

    return stack;
}

- (void)addObject:(id)object {
    NSLog(@"Object %@ added to the pool %@", object, _identifier);
    
    CFArrayAppendValue(_objects, (__bridge const void *)(object));
}

#pragma mark - Public methods

+ (void)addObject:(id)object {
    CFMutableArrayRef stack = [DEAutoreleasePool threadPoolStack];
    CFIndex stackCount = CFArrayGetCount(stack);

    if (stackCount == 0) {
        @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"Empty AutoreleasePool stack for current thread" userInfo:nil];
    }

    DEAutoreleasePool *autoreleasePool = CFArrayGetValueAtIndex(stack, stackCount - 1);
    [autoreleasePool addObject:object];
}

- (void)drain {
    CFIndex objectsCount = CFArrayGetCount(_objects);

    for (CFIndex index = 0; index < objectsCount; index++) {
        id object = CFArrayGetValueAtIndex(_objects, index);
        [object release];
    }

    CFArrayRemoveAllValues(_objects);
}

@end

NS_ASSUME_NONNULL_END
