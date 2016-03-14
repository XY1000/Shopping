//
//  ProductDetailPageModel.m
//  SuperIntegration
//
//  Created by PP－mac001 on 16/2/18.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "ProductDetailPageModel.h"

@implementation ProductDetailPageModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

+ (ProductDetailPageModel *)modelWithDic:(NSDictionary *)dic {
    return [[ProductDetailPageModel alloc] initWithDic:dic];
}

- (id)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

@end




@implementation ProductDetailPageWithImagesModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

+ (ProductDetailPageWithImagesModel *)modelWithDic:(NSDictionary *)dic {
    return [[ProductDetailPageWithImagesModel alloc] initWithDic:dic];
}

- (id)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

@end