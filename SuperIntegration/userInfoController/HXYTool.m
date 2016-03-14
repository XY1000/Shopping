//
//  HXYTool.m
//  SuperIntegration
//
//  Created by tmp on 16/1/29.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "HXYTool.h"

@class LoginViewController;

@implementation HXYTool

+ (void)userNotLogin:(_Nonnull id)user login:(void (^)())login{
    
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"isLogin"]) {
        
       
            
            //[SVProgressHUD showErrorWithStatus:@"未登录"];
        
        
        
            
            UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            
            LoginViewController *vc = (LoginViewController *)[story instantiateViewControllerWithIdentifier:LoginController];
            
            UIViewController *cc = (UIViewController *)user;
            [cc.navigationController showViewController:vc sender:cc];
        
        
    }else{
        
        login();
    }
    
}
@end
