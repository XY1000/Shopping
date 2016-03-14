//
//  HomePageModel.m
//  SuperIntegration
//
//  Created by PP－mac001 on 16/1/20.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "HomePageModel.h"

@implementation HomePageModel
@synthesize id;

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

+ (HomePageModel *)modelWithDic:(NSDictionary *)dic {
    return [[HomePageModel alloc] initWithDic:dic];
}

- (id)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

@end

@implementation HomePageBannerViewImageModel


- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

+ (HomePageBannerViewImageModel *)modelWithDic:(NSDictionary *)dic {
    return [[HomePageBannerViewImageModel alloc] initWithDic:dic];
}

- (id)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

@end

@implementation HomePageSpecialModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

+ (HomePageSpecialModel *)modelWithDic:(NSDictionary *)dic {
    return [[HomePageSpecialModel alloc] initWithDic:dic];
}

- (id)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
        
        NSMutableArray *tmpMArray = [NSMutableArray array];
        for (NSDictionary *dic in self.list) {
            HomePageModel *model = [HomePageModel modelWithDic:dic];
            [tmpMArray addObject:model];
        }
        self.list = (NSArray *)tmpMArray;
        
    }
    return self;
}

@end

@implementation HomePageChannelListModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

+ (HomePageChannelListModel *)modelWithDic:(NSDictionary *)dic {
    return [[HomePageChannelListModel alloc] initWithDic:dic];
}

- (id)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
        
        NSMutableArray *tmpMArray = [NSMutableArray array];
        for (NSDictionary *dic in self.productList) {
            HomePageModel *model = [HomePageModel modelWithDic:dic];
            [tmpMArray addObject:model];
        }
        self.productList = (NSArray *)tmpMArray;
        
    }
    return self;
}

@end
