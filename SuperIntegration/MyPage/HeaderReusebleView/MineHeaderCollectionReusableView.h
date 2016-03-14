//
//  MineHeaderCollectionReusableView.h
//  SuperIntegration
//
//  Created by PP－mac001 on 16/1/15.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineHeaderCollectionReusableView : UICollectionReusableView

- (void)headerViewWithIndexPath:(NSIndexPath *)indexPath;
@property (copy, nonatomic) void(^buttonClicked)();

@end
