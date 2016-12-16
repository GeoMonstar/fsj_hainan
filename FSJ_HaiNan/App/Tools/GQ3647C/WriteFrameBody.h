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

//写命令
- (NSData *)writeData;


////响应读 帧体和帧体一起解析
//- (NSArray *)responsReadData:(NSData *)data andParameterArr:(NSArray *)paramArr;





@end
