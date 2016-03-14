//
//  UserModel.h
//  SuperIntegration
//
//  Created by tmp on 16/2/18.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject
//错误信息
@property (nonatomic, copy) NSString *errmsg;
//设置支付密码
@property (nonatomic, assign) BOOL payPasswordStatus;
//昵称
@property (nonatomic, copy) NSString *nickname;
//真实姓名
@property (nonatomic, copy) NSString *realname;
//邮箱地址
@property (nonatomic, copy) NSString *email;
//手机号
@property (nonatomic, copy) NSString *telephone;
//错误代码
@property (nonatomic, assign) NSInteger errno1;
//性别
@property (nonatomic, assign) NSInteger sex;
//邮箱是否验证
@property (nonatomic, assign) BOOL emailStatus;

@end
