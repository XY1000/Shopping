//
//  OrderModel.m
//  SuperIntegration
//
//  Created by PP－mac001 on 16/2/26.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "OrderModel.h"

@implementation OrderModel

@synthesize id;
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

+ (OrderModel *)modelWithDic:(NSDictionary *)dic {
    return [[OrderModel alloc] initWithDic:dic];
}

- (id)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
        
        NSMutableArray *tmpArray = [NSMutableArray array];
        for (NSDictionary *dic in self.productList) {
            OrderModelProductList *productListModel = [OrderModelProductList modelWithDic:dic];
            [tmpArray addObject:productListModel];
        }
        self.productList = (NSArray *)tmpArray;
        
    }
    return self;
}

@end

@implementation OrderModelProductList

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

+ (OrderModelProductList *)modelWithDic:(NSDictionary *)dic {
    return [[OrderModelProductList alloc] initWithDic:dic];
}

- (id)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

@end


//订单详情
@implementation OrderDetailModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

+ (OrderDetailModel *)modelWithDic:(NSDictionary *)dic {
    return [[OrderDetailModel alloc] initWithDic:dic];
}

- (id)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
        
        NSMutableArray *tmpArray = [NSMutableArray array];
        for (NSDictionary *dic in self.productList) {
            OrderDetailModelProductList *productListModel = [OrderDetailModelProductList modelWithDic:dic];
            [tmpArray addObject:productListModel];
        }
        self.productList = (NSArray *)tmpArray;
    }
    return self;
}

@end

@implementation OrderDetailModelProductList

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

+ (OrderDetailModelProductList *)modelWithDic:(NSDictionary *)dic {
    return [[OrderDetailModelProductList alloc] initWithDic:dic];
}

- (id)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

@end