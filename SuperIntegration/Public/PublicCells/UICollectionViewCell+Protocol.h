//
//  UICollectionViewCell+Protocol.h
//  SuperIntegration
//
//  Created by PP－mac001 on 16/4/22.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PublicCollectionViewCellCellDelegate<NSObject>

- (void)addShopping:(UICollectionViewCell *)cell;
- (void)addFavorite:(UICollectionViewCell *)cell isFavorite:(BOOL)IsFavorite;

- (void)cellDidOpen:(UICollectionViewCell *)cell;
- (void)cellDidClose:(UICollectionViewCell *)cell;

@end

@interface UICollectionViewCell (Protocol)

@property(nonatomic, assign) id<PublicCollectionViewCellCellDelegate>PublicDelegate;

- (void)openCell;
- (void)closeCell;

@end
