//
//  AddressModel.m
//  SuperIntegration
//
//  Created by tmp on 16/1/28.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "AddressModel.h"

@implementation AddressModel

+ (NSDictionary *)mj_objectClassInArray{
    
    return @{
             @"addressList":[AddresslistModel class]
             };
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{
             @"errno1":@"errno"
             };
}

@end
@implementation AddresslistModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"id1":@"id"
             };
}


@end


