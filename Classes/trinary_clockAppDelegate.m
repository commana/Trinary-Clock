//
//  trinary_clockAppDelegate.m
//  trinary-clock
//
//  Created by Christoph Thelen on 01.08.10.
//  Copyright Christoph Thelen 2010. All rights reserved.
//

#import "trinary_clockAppDelegate.h"
#import "RootViewController.h"

@implementation trinary_clockAppDelegate


@synthesize window;
@synthesize rootViewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {
    
    [window addSubview:[rootViewController view]];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [rootViewController release];
    [window release];
    [super dealloc];
}

@end
