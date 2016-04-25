//
//  ORBNet.h
//  NetWorking
//
//  Created by 王玉 on 16/4/19.
//  Copyright © 2016年 王玉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ORBNet : NSObject
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
/**
 *  网络请求类型
 */
-(ORBNet *)initWithData:(NSData *)data parameterName:(NSString *)name objectName:(NSString *)objecORBName fileType:(NSString *)type;
+(ORBNet *)data:(NSData *)data parameterName:(NSString *)name objectName:(NSString *)objecORBName fileType:(NSString *)type;
@end
