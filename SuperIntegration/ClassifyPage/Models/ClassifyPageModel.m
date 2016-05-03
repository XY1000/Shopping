//
//  ClassifyPageModel.m
//  SuperIntegration
//
//  Created by PP－mac001 on 16/1/20.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//

#import "ClassifyPageModel.h"

@implementation ClassifyPageModel

@end

@implementation ClassifyPageChannelListModel

+ (ClassifyPageChannelListModel *)modelWithDic:(NSDictionary *)dic {
    return [[ClassifyPageChannelListModel alloc] initWithDic:dic];
}

- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        self.channelId = [BaseModel stringObjectWithResponseObject:dic key:@"id"];
        self.channelName = [BaseModel stringObjectWithResponseObject:dic key:@"name"];
        self.webPicUrl = [BaseModel stringObjectWithResponseObject:dic key:@"webPicUrl"];
        self.appName = [BaseModel stringObjectWithResponseObject:dic key:@"appName"];
        self.appPicUrl = [BaseModel stringObjectWithResponseObject:dic key:@"appPicUrl"];
        NSArray *tmpArray = [BaseModel arrayObjectWithResponseObject:dic key:@"list"];
        NSMutableArray *tmpMArray = [NSMutableArray array];
        for (NSDictionary *dic in tmpArray) {
            ClassifyPageSubChannelListModel *subChannelModel = [ClassifyPageSubChannelListModel modelWithDic:dic];
            [tmpMArray addObject:subChannelModel];
        }
        self.subChannelList = tmpMArray;
    }
    return self;
}

@end

@implementation ClassifyPageSubChannelListModel

+ (ClassifyPageSubChannelListModel *)modelWithDic:(NSDictionary *)dic {
    return [[ClassifyPageSubChannelListModel alloc] initWithDic:dic];
}

- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        self.subChannelId = [BaseModel stringObjectWithResponseObject:dic key:@"id"];
        self.subCahnnelName = [BaseModel stringObjectWithResponseObject:dic key:@"name"];
        self.subChannelSnCategoryId = [BaseModel stringObjectWithResponseObject:dic key:@"snCategoryId"];
        self.subChannelCategoryId = [BaseModel stringObjectWithResponseObject:dic key:@"categoryId"];
        NSArray *tmpArray = [BaseModel arrayObjectWithResponseObject:dic key:@"keyWordList"];
        NSMutableArray *tmpMArray = [NSMutableArray array];
        for (NSDictionary *dic in tmpArray) {
            ClassifyPageKeyWordListModel *subChannelModel = [ClassifyPageKeyWordListModel modelWithDic:dic];
            [tmpMArray addObject:subChannelModel];
        }
        self.subChannelKeyWordList = tmpMArray;
    }
    return self;
}

@end

@implementation ClassifyPageKeyWordListModel

+ (ClassifyPageKeyWordListModel *)modelWithDic:(NSDictionary *)dic {
    return [[ClassifyPageKeyWordListModel alloc] initWithDic:dic];
}

- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        self.keyWordId = [BaseModel stringObjectWithResponseObject:dic key:@"id"];
        self.keyWordName = [BaseModel stringObjectWithResponseObject:dic key:@"name"];
        self.keyWordAppPicUrl = [BaseModel stringObjectWithResponseObject:dic key:@"appPicUrl"];
    }
    return self;
}

@end