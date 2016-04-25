//
//  ORBNet.m
//  NetWorking
//
//  Created by 王玉 on 16/4/19.
//  Copyright © 2016年 王玉. All rights reserved.
//

#import "ORBNet.h"


@implementation ORBNet
/**
 *  用于储存需要发送到服务端的数据
 *
 *  @param data         文件的二进制数据
 *  @param name         服务器对应的参数名称
 *  @param objecORBName 文件的名称（上传到服务器后，服务器保存的文件名）
 *  @param type         文件的类型(image/png,image/jpg等)
 *
 *  @return ORBNet的对象
 */


-(instancetype)initWithData:(NSData *)data parameterName:(NSString *)name objectName:(NSString *)objecORBName fileType:(NSString *)type{
    if (self = [super init]) {
        self.data = data;
        self.name = name;
        self.filename = objecORBName;
        self.mimeType = type;
    }
    return self;

}

/**
 *  用于储存需要发送到服务器的数据
 *
 *  @param data         文件的二进制数据
 *  @param name         服务器对应的参数名称
 *  @param objecORBName 文件的名称（上传到服务器后，服务器保存的文件名）
 *  @param type         文件的MIME类型(image/png,image/jpg等)
 *
 *  @return ORBNet的对象
 */
+(ORBNet *)data:(NSData *)data parameterName:(NSString *)name objectName:(NSString *)objecORBName fileType:(NSString *)type{
    ORBNet *model = [[ORBNet alloc]initWithData:data parameterName:name objectName:objecORBName fileType:type];
    return model;
}
@end
