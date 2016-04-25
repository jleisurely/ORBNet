//
//  AppDelegate.m
//  AFNetWorking3
//
//  Created by 王玉 on 16/4/19.
//  Copyright © 2016年 王玉. All rights reserved.
//
#import "RequestNetWork.h"
#import "HttpRequest.h"
#import "ORBNet.h"

@interface RequestNetWork ()


@end

@implementation RequestNetWork

// 单例
+ (instancetype)defaultManager {
    static RequestNetWork * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [self new];
    });
    
    return manager;
}


#pragma mark - 网络请求方法

// 开始请求
/**
 *  @abstract 发送请求
 *  @params  tophead   http: or https:
 *  @params  url       请求URL，（服务器地址后的）
 *  @params  params    请求参数
 *  @param data         文件的二进制数据
 *  @param name         服务器对应的参数名称
 *  @param objecORBName 文件的名称（上传到服务器后，服务器保存的文件名）
 *  @param type         文件的MIME类型(image/png,image/jpg等)
 */

- (NSURLSessionTask *)POSTWithWebURL:(NSString *)url params:(NSDictionary *)params data:(NSData *)data parameterName:(NSString *)name objectName:(NSString *)objecORBName fileType:(NSString *)type success:(Success)success failure:(Failure)failure{
    
    self.requestURL = url;
    self.params     = params;
    self.data       = data;
    self.name       = name;
    self.filename   = objecORBName;
    self.mimeType   = type;
    //    NSFontAttributeName
    // 设置请求头
    NSUserDefaults *udef = [NSUserDefaults standardUserDefaults];
    NSString *token = [udef objectForKey:@"pwd"];
    NSMutableDictionary* header = [[NSMutableDictionary alloc]init];
    
//    if (!([Token sharedInstance].token == nil)) {
    if (token) {
        [header setObject:@"sys@00001" forKey:@"username"];
        [header setObject:token forKey:@"token"];
        
        
    }else{
        [header setObject:@"sys@00001" forKey:@"username"];
    }
    [HttpRequest setHeaders:header];
    // 代理方法请求开始
        ORBNet *net = nil;
    if (self.data) {
        net = [ORBNet data:self.data parameterName:self.name objectName:self.filename fileType:self.mimeType];
        NSURLSessionTask *sessionTask =  [self uploadWithURLString:self.requestURL parameters:self.params uploadParam:net success:^(id responseObject, NSURLSessionTask *task, NSDictionary *headers) {
            success(responseObject,task,header);
        } failure:^(NSError *error, NSURLSessionTask *task, NSDictionary *headers) {
            failure(error,task,header);
        }];
        return sessionTask;
    }else if (self.params){
        NSURLSessionTask *sessionTask = [self postWithURLString:self.requestURL parameters:self.params success:^(id responseObject, NSURLSessionTask *task, NSDictionary *headers) {
            success(responseObject,task,header);
        } failure:^(NSError *error, NSURLSessionTask *task, NSDictionary *headers) {
            failure(error,task,header);
        }];
        return sessionTask;
    }else{
        NSURLSessionTask *sessionTask = [self getWithURLString:self.requestURL parameters:self.params success:^(id responseObject, NSURLSessionTask *task, NSDictionary *headers) {
            success(responseObject,task,header);
        } failure:^(NSError *error, NSURLSessionTask *task, NSDictionary *headers) {
            failure(error,task,header);
        }];
        return sessionTask;
    }
}



@end
