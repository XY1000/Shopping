//
//  ProductDetailPageTwoCollectionViewCell.m
//  SuperIntegration
//
//  Created by PP－mac001 on 16/2/19.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "ProductDetailPageTwoCollectionViewCell.h"
#import "ProductDetailPageModel.h"

@interface ProductDetailPageTwoCollectionViewCell()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelToBorderLeftLayoutConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelToLabelLeftLayoutConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageToBorderRightLayoutConstraint;

@property (weak, nonatomic) IBOutlet UILabel *leftLabel;

@property (weak, nonatomic) IBOutlet UIImageView *image;

@end

@implementation ProductDetailPageTwoCollectionViewCell

- (void)awakeFromNib {
    [self.labelToBorderLeftLayoutConstraint setConstant:ProductDetailPage_LeftOrRightBorderDistance];
    [self.labelToLabelLeftLayoutConstraint setConstant:ProductDetailPage_LeftLabelDistance];
    [self.imageToBorderRightLayoutConstraint setConstant:ProductDetailPage_LeftOrRightBorderDistance];
}

- (void)cellWithModel:(ProductDetailPageModel *)model andIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item == 1) {
        self.leftLabel.text = @"送至";
        self.rightLabel.text = @"北京 北京市 朝阳区 ";
    }
    if (indexPath.item == 2) {
        self.leftLabel.text = @"已选";
        self.rightLabel.text = [NSString stringWithFormat:@"卡其色 均码 1%@",model.saleUnit];
    }
}

@end
