//
//  DEObject.h
//  DEAutoreleasePool
//
//  Created by Domagoj Eklic on 9/24/18.
//  Copyright © 2018 Domagoj Eklic. All rights reserved.
//

NS_ASSUME_NONNULL_BEGIN

@interface DEObject : NSObject

+ (instancetype)createWithIdentifier:(NSString *)identifier;
- (instancetype)initWithIdentifier:(NSString *)identifier NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
