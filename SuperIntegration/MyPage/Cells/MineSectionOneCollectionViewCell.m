//
//  MineSectionOneCollectionViewCell.m
//  SuperIntegration
//
//  Created by PP－mac001 on 16/1/15.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "MineSectionOneCollectionViewCell.h"

@interface MineSectionOneCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewHeightLayoutConstraint;

@end

@implementation MineSectionOneCollectionViewCell

- (void)awakeFromNib {
    CGFloat imageHeight = ClassificationHeight / 2;
    [self.imageViewHeightLayoutConstraint setConstant:imageHeight];
}

- (void)cellWithImageStr:(NSString *)imageStr Title:(NSString *)title {
    self.imageView.image = [UIImage imageNamed:imageStr];
    self.titleLabel.text = title;
}

@end
