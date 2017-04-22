//
//  AppDelegate.m
//  NBA
//
//  Created by zdx on 2017/3/6.
//  Copyright © 2017年 zdx. All rights reserved.
//

#import "AppDelegate.h"
#import "matchViewController.h"
#import "personViewController.h"
#import "betterDataViewController.h"
#import "UIImage+originalImage.h"
#import "comnous.h"
#import "navigationViewController.h"
#import "ZDXTabBarViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    
    self.window.rootViewController = [[ZDXTabBarViewController alloc] init];
//    ZDXTabBarViewController *tabBarController = [[ZDXTabBarViewController alloc] init];
//    [tabBarController.view setBackgroundColor:[UIColor whiteColor]];
//    [self.window setRootViewController:tabBarController];
//    
//    matchViewController *firstVC = [[matchViewController alloc] init];
////    firstVC.tabBarItem.title = @"比赛";
////    firstVC.tabBarItem.image = [UIImage originalImageName:@"icon2"];
////    firstVC.tabBarItem.selectedImage = [UIImage originalImageName:@"icon2-1"];
//    UINavigationController *navFirst = [[UINavigationController alloc] initWithRootViewController:firstVC];
//    
//    personViewController *personVC = [[personViewController alloc] init];
////    personVC.tabBarItem.title = @"更多";
////    personVC.tabBarItem.image = [UIImage originalImageName:@"icon3"];
////    personVC.tabBarItem.selectedImage = [UIImage originalImageName:@"icon3-1"];
//    UINavigationController *navthird = [[UINavigationController alloc] initWithRootViewController:personVC
//    ];
//    
//    betterDataViewController *dataVC = [[betterDataViewController alloc] init];
////    dataVC.tabBarItem.title = @"数据";
////    dataVC.tabBarItem.image = [UIImage originalImageName:@"icon3"];
////    dataVC.tabBarItem.selectedImage = [UIImage originalImageName:@"icon3-1"];
//    UINavigationController *navSecond = [[UINavigationController alloc] initWithRootViewController:dataVC
//                                         ];
    [[UINavigationBar appearance] setBarTintColor:ZDXColor(13, 59, 111)];
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor whiteColor], NSForegroundColorAttributeName, [UIFont fontWithName:@"Helvetica-Bold" size:18], NSFontAttributeName, nil]];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    
//    //tabbarItem全局设置
//    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:13]} forState:UIControlStateNormal];
    
    return YES;
}









- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
