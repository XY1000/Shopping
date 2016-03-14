//
//  HXYTool.h
//  SuperIntegration
//
//  Created by tmp on 16/1/29.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXYTool : NSObject

//用户的登陆状态
+ (void)userNotLogin:(_Nonnull id)user  login:(void(^)())login;

@end
