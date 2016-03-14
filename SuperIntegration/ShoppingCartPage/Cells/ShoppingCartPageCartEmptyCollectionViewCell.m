//
//  ShoppingCartPageCartEmptyCollectionViewCell.m
//  SuperIntegration
//
//  Created by PP－mac001 on 16/1/29.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "ShoppingCartPageCartEmptyCollectionViewCell.h"

@interface ShoppingCartPageCartEmptyCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIView *loginButtonSuperView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelToImageToTopLayoutConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *goShoppingButtonToLabelToTopLayoutConstraint;

@end

@implementation ShoppingCartPageCartEmptyCollectionViewCell

- (void)awakeFromNib {
    [self.labelToImageToTopLayoutConstraint setConstant:ShoppingCartPageDefine_EmptyCellLabelValue];
    [self.goShoppingButtonToLabelToTopLayoutConstraint setConstant:ShoppingCartPageDefine_EmptyCellGoShoppingButtonValue];
}

- (void)isHiddenLoginButtonSuperView {
    //登录时去隐藏登录按钮
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isLogin"]) {
        [self.loginButtonSuperView setHidden:YES];
    } else {
        [self.loginButtonSuperView setHidden:NO];
    }
}

- (IBAction)loginClicked:(id)sender {
    self.loginClickedBlock();
}

- (IBAction)goShoppingClicked:(id)sender {
    self.goShoppingClickedBlock();
}



@end
