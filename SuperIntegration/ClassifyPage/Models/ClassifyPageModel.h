//
//  ClassifyPageModel.h
//  SuperIntegration
//
//  Created by PP－mac001 on 16/1/20.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "BaseModel.h"

@interface ClassifyPageModel : BaseModel

@end

@interface ClassifyPageChannelListModel : BaseModel
/**
 *  频道Id
 */
@property (strong, nonatomic) NSString *channelId;
/**
 *  频道名称
 */
@property (strong, nonatomic) NSString *channelName;
/**
 *  分类图片url
 */
@property (strong, nonatomic) NSString *webPicUrl;
/**
 *  分类列表
 */
@property (strong, nonatomic) NSArray *subChannelList;

+ (ClassifyPageChannelListModel *)modelWithDic:(NSDictionary *)dic;

@end

@interface ClassifyPageSubChannelListModel : BaseModel

/**
 *  分类id
 */
@property (strong, nonatomic) NSString *subChannelId;
/**
 *  分类名称
 */
@property (strong, nonatomic) NSString *subCahnnelName;
/**
 *  苏宁分类id
 */
@property (strong, nonatomic) NSString *subChannelSnCategoryId;
/**
 *  父级分类id
 */
@property (strong, nonatomic) NSString *subChannelCategoryId;
/**
 *  关键字列表
 */
@property (strong, nonatomic) NSArray *subChannelKeyWordList;

+ (ClassifyPageSubChannelListModel *)modelWithDic:(NSDictionary *)dic;

@end

@interface ClassifyPageKeyWordListModel : BaseModel

/**
 *  关键字Id
 */
@property (strong, nonatomic) NSString *keyWordId;
/**
 *  关键字名称
 */
@property (strong, nonatomic) NSString *keyWordName;
/**
 *  关键字图片
 */
@property (strong, nonatomic) NSString *keyWordAppPicUrl;

+ (ClassifyPageKeyWordListModel *)modelWithDic:(NSDictionary *)dic;

@end