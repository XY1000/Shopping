//
//  ProductDetailPageThreeCollectionViewCell.h
//  SuperIntegration
//
//  Created by PP－mac001 on 16/2/19.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ProductDetailPageModel;

@interface ProductDetailPageThreeCollectionViewCell : UICollectionViewCell

- (void)cellWithModel:(ProductDetailPageModel *)model;
@property (copy, nonatomic) void(^refreshBlock)(CGFloat contentHeight);

@end
