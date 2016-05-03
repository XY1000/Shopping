//
//  CustomFavoriteShared.m
//  SuperIntegration
//
//  Created by PP－mac001 on 16/4/14.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "CustomFavoriteShared.h"

@implementation CustomFavoriteShared

+ (instancetype)customFavoriteShared {
    static dispatch_once_t once;
    static CustomFavoriteShared *sharedInstance = nil;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}


- (instancetype)init {
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeCache) name:@"removeCache" object:nil];
    }
    return self;
}

- (void)getUrlCacheSuccess:(void (^)(NSArray *))success {
    NSURLCache *myCache = [NSURLCache sharedURLCache];
    NSURL *url = [NSURL URLWithString:Send_Url(Root_Path, category_Api, favouriteList)];
    NSMutableURLRequest *requestUrl = [NSMutableURLRequest requestWithURL:url];
    NSCachedURLResponse *responseObj = [myCache cachedResponseForRequest:requestUrl];
    
    NSMutableArray *MArray_sku = [NSMutableArray array];
    if (responseObj) {//有缓存
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObj.data options:NSJSONReadingMutableLeaves error:nil];
        for (NSDictionary *dic in dict[@"list"]){
            [MArray_sku addObject:dic[@"sku"]];
        }
        success(MArray_sku);
    } else {//无缓存
        // 2.设置缓存策略(有缓存就用缓存，没有缓存就重新请求)
        requestUrl.cachePolicy = NSURLRequestReturnCacheDataElseLoad;

        [NSURLConnection sendAsynchronousRequest:requestUrl queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
            if (data) {
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                for (NSDictionary *dic in dict[@"list"]){
                    [MArray_sku addObject:dic[@"sku"]];
                }
                success(MArray_sku);
            }
        }];
    }
}


//清除缓存
- (void)removeCache {
    NSURLCache *myCache = [NSURLCache sharedURLCache];
    [myCache removeAllCachedResponses];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"removeCache" object:nil];
}

@end
