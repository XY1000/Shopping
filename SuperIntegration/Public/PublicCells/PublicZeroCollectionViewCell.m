//
//  PublicZeroCollectionViewCell.m
//  SuperIntegration
//
//  Created by PP－mac001 on 16/1/19.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "PublicZeroCollectionViewCell.h"
#import "SearchResultModel.h"
#import "OrderModel.h" 

@interface PublicZeroCollectionViewCell()<UIGestureRecognizerDelegate>

@property (weak, nonatomic)  UILabel *nameLabel;
@property (weak, nonatomic)  UILabel *priceLabel;
@property (weak, nonatomic)  UIImageView *imageView;

@end

@implementation PublicZeroCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _slipView = [[LeftSlipEditView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [self.contentView addSubview:_slipView];
        
        UIImageView *imageView_Image = [[UIImageView alloc] init];
        [_slipView.myContentView addSubview:imageView_Image];
        [imageView_Image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_slipView.myContentView).with.offset(15.0);
            make.top.equalTo(_slipView.myContentView).with.offset(10.0);
            make.bottom.equalTo(_slipView.myContentView).with.offset(-10.0);
            make.width.mas_equalTo(PublicZeroCellHeight - 20);
        }];
        self.imageView = imageView_Image;
        
        UILabel *label_NameLabel = [[UILabel alloc] init];
        label_NameLabel.textColor = RGB(51, 51, 51);
        label_NameLabel.font = [UIFont systemFontOfSize:15.0];
        label_NameLabel.numberOfLines = 2;
        [_slipView.myContentView addSubview:label_NameLabel];
        [label_NameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imageView_Image.mas_right).with.offset(13.0);
            make.right.equalTo(_slipView.myContentView).with.offset(-13.0);
            make.top.mas_equalTo(imageView_Image);
        }];
        self.nameLabel = label_NameLabel;
        
        UILabel *label_PriceLabel = [[UILabel alloc] init];
        label_PriceLabel.textColor = RGB(204, 10, 42);
        label_PriceLabel.font = [UIFont systemFontOfSize:27.0];
        [_slipView.myContentView addSubview:label_PriceLabel];
        [label_PriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(label_NameLabel);
            make.bottom.mas_equalTo(imageView_Image).with.offset(-PublicZeroCellLabelValue);
        }];
        self.priceLabel = label_PriceLabel;
    }
    return self;
}


- (void)cellWithModel:(SearchResultModel *)model {
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"place"]];
    self.nameLabel.text = model.name;
    if (model.amount.integerValue == 0) {
        self.priceLabel.text = @"该地区暂未销售";
    } else {
        self.priceLabel.text = model.amount;
    }
}

- (void)cellWithOrderModel:(OrderModelProductList *)model {
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"place"]];
    self.nameLabel.text = model.name;
    self.priceLabel.text = model.amount;
}

/**
 *  这个方法确保 Cell 在其回收重利用时再次关闭。
 */
- (void)prepareForReuse {
    [super prepareForReuse];
    [self.slipView closeCell];
}

@end
