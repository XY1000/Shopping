//
//  ShoppingCartPageModel.m
//  SuperIntegration
//
//  Created by PP－mac001 on 16/1/29.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "ShoppingCartPageModel.h"

@implementation ShoppingCartPageModel
@synthesize id;
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

+ (ShoppingCartPageModel *)modelWithDic:(NSDictionary *)dic {
    return [[ShoppingCartPageModel alloc] initWithDic:dic];
}

- (id)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

@end
