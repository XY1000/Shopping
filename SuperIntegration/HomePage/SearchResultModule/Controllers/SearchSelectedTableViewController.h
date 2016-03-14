//
//  SearchSelectedTableViewController.h
//  SuperIntegration
//
//  Created by PP－mac001 on 16/1/28.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchSelectedTableViewController : UITableViewController

@property (copy, nonatomic) void(^cancelClickedBlock)();

@end
