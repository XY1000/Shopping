//
//  SearchResultModel.m
//  SuperIntegration
//
//  Created by PP－mac001 on 16/1/25.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "SearchResultModel.h"

@implementation SearchResultModel
@synthesize id;
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

+ (SearchResultModel *)modelWithDic:(NSDictionary *)dic {
    return [[SearchResultModel alloc] initWithDic:dic];
}

- (id)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

@end
