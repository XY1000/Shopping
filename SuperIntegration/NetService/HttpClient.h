//
//  HttpClient.h
//  iPolice
//
//  Created by ioswei on 15/6/7.
//  Copyright (c) 2015年 Bert. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworkReachabilityManager.h"
#import "AFHTTPSessionManager.h"
#import "NetworkService.h"
@interface HttpClient : NSObject


/**
 *  发送网络请求
 *
 *  @param url     请求URL
 *  @param method  请求方式(GET/POST)
 *  @param params  请求参数
 *  @param success 请求成功时的回调
 *  @param failure 请求失败时的回调
 */
+ (void)sendRequestWithURL:(NSString *)url
                    method:(NSString *)method
                    params:(NSDictionary *)params
                   success:(void (^)(NSDictionary *responseObject))success
                   failure:(void (^)(NSError *error))failure;

+ (void)postJSONWithUrl:(NSString *)urlStr
             parameters:(id)parameters
                success:(void (^)(NSDictionary* responseObject))success
                   fail:(void (^)(NSError *error))fail;

+ (void)getJsonWithUrl:(NSString *)urlStr
            parameters:(id)parameters
               success:(void (^)(NSDictionary* responseObject))success
                  fail:(void (^)(NSError *error))fail;

+ (void)putJsonWithUrl:(NSString *)urlStr
            parameters:(id)parameters
               success:(void (^)(NSDictionary* responseObject))success
                  fail:(void (^)(NSError *error))fail;

+ (void)deleteJsonWithUrl:(NSString *)urlStr
               parameters:(id)parameters
                  success:(void (^)(NSDictionary* responseObject))success
                     fail:(void (^)(NSError *error))fail;
/**
 *  上传文件
 *
 *  @param urlStr     url
 *  @param parameters file:name
 *  @param success    成功
 *  @param fail       失败
 */
+ (void)postMultipartFormRequest:(NSString *)urlStr
                             data:(NSData *)data
                      parameters:(id)parameters
                         success:(void (^)(NSDictionary* responseObject))success
                            fail:(void (^)(NSError *error))fail;

//网络判断
+ (AFNetworkReachabilityManager *)sharedReachabilityManagerWithAlert;
//网络连接
+ (void)NetLinkCompletionHandleSuccess:(void(^)())success withFaile:(void(^)())faile;

@end
