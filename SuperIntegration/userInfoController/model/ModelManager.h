//
//  ModelManager.h
//  SuperIntegration
//
//  Created by tmp on 16/2/18.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"

@interface ModelManager : NSObject

//获取用户
+ (UserModel * _Nonnull)getUserModel;

//存储用户信息
+ (void)saveUserInfoWithDic:( NSDictionary * _Nonnull )dic;

@end
