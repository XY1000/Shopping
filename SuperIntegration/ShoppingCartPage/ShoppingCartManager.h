//
//  ShoppingCartManager.h
//  SuperIntegration
//
//  Created by PP－mac001 on 16/2/2.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum
{
    compelteCell = 1,
    editCell
}CellType;

@interface ShoppingCartManager : NSObject
+(instancetype)sharedInstance;

//结算选上的购物车
@property (strong, nonatomic) NSMutableArray *completeSelectedMArray;
//删除悬赏的购物车
@property (strong, nonatomic) NSMutableArray *editSelectMArray;

@end
