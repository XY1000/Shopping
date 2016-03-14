//
//  BaseModel.m
//  noahhotel
//
//  Created by darkerwei on 15/8/11.
//  Copyright (c) 2015年 mirror. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

+ (NSNumber *)numberObjectWithResponseObject:(NSDictionary *)responseObject key:(NSString *)key
{
    id numberObject = responseObject[key];
    
    if ([numberObject isKindOfClass:[NSNumber class]]) {
        return (NSNumber *)numberObject;
    } else {
        if ([numberObject isKindOfClass:[NSString class]]) {
            NSString *temp = (NSString *)numberObject;
            return [NSNumber numberWithDouble:temp.doubleValue];
            
            
        } else {
            if (numberObject) {
                DLog(@"numberObject not NSNumber");
            } else {
                //            DDLogWarn(@"numberObject nil");
            }
        }
        return nil;
    }
}

+ (NSString *)stringObjectWithResponseObject:(NSDictionary *)responseObject key:(NSString *)key
{
    id stringObject = nil;
    if (![[responseObject allKeys] containsObject:key]) {
        return @"";
    } else {
        stringObject = responseObject[key];
    }
    
    if ([stringObject isKindOfClass:[NSString class]]) {
        return (NSString *)stringObject;
    } else {
        if ([stringObject isKindOfClass:[NSNumber class]]) {
            NSNumber *temp = (NSNumber *)stringObject;
            return [NSString stringWithFormat:@"%@", temp];
            
            
        } else {
            if (stringObject) {
//                DLog(@"%@", key);
                return @"";
            } else {
                //            DDLogWarn(@"stringObject nil");
            }
        }
        return nil;
    }
}

+ (NSArray *)arrayObjectWithResponseObject:(NSDictionary *)responseObject key:(NSString *)key
{
    id arrayObject = responseObject[key];
    
    if ([arrayObject isKindOfClass:[NSArray class]]) {
        return (NSArray *)arrayObject;
    } else {
        if (arrayObject) {
            DLog(@"arrayObject not NSArray");
        } else {
//            DDLogWarn(@"arrayObject nil");
        }
        
        return nil;
    }
}

+ (instancetype)modelWithResponseObject:(NSDictionary *)responseObject
{
    return [[self alloc] initWithResponseObject:responseObject];
}

/**
 *  字典转模型
 *
 *  @param responseObject 返回参数
 *
 *  @return 模型
 */
- (instancetype)initWithResponseObject:(NSDictionary *)responseObject
{
    return [super init];
}

@end
