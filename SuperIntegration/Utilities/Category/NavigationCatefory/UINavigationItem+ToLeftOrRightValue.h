//
//  UINavigationItem+ToLeftOrRightValue.h
//  SuperIntegration
//
//  Created by PP－mac001 on 16/2/2.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationItem (ToLeftOrRightValue)

- (void)setCustomLeftBarButtonItem:(UIBarButtonItem *)_leftBarButtonItem ToLeftValue:(NSInteger)value;
- (void)setCustomRightBarButtonItem:(UIBarButtonItem *)_rightBarButtonItem ToRightValue:(NSInteger)value;


- (void)setLeftBarButtonItem:(UIBarButtonItem *)_leftBarButtonItem;
- (void)setRightBarButtonItem:(UIBarButtonItem *)_rightBarButtonItem;
@end
