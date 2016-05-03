//
//  MineSectionZeroCollectionViewCell.h
//  SuperIntegration
//
//  Created by PP－mac001 on 16/1/15.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineSectionZeroCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *userNickname;
@property (weak, nonatomic) IBOutlet UILabel *footPrintLabel;
@property (weak, nonatomic) IBOutlet UILabel *favoriteLabel;

//我的关注
@property (copy, nonatomic) void(^block_MyFavorite)();
//我的足迹
@property (copy, nonatomic) void(^block_MyFootPrint)();

@end
