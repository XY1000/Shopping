//
//  AppDelegate.m
//  SuperIntegration
//
//  Created by PP－mac001 on 16/1/11.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "AppDelegate.h"
#import <IQKeyboardManager/IQKeyboardManager.h>//
@interface AppDelegate ()

@end

@implementation AppDelegate

NSString *const notiScreenTouch = @"notiScreenTouch";
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self.window setBackgroundColor:[UIColor colorWithRed:188/255.0 green:0/255.0 blue:32/255.0 alpha:1.0f]];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        
        IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
        manager.enable = YES;
        manager.shouldResignOnTouchOutside = YES;
        manager.enableAutoToolbar = NO;
    });
    

    //runtime点击事件截取
//    Method sendEvent =class_getInstanceMethod([UIWindow class],@selector(sendEvent:));
//    Method sendEventMySelf =class_getInstanceMethod([self class], @selector(sendEventHooked:));
//    IMP sendEventImp =method_getImplementation(sendEvent);
//    class_addMethod([UIWindow class],@selector(sendEventOriginal:), sendEventImp,method_getTypeEncoding(sendEvent));
//    IMP sendEventMySelfImp =method_getImplementation(sendEventMySelf);
//    class_replaceMethod([UIWindow class],@selector(sendEvent:), sendEventMySelfImp,method_getTypeEncoding(sendEvent));
    
    return YES;
}


//- (void)sendEventHooked:(UIEvent *)event {
//    
//    //在这里做你想做的事情吧
//    NSLog(@"截获事件:%@", [event description]);
//    
//    //执行原来的消息传递流程
//    [self performSelector:@selector(sendEventOriginal:)withObject:event];
//    
//}

//说明：当应用程序将要入非活动状态执行，在此期间，应用程序不接收消息或事件，比如来电话了</span>
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"endTimer" object:nil];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [[NSNotificationCenter defaultCenter] postNotificationName:@"endTimer" object:nil];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [[NSNotificationCenter defaultCenter] postNotificationName:@"startTimer" object:nil];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application{
    DLog(@"AppDelegate中调用applicationDidReceiveMemoryWarning:");
}
@end
