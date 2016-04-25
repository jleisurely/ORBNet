//
//  HttpRequest.m
//  NetWorking
//
//  Created by 王玉 on 16/4/19.
//  Copyright © 2016年 王玉. All rights reserved.
//

#import "HttpRequest.h"
#import "ORBNet.h"

static NSDictionary * _headers;
@implementation HttpRequest
// 设置请求头
+ (void)setHeaders:(NSDictionary *)headers {
    _headers = headers;
}
// 取消单个请求（请用下面那个）
//- (void)cancleRequest {
//    [self cancel];
//}

// 取消所有请求
- (void)cancleAllRequest {
    [_manager.operationQueue cancelAllOperations];
    
}

// 设置请求对象参数
- (AFHTTPSessionManager *)manager {
    self.manager = [AFHTTPSessionManager manager];
    _manager.requestSerializer.timeoutInterval = 15;
    _manager.requestSerializer = [AFJSONRequestSerializer serializer];
    for (NSString * key in _headers) {
        [_manager.requestSerializer setValue:_headers[key] forHTTPHeaderField:key];
    }
    //可以省略
    _manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
    
    _manager.responseSerializer = [AFJSONResponseSerializer serializer];
    _manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
                                                                               @"text/html",
                                                                               @"text/json",
                                                                               @"text/plain",
                                                                               @"text/javascript",
                                                                               @"text/xml",
                                                                               @"image/*"]];
    return _manager;
}
#pragma mark -- GET请求 --
- (NSURLSessionTask *)getWithURLString:(NSString *)URLString
              parameters:(id)parameters
                 success:(Success)success
                 failure:(Failure)failure {
    AFHTTPSessionManager * manager = [self manager];
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    /**
//     *  可以接受的类型
//     */
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    /**
     *  请求队列的最大并发数
     */
    //    manager.operationQueue.maxConcurrentOperationCount = 5;
    /**
     *  请求超时的时间
     */
    //    manager.requestSerializer.timeoutInterval = 5;
    NSURLSessionTask *sessionTask = [manager GET:URLString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            NSHTTPURLResponse * response = (NSHTTPURLResponse *)task.response;
            success(responseObject,task,response.allHeaderFields);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            NSHTTPURLResponse * response = (NSHTTPURLResponse *)task.response;
            failure(error,task,response.allHeaderFields);
        }
    }];
    return sessionTask;
}

#pragma mark -- POST请求 --
- (NSURLSessionTask *)postWithURLString:(NSString *)URLString
               parameters:(id)parameters
                  success:(Success)success
                  failure:(Failure)failure {
    
    AFHTTPSessionManager * manager = [self manager];

    NSURLSessionTask *sessionTask = [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            NSHTTPURLResponse * response = (NSHTTPURLResponse *)task.response;
            success(responseObject,task,response.allHeaderFields);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            NSHTTPURLResponse * response = (NSHTTPURLResponse *)task.response;
            failure(error,task,response.allHeaderFields);
        }
    }];
    return sessionTask;
}



#pragma mark -- 上传文件 --
- (NSURLSessionTask *)uploadWithURLString:(NSString *)URLString
                 parameters:(id)parameters
                uploadParam:(ORBNet *)uploadParam
                    success:(Success)success
                    failure:(Failure)failure {
    
    AFHTTPSessionManager * manager = [self manager];
    NSURLSessionTask *sessionTask = [manager POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:uploadParam.data name:uploadParam.name fileName:uploadParam.filename mimeType:uploadParam.mimeType];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            NSHTTPURLResponse * response = (NSHTTPURLResponse *)task.response;
            success(responseObject,task,response.allHeaderFields);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            NSHTTPURLResponse * response = (NSHTTPURLResponse *)task.response;
            failure(error,task,response.allHeaderFields);
        }
    }];
    return sessionTask;
}
@end
