//
//  AddressModel.h
//  SuperIntegration
//
//  Created by tmp on 16/1/28.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AddresslistModel;
@interface AddressModel : NSObject

@property (nonatomic, assign) NSInteger errno1;

@property (nonatomic, copy) NSString *errmsg;

@property (nonatomic, strong)NSArray< AddresslistModel *> *addressList;

@end
@interface AddresslistModel : NSObject

@property (nonatomic, copy) NSString *cityId;

@property (nonatomic, copy) NSString *townId;

@property (nonatomic, copy) NSString *provinceId;

@property (nonatomic, assign) NSInteger id1;

@property (nonatomic, copy) NSString *contact;

@property (nonatomic, copy) NSString *countyId;

@property (nonatomic, copy) NSString *email;

@property (nonatomic, copy) NSString *addressDetail;

@property (nonatomic, copy) NSString *telephone;

@property (nonatomic, assign) NSInteger isDefault;

@property (nonatomic, copy) NSString *name;

@property(nonatomic,copy)NSString *fullAddress;

@property(nonatomic,copy)NSString *provinceName;

@end

