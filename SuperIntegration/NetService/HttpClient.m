//
//  HttpClient.m
//  iPolice
//
//  Created by ioswei on 15/6/7.
//  Copyright (c) 2015年 Bert. All rights reserved.
//

#import "HttpClient.h"

@implementation HttpClient

/** 发送一个网络请求 */
+ (void)sendRequestWithURL:(NSString *)url
                    method:(NSString *)method
                    params:(NSDictionary *)params
                   success:(void (^)(NSDictionary *responseObject))success
                   failure:(void (^)(NSError *error))failure
{
}

+ (AFHTTPSessionManager *)sharedSessionManager {
    
    static dispatch_once_t once;
    static AFHTTPSessionManager *manager = nil;
    dispatch_once(&once, ^{
        manager = [AFHTTPSessionManager manager];
        
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.requestSerializer.timeoutInterval = 10.0;
        // 设置返回格式
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    });
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"automicLogin"]) {
        //请求前,设置上次保存的Cookie
        NSData *cookiesdata = [[NSUserDefaults standardUserDefaults] objectForKey:@"myCookies"];
        if([cookiesdata length]) {
            NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData:cookiesdata];
            NSHTTPCookie *cookie;
            for (cookie in cookies) {
                [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
            }  
        }
    }
    
    return manager;
}

+ (void)postJSONWithUrl:(NSString *)urlStr parameters:(id)parameters success:(void (^)(NSDictionary* responseObject))success fail:(void (^)(NSError *))fail
{

    [[HttpClient sharedSessionManager] POST:urlStr parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
//        DLog(@"progress = %@",uploadProgress.description);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            NSDictionary *jsonObject=[NSJSONSerialization
                                      JSONObjectWithData:responseObject
                                      options:NSJSONReadingMutableLeaves
                                      error:nil];
            success(jsonObject);
//            if ([jsonObject[@"errno"] integerValue] == 20404) {
//               
//                //自动登录
//                NSString *tel = [[NSUserDefaults standardUserDefaults] objectForKey:@"telephone"];
//                NSString *pw = [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
//                if (tel&&pw) {
//                    [[NetworkService sharedInstance] userLogin:@{@"telephone":tel,@"password":pw}
//                                                       Success:^(NSDictionary *responseObject) {
//                                                           
//                                                       } fail:^(NSError *error) {
//                                                           
//                                                       }];
//                }
//
//                NSLog(@"post 重新登录");
//            }
            
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DLog(@"%@", error);
        if (fail) {
            fail(error);
        }
    }];
    
}

+ (void)getJsonWithUrl:(NSString *)urlStr
            parameters:(id)parameters
               success:(void (^)(NSDictionary* responseObject))success
                  fail:(void (^)(NSError *error))fail{
    

    [[HttpClient sharedSessionManager] GET:urlStr parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
//        DLog(@"%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            NSDictionary *jsonObject=[NSJSONSerialization
                                      JSONObjectWithData:responseObject
                                      options:NSJSONReadingMutableLeaves
                                      error:nil];
            success(jsonObject);
            
            if ([jsonObject[@"errno"] integerValue] == 20409) {
                NSLog(@"%@", urlStr);
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isLogin"];
                //用户未登录
                [[NSNotificationCenter defaultCenter] postNotificationName:@"login" object:nil];
                
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DLog(@"%@", error);
        if (fail) {
            fail(error);
//            NSError *err = [NSError errorWithDomain:@"网络错误"
//                                               code:0
//                                           userInfo:@{@"errmsg":@"当前网络不给力哦~"}];
//
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"loadError" object:nil userInfo:err.userInfo];
        }
    }];
}

+ (void)putJsonWithUrl:(NSString *)urlStr
            parameters:(id)parameters
               success:(void (^)(NSDictionary* responseObject))success
                  fail:(void (^)(NSError *error))fail{

    [[HttpClient sharedSessionManager] PUT:urlStr parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            NSDictionary *jsonObject=[NSJSONSerialization
                                      JSONObjectWithData:responseObject
                                      options:NSJSONReadingMutableLeaves
                                      error:nil];
            NSLog(@"jsonObject is %@",jsonObject);
            success(jsonObject);
//            NSLog(@"put 重新登录");
//         
//            if ([jsonObject[@"errno"] integerValue] == 20404) {
//                
//                //自动登录
//                NSString *tel = [[NSUserDefaults standardUserDefaults] objectForKey:@"telephone"];
//                NSString *pw = [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
//                if (tel&&pw) {
//                    [[NetworkService sharedInstance] userLogin:@{@"telephone":tel,@"password":pw}
//                                                       Success:^(NSDictionary *responseObject) {
//                                                           
//                                                       } fail:^(NSError *error) {
//                                                           
//                                                       }];
//                }
//                
//            }
        }else{
            NSLog(@"error =%@",responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
        if (fail) {
            fail(error);
        }
    }];

}

+ (void)deleteJsonWithUrl:(NSString *)urlStr
               parameters:(id)parameters
                  success:(void (^)(NSDictionary* responseObject))success
                     fail:(void (^)(NSError *error))fail{
    
    
    [[HttpClient sharedSessionManager] DELETE:urlStr parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            NSDictionary *jsonObject=[NSJSONSerialization
                                      JSONObjectWithData:responseObject
                                      options:NSJSONReadingMutableContainers
                                      error:nil];
            NSLog(@"jsonObject is %@",jsonObject);
            success(jsonObject);
//            
//            if ([jsonObject[@"errno"] integerValue] == 20404) {
//                
//                //自动登录
//                NSString *tel = [[NSUserDefaults standardUserDefaults] objectForKey:@"telephone"];
//                NSString *pw = [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
//                if (tel&&pw) {
//                    [[NetworkService sharedInstance] userLogin:@{@"telephone":tel,@"password":pw}
//                                                       Success:^(NSDictionary *responseObject) {
//                                                           
//                                                       } fail:^(NSError *error) {
//                                                           
//                                                       }];
//                }
//                
//            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
        if (fail) {
            fail(error);
        }
    }];
}

+(void)postMultipartFormRequest:(NSString *)urlStr
                           data:(NSData *)data
                     parameters:(id)parameters
                        success:(void (^)(NSDictionary *))success
                           fail:(void (^)(NSError *))fail{

    [[HttpClient sharedSessionManager] POST:urlStr parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:data name:@"file" fileName:@"headImage" mimeType:@"image/png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            NSDictionary *jsonObject=[NSJSONSerialization
                                      JSONObjectWithData:responseObject
                                      options:NSJSONReadingMutableContainers
                                      error:nil];
            NSLog(@"jsonObject is %@",jsonObject);
            success(jsonObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DLog(@"%@", error);
        if (fail) {
            fail(error);
        }
    }];
}

/**
 *  网络状态判断
 */
+ (AFNetworkReachabilityManager *)sharedReachabilityManagerWithAlert
{
    AFNetworkReachabilityManager * manger = [AFNetworkReachabilityManager sharedManager];
    [manger setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        NSString * message ;
        if (status == AFNetworkReachabilityStatusNotReachable) {
            message = @"无法连接，请检查网络设置";
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"网络提醒" message:message delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil];
            [alertView show];
        }
    }];
    [manger startMonitoring];
    return manger;
}
+ (void)NetLinkCompletionHandleSuccess:(void (^)())success withFaile:(void (^)())faile{
    AFNetworkReachabilityManager * manger = [AFNetworkReachabilityManager sharedManager];
    [manger setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if (status == AFNetworkReachabilityStatusNotReachable) {
            faile();
        }else{
            success();
        }
    }];
    [manger startMonitoring];
}
@end
