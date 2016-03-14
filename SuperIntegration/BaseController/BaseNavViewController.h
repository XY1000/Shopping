//
//  BaseNavViewController.h
//  KMovie
//
//  Created by PP－mac001 on 15/7/13.
//  Copyright (c) 2015年 PP－mac001. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BaseNavViewControllerDelegate <NSObject>

@end

@interface BaseNavViewController : UINavigationController

@property (assign, nonatomic) id<BaseNavViewControllerDelegate> Navdelegate;

@end
