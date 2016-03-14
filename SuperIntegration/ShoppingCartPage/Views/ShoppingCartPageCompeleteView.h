//
//  ShoppingCartPageCompeleteView.h
//  SuperIntegration
//
//  Created by PP－mac001 on 16/2/1.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ShoppingCartPageModel;
@interface ShoppingCartPageCompeleteView : UIView
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UIButton *allButton;
@property (weak, nonatomic) IBOutlet UIButton *completeButton;
- (void)completeViewContentWithArray:(NSArray *)array;

@property (copy, nonatomic) void(^allSelectedClickedBlock)(BOOL isAllSelect);
//去结算
@property (copy, nonatomic) void(^completedBlock)();

@end
