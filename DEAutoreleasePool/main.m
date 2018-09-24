//
//  main.m
//  DEAutoreleasePool
//
//  Created by Domagoj Eklic on 9/24/18.
//  Copyright © 2018 Domagoj Eklic. All rights reserved.
//

#import "DEObject.h"
#import "DEAutoreleasePool.h"

void inner() {
    DEAutoreleasePool *pool = [[DEAutoreleasePool alloc] initWithIdentifier:@"Inner"];

    DEObject *object = [DEObject createWithIdentifier:@"Inner-001"];

    NSLog(@"Description: %@", object);

    [pool release];
}

int main(int argc, const char * argv[]) {
    int i = 0;

    DEAutoreleasePool *pool = [[DEAutoreleasePool alloc] initWithIdentifier:@"Outer"];

    // Demonstrates the main loop
    while (i < 3)
    {
        DEObject *object = [DEObject createWithIdentifier:[NSString stringWithFormat:@"Outer-%03d", i]];
        NSLog(@"Descrition: %@", object);
        i++;

        // Demonstrates autorelease pool nesting
        inner();

        [pool drain];
    }
    
    return 0;
}
