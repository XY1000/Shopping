//
//  PublicOneCollectionViewCell.m
//  SuperIntegration
//
//  Created by PP－mac001 on 16/1/19.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "PublicOneCollectionViewCell.h"
#import "SearchResultModel.h"
#import "GuessYouLikeModel.h"


@interface PublicOneCollectionViewCell()<UIGestureRecognizerDelegate>

@property (weak, nonatomic)  UILabel *nameLabel;
@property (weak, nonatomic)  UILabel *priceLabel;
@property (weak, nonatomic)  UIImageView *imageView;


@end

@implementation PublicOneCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        UIImageView *imageView_Image = [[UIImageView alloc] init];
        [self.contentView addSubview:imageView_Image];
        [imageView_Image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).with.offset(0.0);
            make.top.equalTo(self.contentView).with.offset(0.0);
            make.right.equalTo(self.contentView).with.offset(0.0);
            make.height.mas_equalTo(PublicOneCellImageHeight);
        }];
        self.imageView = imageView_Image;
        
        _slipView = [[LeftSlipEditView alloc] init];
        [self.contentView addSubview:_slipView];
        [_slipView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).with.offset(0.0);
            make.right.equalTo(self.contentView).with.offset(0.0);
            make.bottom.equalTo(self.contentView).with.offset(0.0);
            make.top.equalTo(imageView_Image.mas_bottom).with.offset(0.0);
        }];
        
        
        UILabel *label_NameLabel = [[UILabel alloc] init];
        label_NameLabel.textColor = RGB(51, 51, 51);
        label_NameLabel.font = [UIFont systemFontOfSize:11.0];
        label_NameLabel.numberOfLines = 2;
        [_slipView.myContentView addSubview:label_NameLabel];
        [label_NameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_slipView.myContentView).with.offset(5.0);
            make.right.equalTo(_slipView.myContentView).with.offset(-5.0);
            make.top.equalTo(_slipView.myContentView).with.offset(5.0);
        }];
        self.nameLabel = label_NameLabel;
        
        UILabel *label_PriceLabel = [[UILabel alloc] init];
        label_PriceLabel.textColor = RGB(204, 10, 42);
        label_PriceLabel.font = [UIFont systemFontOfSize:12.0];
        [_slipView.myContentView addSubview:label_PriceLabel];
        [label_PriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(label_NameLabel);
            make.bottom.mas_equalTo(_slipView.myContentView).with.offset(-10);
        }];
        self.priceLabel = label_PriceLabel;
    }
    return self;
}

- (void)cellWithModel:(SearchResultModel *)model {
    
    //    [Utility yanshiWithSeconds:0.1 method:^{
    //        [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"place"]];
    //    }];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:nil];
    
    self.nameLabel.text = model.name;
    //    self.priceLabel.text = model.price;
    if (model.amount.integerValue == 0) {
        self.priceLabel.text = @"该地区暂未销售";
    } else {
        self.priceLabel.text = model.amount;
    }
    
}

- (void)cellWithGuessModel:(GuessYouLikeModel *)model {
    
    [Utility yanshiWithSeconds:0.1 method:^{
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"place"]];
    }];
    
    self.nameLabel.text = model.name;
    if (OBJ_CLASS(model.amount, [NSString class])) {
        self.priceLabel.text = model.amount;
    }
}

/**
 *  这个方法确保 Cell 在其回收重利用时再次关闭。
 */
- (void)prepareForReuse {
    [super prepareForReuse];
    [_slipView closeCell];
}

@end
