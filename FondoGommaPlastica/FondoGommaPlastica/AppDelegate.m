//
//  AppDelegate.m
//  FondoGommaPlastica
//
//  Created by Felice Vimercati on 26/05/16.
//  Copyright © 2016 ElpoEdizioni. All rights reserved.
//

#import "AppDelegate.h"
#import "Fondimatica/Configurations.h"
#import "SpazioAderenteViewController.h"
#import "BenvenutoViewController.h"
#import "RootViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [Configurations sharedConfiguration];
#ifndef DEBUG
    [NSThread sleepForTimeInterval:3];
#endif
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

@end
