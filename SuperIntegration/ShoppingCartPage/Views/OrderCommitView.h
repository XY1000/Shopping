//
//  OrderCommitView.h
//  SuperIntegration
//
//  Created by PP－mac001 on 16/2/23.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderCommitView : UIView

@property (weak, nonatomic) IBOutlet UIButton *btn_commitOrder;
@property (weak, nonatomic) IBOutlet UILabel *allPriceLabel;
@property (copy, nonatomic) void(^commitClickedBlock)();

@end
