//
//  MineHeaderCollectionReusableView.m
//  SuperIntegration
//
//  Created by PP－mac001 on 16/1/15.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#define ButtonImageInsets               SCREEN_WIDTH * 700 / (375 * 2)
#define ButtonTitleInsets               SCREEN_WIDTH * 460 / (375 * 2)
#import "MineHeaderCollectionReusableView.h"

@interface MineHeaderCollectionReusableView()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *lookAllOrderButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *BackViewToReusableViewHeightLayoutConstraint;
@end

@implementation MineHeaderCollectionReusableView

- (void)awakeFromNib {
    [self.BackViewToReusableViewHeightLayoutConstraint setConstant:BackViewHeight];
    [self.lookAllOrderButton setImageEdgeInsets:UIEdgeInsetsMake(0, ButtonImageInsets, 0, 0)];
    if (iPhone5) {
        [self.lookAllOrderButton setTitleEdgeInsets:UIEdgeInsetsMake(0, ButtonTitleInsets, 0, 0)];
    }
    if (iPhone6P) {
        [self.lookAllOrderButton setTitleEdgeInsets:UIEdgeInsetsMake(0, SCREEN_WIDTH * 500 / (375 * 2), 0, 0)];
    }
}

- (void)headerViewWithIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        self.titleLabel.text = @"我的订单";
        self.lookAllOrderButton.hidden = NO;
    }
    if (indexPath.section == 2) {
        self.titleLabel.text = @"我的积分";
        self.lookAllOrderButton.hidden = YES;
    }
}

- (IBAction)lookAllOrderClicked:(id)sender {
    self.buttonClicked();
}
@end
