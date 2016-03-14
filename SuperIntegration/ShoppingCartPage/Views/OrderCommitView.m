//
//  OrderCommitView.m
//  SuperIntegration
//
//  Created by PP－mac001 on 16/2/23.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "OrderCommitView.h"

@implementation OrderCommitView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)commitOrderClicked:(id)sender {
    self.btn_commitOrder.enabled = NO;
    self.commitClickedBlock();
}

@end
