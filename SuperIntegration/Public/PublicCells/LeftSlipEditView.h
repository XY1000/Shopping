//
//  LeftSlipEditView.h
//  SuperIntegration
//
//  Created by PP－mac001 on 16/4/22.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LeftSlipEditViewDelegate<NSObject>

- (void)addShopping:(UICollectionViewCell *)cell;
- (void)addFavorite:(UICollectionViewCell *)cell isFavorite:(BOOL)IsFavorite;

- (void)cellDidOpen:(UICollectionViewCell *)cell;
- (void)cellDidClose:(UICollectionViewCell *)cell;

@end

@interface LeftSlipEditView : UIView

//内容view
@property (weak, nonatomic)  UIView *myContentView;
//滑动手势
@property (assign, nonatomic) BOOL isPan;
@property (weak, nonatomic)  UIButton *button1;
@property (weak, nonatomic)  UIButton *button2;

@property(nonatomic, assign) id<LeftSlipEditViewDelegate>PublicDelegate;

- (void)openCell;
- (void)closeCell;

@end
