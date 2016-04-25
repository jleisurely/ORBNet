//
//  HttpRequest.h
//  NetWorking
//
//  Created by 王玉 on 16/4/19.
//  Copyright © 2016年 王玉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
typedef  void (^Success)(id responseObject,NSURLSessionTask * task,NSDictionary * headers);  //请求成功block
typedef  void (^Failure)(NSError * error,NSURLSessionTask * task,NSDictionary * headers);    //请求失败block
@class ORBNet;

@interface HttpRequest : NSObject
@property (nonatomic ,strong)AFHTTPSessionManager *manager;

@property (nonatomic,copy) NSString * requestURL; //url

@property (nonatomic,copy) NSString * topHead; //http:和https:

@property (nonatomic,copy) NSString * serverAddress; //服务器地址

@property (nonatomic,strong) NSDictionary * params; //参数

@property (nonatomic,strong) NSURLSessionTask * task; //控制请求

@property (nonatomic,copy) NSString * url; //整体的

@property (nonatomic,strong) NSDictionary * responseHeaders;  //响应头

//ORBNet相关文件
/**
 *  图片的二进制数据
 */
@property (nonatomic, strong) NSData *data;
/**
 *  服务器对应的参数名称
 */
@property (nonatomic, copy) NSString *name;
/**
 *  文件的名称(上传到服务器后，服务器保存的文件名)
 */
@property (nonatomic, copy) NSString *filename;
/**
 *  文件的MIME类型(image/png,image/jpg等)
 */
@property (nonatomic, copy) NSString *mimeType;


@property (nonatomic, strong)NSMutableDictionary *dictM;

+ (void)setHeaders:(NSDictionary *)headers;

// 取消所有请求
- (void)cancleAllRequest;


// 设置请求对象参数
- (AFHTTPSessionManager *)manager;
/**
 *  发送get请求
 *
 *  @param URLString  请求的网址字符串
 *  @param parameters 请求的参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
- (NSURLSessionTask *)getWithURLString:(NSString *)URLString
              parameters:(id)parameters
                 success:(Success)success
                 failure:(Failure)failure;

/**
 *  发送post请求
 *
 *  @param URLString  请求的网址字符串
 *  @param parameters 请求的参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
- (NSURLSessionTask *)postWithURLString:(NSString *)URLString
               parameters:(id)parameters
                  success:(Success)success
                  failure:(Failure)failure;

/**
 *  发送网络请求
 *
 *  @param URLString   请求的网址字符串
 *  @param parameters  请求的参数
 *  @param type        请求的类型
 *  @param resultBlock 请求的结果
 */
//+ (void)requestWithURLString:(NSString *)URLString
//                  parameters:(id)parameters
//                        type:(HttpRequestType)type
//                     success:(void (^)(id responseObject))success
//                     failure:(void (^)(NSError *error))failure;

/**
 *  上传图片
 *
 *  @param URLString   上传图片的网址字符串
 *  @param parameters  上传图片的参数
 *  @param uploadParam 上传图片的信息
 *  @param success     上传成功的回调
 *  @param failure     上传失败的回调
 */
- (NSURLSessionTask *)uploadWithURLString:(NSString *)URLString
                 parameters:(id)parameters
                uploadParam:(ORBNet *)uploadParam
                    success:(Success)success
                    failure:(Failure)failure;
@end
