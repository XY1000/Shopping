//
//  SearchSelectedTableViewController.m
//  SuperIntegration
//
//  Created by PP－mac001 on 16/1/28.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "SearchSelectedTableViewController.h"

@implementation SearchSelectedTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)cancelClicked:(id)sender {
    _cancelClickedBlock();
}

- (IBAction)determineClicked:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"determineClicked" object:nil userInfo:nil];
}

@end
