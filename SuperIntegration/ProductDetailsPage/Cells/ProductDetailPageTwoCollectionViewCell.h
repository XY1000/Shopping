//
//  ProductDetailPageTwoCollectionViewCell.h
//  SuperIntegration
//
//  Created by PP－mac001 on 16/2/19.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ProductDetailPageModel;
@interface ProductDetailPageTwoCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;
- (void)cellWithModel:(ProductDetailPageModel *)model andIndexPath:(NSIndexPath *)indexPath;

@end
