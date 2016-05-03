//
//  UICollectionViewCell+Protocol.m
//  SuperIntegration
//
//  Created by PP－mac001 on 16/4/22.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "UICollectionViewCell+Protocol.h"
#import <objc/runtime.h>

@implementation UICollectionViewCell (Protocol)


- (id<PublicCollectionViewCellCellDelegate>)PublicDelegate {
    return objc_getAssociatedObject(self, @selector(PublicDelegate));
}

- (void)setPublicDelegate:(id<PublicCollectionViewCellCellDelegate>)PublicDelegate {
    objc_setAssociatedObject(self, @selector(PublicDelegate), PublicDelegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)openCell {
    
}

- (void)closeCell {
    
}

@end
