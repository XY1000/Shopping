//
//  OrderPayPasswordView.h
//  SuperIntegration
//
//  Created by PP－mac001 on 16/2/23.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderPayPasswordView : UIView
- (void)drawView;
@property (nonatomic,copy) void (^completeHandle)(NSString *inputPwd);
@property (nonatomic, strong) UITextField *pwdTextField;
- (void)setDotWithCount:(NSInteger)count;
@end
