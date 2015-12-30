//
//  AppDelegate.m
//  NZHSwipeNavigationPageController
//
//  Created by iiyumewo on 15/12/25.
//  Copyright © 2015年 iiyumewo. All rights reserved.
//

#import "AppDelegate.h"
#import "NZHSwipeNavigationPageController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    UIViewController *demo1 = [[UIViewController alloc]init];
    UIViewController *demo2 = [[UIViewController alloc]init];
    UIViewController *demo3 = [[UIViewController alloc]init];
    UIViewController *demo4 = [[UIViewController alloc]init];
    UIViewController *demo5 = [[UIViewController alloc]init];
    demo1.view.backgroundColor = [UIColor redColor];
    demo2.view.backgroundColor = [UIColor blueColor];
    demo3.view.backgroundColor = [UIColor grayColor];
    demo4.view.backgroundColor = [UIColor purpleColor];
    demo5.view.backgroundColor = [UIColor orangeColor];
    
    NSArray *viewControllerArray = @[demo1, demo2, demo3, demo4, demo5];
    NSArray *buttonTextArray = @[@"首页", @"基金", @"主题", @"行业", @"市场"];
    
    NZHSwipeNavigationPageController *swipeSingleController = [[NZHSwipeNavigationPageController alloc]initForBarUnderNavigationWithTitle:@"决策" andButtonTitles:buttonTextArray barHeight:40 buttonWidth:50 controllers:viewControllerArray];
    
    //    NZHSwipeNavigationPageController *swipeSingleController = [[NZHSwipeNavigationPageController alloc]initForSwipeByNavigationBarWithSubTitles:buttonTextArray andControllers:viewControllerArray andButtonWidth:50];
    //    swipeSingleController.animationView.backgroundColor = [UIColor redColor];
    
    UIView *animationView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 25)];
    animationView.backgroundColor = [UIColor redColor];
    animationView.layer.cornerRadius = 6.0;
    animationView.layer.opacity = 0.3;
    
    
    //    [swipeSingleController setFlatAnimationalSelector:animationView];
//    [swipeSingleController setMiddleAnimationalSelector:animationView];

    
    
//    __block NZHSwipeNavigationPageController *blockDemo = swipeSingleController;
//    swipeSingleController.customAnimationBlock = ^(UIScrollView *pageScrollView) {
//        CGFloat originSelectorHeight = 25;
//        CGFloat changedSelectorHeight;
//        if (blockDemo.positionRatio <= 0.5) {
//            changedSelectorHeight = originSelectorHeight*(1-blockDemo.positionRatio);
//        }else if (blockDemo.positionRatio > 0.5) {
//            changedSelectorHeight = originSelectorHeight*blockDemo.positionRatio;
//        }
//        CGRect rect = CGRectMake(blockDemo.selectorX, blockDemo.selectorY, blockDemo.animationView.frame.size.width, changedSelectorHeight);
//        blockDemo.animationView.frame = rect;
//    };
    
    
    
    
    
    self.window.rootViewController = swipeSingleController.swipeNavigationController;
    [self.window makeKeyAndVisible];
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
