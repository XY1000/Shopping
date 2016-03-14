//
//  BaseModel.h
//  noahhotel
//
//  Created by darkerwei on 15/8/11.
//  Copyright (c) 2015年 mirror. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject

/**
 *  获取数字类型value
 *
 *  @param responseObject 返回参数
 *  @param key            返回参数key
 *
 *  @return 数字类型value
 */
+ (NSNumber *)numberObjectWithResponseObject:(NSDictionary *)responseObject key:(NSString *)key;

/**
 *  获取字符串类型value
 *
 *  @param responseObject 返回参数
 *  @param key            返回参数key
 *
 *  @return 字符串类型value
 */
+ (NSString *)stringObjectWithResponseObject:(NSDictionary *)responseObject key:(NSString *)key;

/**
 *  获取数组类型value
 *
 *  @param responseObject 返回参数
 *  @param key            返回参数key
 *
 *  @return 数组类型value
 */
+ (NSArray *)arrayObjectWithResponseObject:(NSDictionary *)responseObject key:(NSString *)key;

/**
 *  字典转模型
 *
 *  @param responseObject 返回参数
 *
 *  @return 模型
 */
+ (instancetype)modelWithResponseObject:(NSDictionary *)responseObject;

@end
