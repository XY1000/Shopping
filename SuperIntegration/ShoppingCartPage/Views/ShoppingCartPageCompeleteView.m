//
//  ShoppingCartPageCompeleteView.m
//  SuperIntegration
//
//  Created by PP－mac001 on 16/2/1.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "ShoppingCartPageCompeleteView.h"
#import "ShoppingCartPageModel.h"

@interface ShoppingCartPageCompeleteView()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layout_ButtonWidth;

@end


@implementation ShoppingCartPageCompeleteView

- (void)awakeFromNib {
    [self.allButton setSelected:YES];
    self.layout_ButtonWidth.constant = SCREEN_WIDTH * 100 / 375;
}

- (void)completeViewContentWithArray:(NSArray *)array {
    
    if (array.count == 0) {
        self.completeButton.backgroundColor = [UIColor lightGrayColor];
        self.completeButton.userInteractionEnabled = NO;
    } else {
        self.completeButton.userInteractionEnabled = YES;
        self.completeButton.backgroundColor = RGB(204, 10, 42);
    }
    
    CGFloat totalPrice = 0;
    NSInteger totalAmount = 0;
    for (ShoppingCartPageModel *model in array) {
        totalPrice += (model.price.floatValue * model.amount);
        totalAmount += model.amount;
    }
    [self.totalLabel setText:[NSString stringWithFormat:@"%.2f分", totalPrice]];
    [self.completeButton setTitle:[NSString stringWithFormat:@"去结算"] forState:UIControlStateNormal];
}
- (IBAction)allClicked:(id)sender {
    if (self.allButton.selected) {
        [self.allButton setSelected:NO];
    } else {
        [self.allButton setSelected:YES];
    }
    self.allSelectedClickedBlock(self.allButton.selected);
}
- (IBAction)completeClicked:(id)sender {
    self.completedBlock();
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
