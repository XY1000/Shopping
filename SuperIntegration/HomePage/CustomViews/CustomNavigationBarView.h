//
//  CustomNavigationBarView.h
//  SuperIntegration
//
//  Created by PP－mac001 on 16/1/14.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomNavigationBarView : UIView

@property (weak, nonatomic) IBOutlet UIView *backView;

@property (copy, nonatomic) void(^searchClicked)();
@end
