//
//  OrderDetailBottomView.m
//  SuperIntegration
//
//  Created by PP－mac001 on 16/2/29.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "OrderDetailBottomView.h"

@interface OrderDetailBottomView()

@property (weak, nonatomic) IBOutlet UIButton *deleteOrderButton;
@property (weak, nonatomic) IBOutlet UIButton *customerButton;
@property (weak, nonatomic) IBOutlet UIButton *againBuyButton;



@end

@implementation OrderDetailBottomView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib {
    self.deleteOrderButton.layer.borderColor = RGB(204, 10, 42).CGColor;
    self.deleteOrderButton.layer.borderWidth = 1;
    self.customerButton.layer.borderColor = RGB(204, 10, 42).CGColor;
    self.customerButton.layer.borderWidth = 1;
}

- (IBAction)deleteClicked:(id)sender {
    self.deleteOrderClickedBlock();
}
- (IBAction)serviceClicked:(id)sender {
    self.customerServiceClickedBlock();
}
- (IBAction)payClicked:(id)sender {
    self.againBuyClickedBlock();
}

@end
