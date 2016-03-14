//
//  GuessYouLikeModel.m
//  SuperIntegration
//
//  Created by PP－mac001 on 16/2/24.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "GuessYouLikeModel.h"

@implementation GuessYouLikeModel
@synthesize id;

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

+ (GuessYouLikeModel *)modelWithDic:(NSDictionary *)dic {
    return [[GuessYouLikeModel alloc] initWithDic:dic];
}

- (id)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

@end
