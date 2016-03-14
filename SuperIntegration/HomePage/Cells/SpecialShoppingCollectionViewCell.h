//
//  SpecialShoppingCollectionViewCell.h
//  SuperIntegration
//
//  Created by PP－mac001 on 16/1/12.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpecialShoppingCellCustomView.h"
@interface SpecialShoppingCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet SpecialShoppingCellCustomView *cellWithCustomView;
@end
