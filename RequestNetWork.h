//
//  AppDelegate.m
//  AFNetWorking3
//
//  Created by 王玉 on 16/4/19.
//  Copyright © 2016年 王玉. All rights reserved.
//


#import "HttpRequest.h"

@interface RequestNetWork : HttpRequest


/**
 *  @abstract 创建单例对象
 */
+ (instancetype)defaultManager;
/**
 *  @abstract 派发成功数据
 *  @params  task   请求返回实例
 *  @params  code   返回头信息 网络请求状态
 *  @params  msg    返回头信息 返回的消息msg
 *  @params  datas  请求成功 返回的数据RtnData
 */
//- (void)pushResponseResultsFinished:(NSURLSessionTask *)task responseCode:(NSString*)code withMessage:(NSString*)msg andData:(NSDictionary*)datas success:(Success)success failure:(Failure)failure;
/**
 *  @abstract 发送请求
 *  @params  tophead   http: or https:
 *  @params  url       请求URL，（服务器地址后的）
 *  @params  params    请求参数
 *  @param data         图片的二进制数据
 *  @param name         服务器对应的参数名称
 *  @param objecORBName 文件的名称（上传到服务器后，服务器保存的文件名）
 *  @param type         文件的MIME类型(image/png,image/jpg等)
 */
- (NSURLSessionTask *)POSTWithWebURL:(NSString *)url params:(NSDictionary *)paramsr data:(NSData *)data parameterName:(NSString *)name objectName:(NSString *)objecORBName fileType:(NSString *)type success:(Success)success failure:(Failure)failure;

@end
