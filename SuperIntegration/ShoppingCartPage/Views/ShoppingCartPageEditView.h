//
//  ShoppingCartPageEditView.h
//  SuperIntegration
//
//  Created by PP－mac001 on 16/2/1.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShoppingCartPageEditView : UIView

@property (weak, nonatomic) IBOutlet UIButton *allButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

@property (copy, nonatomic) void(^deleteClickedBlock)();
@property (copy, nonatomic) void(^allSelectedClickedBlock)(BOOL isAllSelect);
@end
