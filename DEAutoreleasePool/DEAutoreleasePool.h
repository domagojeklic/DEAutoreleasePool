//
//  DEAutoreleasePool.h
//  DEAutoreleasePool
//
//  Created by Domagoj Eklic on 9/24/18.
//  Copyright © 2018 Domagoj Eklic. All rights reserved.
//

NS_ASSUME_NONNULL_BEGIN

@interface DEAutoreleasePool : NSObject

/**
 The identifier is used for demonstration purposes only
 */
- (instancetype)initWithIdentifier:(NSString *)identifier;
- (instancetype)init NS_UNAVAILABLE;

+ (void)addObject:(id)object;
- (void)drain;

@end

NS_ASSUME_NONNULL_END
