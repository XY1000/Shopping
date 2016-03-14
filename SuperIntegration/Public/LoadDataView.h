//
//  LoadDataView.h
//  SuperIntegration
//
//  Created by PP－mac001 on 16/3/5.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadDataView : UIView

/**
 *  加载完成
 */
- (void)loadComplete;
/**
 *  刷新一下
 */
@property (copy, nonatomic) void(^block_LoadDataView_Refresh)();
@end
