//
//  DruaplNiPhoneDemoAppDelegate.m
//  DruaplNiPhoneDemo
//
//  Created by Peter Harrington on 1/21/10.
//  Copyright Clean Micro, LLC 2010. All rights reserved.
//

#import "DruaplNiPhoneDemoAppDelegate.h"
#import "DruaplNiPhoneDemoViewController.h"

@implementation DruaplNiPhoneDemoAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
