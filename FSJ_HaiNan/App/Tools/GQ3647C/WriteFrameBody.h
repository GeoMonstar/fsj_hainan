//
//  WriteFrameBody.h
//  FSJ_HaiNan
//
//  Created by Monstar on 2016/12/8.
//  Copyright © 2016年 Monstar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReadFrameBody.h"
@interface WriteFrameBody : ReadFrameBody



- (instancetype)initWithFsjID:(NSString *)fsjID
                 FunctionCode:(NSString *)functionCode
                 ParameterdicArr:(NSArray *)parameterdicArr;

/**
 *  生成 写命令
 */
- (NSData *)writeData;

/**
 *  响应写 帧体和帧体一起解析
 *
 *  @param data 返回数据
 *  @return 写错误参数表 0为没错误
 */
- (NSArray *)responsWriteData:(NSData *)data;





@end
