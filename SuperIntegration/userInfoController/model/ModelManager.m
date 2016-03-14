//
//  ModelManager.m
//  SuperIntegration
//
//  Created by tmp on 16/2/18.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "ModelManager.h"

@implementation ModelManager

+ (UserModel *)getUserModel{
    
    static UserModel *model = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        model = [[UserModel alloc]init];
    });
    
    return model;
    
}

+ (void)saveUserInfoWithDic:(NSDictionary *)dic{
    
    for (NSString *str in dic.allKeys) {
        
        [[NSUserDefaults standardUserDefaults] setValue:dic[str] forKey:str];
        
    }
    
}

@end
