//
//  ShoppingCartManager.m
//  SuperIntegration
//
//  Created by PP－mac001 on 16/2/2.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "ShoppingCartManager.h"

@implementation ShoppingCartManager

+ (instancetype)sharedInstance
{
    static dispatch_once_t once;
    static ShoppingCartManager *sharedInstance = nil;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (void)setCompleteSelectedMArray:(NSMutableArray *)completeSelectedMArray {
    _completeSelectedMArray = completeSelectedMArray;
}

- (void)setEditSelectMArray:(NSMutableArray *)editSelectMArray {
    _editSelectMArray = editSelectMArray;
}

@end
