//
//  CustomFavoriteShared.h
//  SuperIntegration
//
//  Created by PP－mac001 on 16/4/14.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomFavoriteShared : NSObject

+(instancetype)customFavoriteShared;

- (void)getUrlCacheSuccess:(void(^)(NSArray *array_SkuCache))success;

@end
