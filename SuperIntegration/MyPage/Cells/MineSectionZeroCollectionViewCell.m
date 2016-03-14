//
//  MineSectionZeroCollectionViewCell.m
//  SuperIntegration
//
//  Created by PP－mac001 on 16/1/15.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "MineSectionZeroCollectionViewCell.h"

@interface MineSectionZeroCollectionViewCell()


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomButtonHeightLayoutConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *footPrintLabelToTopLayoutConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *footPrintButtonWidthLayoutConstraint;

@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;
@property (weak, nonatomic) IBOutlet UIButton *footPrintButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UILabel *favoriteLabel;
@property (weak, nonatomic) IBOutlet UILabel *footPrintLabel;


@property (weak, nonatomic) IBOutlet UIImageView *userImageView;


@end

@implementation MineSectionZeroCollectionViewCell

- (void)awakeFromNib {
    [self.bottomButtonHeightLayoutConstraint setConstant:MineSectionZeroButtonHeight];
    [self.footPrintLabelToTopLayoutConstraint setConstant:MineSectionZeroLabelToTopValue];
    [self.footPrintButtonWidthLayoutConstraint setConstant:MineSectionZeroFootPrintButtonWidth];
    
    [self.favoriteButton setTitleEdgeInsets:UIEdgeInsetsMake(MineSectionZeroButtonTitleInsets, 0, 0, 0)];
    [self.footPrintButton setTitleEdgeInsets:UIEdgeInsetsMake(MineSectionZeroButtonTitleInsets, 0, 0, 0)];
    [self.shareButton setTitleEdgeInsets:UIEdgeInsetsMake(MineSectionZeroButtonTitleInsets, 0, 0, 0)];
    
    if ([GetObjectUserDefault(@"isLogin") boolValue]) {
        self.userNickname.text = GetObjectUserDefault(@"nickname");
    }
    
}

@end
