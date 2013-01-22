//
//  DruaplNiPhoneDemoAppDelegate.h
//  DruaplNiPhoneDemo
//
//  Created by Peter Harrington on 1/21/10.
//  Copyright Clean Micro, LLC 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DruaplNiPhoneDemoViewController;

@interface DruaplNiPhoneDemoAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    DruaplNiPhoneDemoViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet DruaplNiPhoneDemoViewController *viewController;

@end

