//
//  OrderAllListFooterCollectionReusableView.m
//  SuperIntegration
//
//  Created by PP－mac001 on 16/2/26.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "OrderAllListFooterCollectionReusableView.h"
#import "OrderModel.h"
@interface OrderAllListFooterCollectionReusableView()

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UIButton *againButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewHeightLayoutConstraint;

@end

@implementation OrderAllListFooterCollectionReusableView

- (void)awakeFromNib {
    [self.viewHeightLayoutConstraint setConstant:OrderAllList_HeaderViewHeight];
}

- (void)viewWithModel:(OrderModel *)model {
    self.priceLabel.text = [NSString stringWithFormat:@"%ld",(long)model.orderAmount];
    if ([model.status isEqualToString:@"订单已完成"]) {
        self.deleteButton.hidden = NO;
        self.againButton.hidden = NO;
    } else {
        self.deleteButton.hidden = YES;
        self.againButton.hidden = YES;
    }
}

- (IBAction)deleteClicked:(id)sender {
}
- (IBAction)againClicked:(id)sender {
}

@end
