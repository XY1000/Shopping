//
//  UIAlertController+initAlert.h
//  SuperIntegration
//
//  Created by PP－mac001 on 16/1/19.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (initAlert)

- (instancetype)initAlertWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle antionTitle:(NSString *)actionTitle actionStyle:(UIAlertActionStyle)actionStyle actionHandle:(void(^)())actionHandle otherActionTitle:(NSString *)otherActiontitle otherActionStyle:(UIAlertActionStyle)otherActionStyle otherActionHandle:(void(^)())otherActionHandle;
- (void)alertShowForViewController:(UIViewController *)viewController completion:(void(^)())completion;
@end
