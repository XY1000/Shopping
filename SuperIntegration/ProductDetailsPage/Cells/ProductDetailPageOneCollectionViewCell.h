//
//  ProductDetailPageOneCollectionViewCell.h
//  SuperIntegration
//
//  Created by PP－mac001 on 16/2/19.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ProductDetailPageModel;
@interface ProductDetailPageOneCollectionViewCell : UICollectionViewCell

- (void)cellWithModel:(ProductDetailPageModel *)model andPrice:(NSInteger)price;

@end
