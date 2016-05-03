//
//  PublicOneCollectionViewCell.h
//  SuperIntegration
//
//  Created by PP－mac001 on 16/1/19.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftSlipEditView.h"
@class SearchResultModel;
@class GuessYouLikeModel;


@interface PublicOneCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) LeftSlipEditView *slipView;


- (void)cellWithModel:(SearchResultModel *)model;
- (void)cellWithGuessModel:(GuessYouLikeModel *)model;

@end
