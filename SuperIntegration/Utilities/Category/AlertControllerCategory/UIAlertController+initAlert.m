//
//  UIAlertController+initAlert.m
//  SuperIntegration
//
//  Created by PP－mac001 on 16/1/19.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "UIAlertController+initAlert.h"

@implementation UIAlertController (initAlert)

- (instancetype)initAlertWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle antionTitle:(NSString *)actionTitle actionStyle:(UIAlertActionStyle)actionStyle actionHandle:(void (^)())actionHandle otherActionTitle:(NSString *)otherActiontitle otherActionStyle:(UIAlertActionStyle)otherActionStyle otherActionHandle:(void (^)())otherActionHandle {
    
    self = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:preferredStyle];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:actionTitle style:actionStyle handler:^(UIAlertAction * _Nonnull action) {
        actionHandle();
    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        otherActionHandle();
    }];
    [self addAction:cancelAction];
    [self addAction:okAction];
    
    return self;
}
- (void)alertShowForViewController:(UIViewController *)viewController completion:(void (^)())completion {
    [viewController presentViewController:self animated:YES completion:^{
        completion();
    }];
}

@end
