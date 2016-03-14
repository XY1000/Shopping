//
//  PublicOneCollectionViewCell.h
//  SuperIntegration
//
//  Created by PP－mac001 on 16/1/19.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SearchResultModel;
@class GuessYouLikeModel;

@interface PublicOneCollectionViewCell : UICollectionViewCell

- (void)cellWithModel:(SearchResultModel *)model;
- (void)cellWithGuessModel:(GuessYouLikeModel *)model;
@end
