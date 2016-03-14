//
//  OrderAllListHeaderCollectionReusableView.m
//  SuperIntegration
//
//  Created by PP－mac001 on 16/2/26.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "OrderAllListHeaderCollectionReusableView.h"
#import "OrderModel.h"
@interface OrderAllListHeaderCollectionReusableView()

@property (weak, nonatomic) IBOutlet UILabel *orderNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderStatusLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewHeightLayoutConstraint;


@end

@implementation OrderAllListHeaderCollectionReusableView

- (void)awakeFromNib {
    [self.viewHeightLayoutConstraint setConstant:OrderAllList_HeaderViewHeight];
}

- (void)viewWithModel:(OrderModel *)model {
    self.orderNumberLabel.text = [NSString stringWithFormat:@"%ld",(long)model.orderNumber];
    self.orderStatusLabel.text = model.status;
}

- (IBAction)goDetailButtonClicked:(id)sender {
    self.goDetailButtonClicked(self.orderNumberLabel.text, self.orderStatusLabel.text);
}
@end
