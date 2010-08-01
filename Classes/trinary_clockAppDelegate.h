//
//  trinary_clockAppDelegate.h
//  trinary-clock
//
//  Created by Christoph Thelen on 01.08.10.
//  Copyright Christoph Thelen 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface trinary_clockAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    RootViewController *rootViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet RootViewController *rootViewController;

@end

