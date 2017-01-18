//
//  WriteFrameBody.m
//  FSJ_HaiNan
//
//  Created by Monstar on 2016/12/8.
//  Copyright © 2016年 Monstar. All rights reserved.
//

#import "WriteFrameBody.h"
@interface WriteFrameBody(){


}
@end

@implementation WriteFrameBody
- (instancetype)initWithFsjID:(NSString *)fsjID
                 FunctionCode:(NSString *)functionCode
              ParameterdicArr:(NSArray *)parameterdicArr{

    self = [super init];
    if (self) {
        self.fsjID = fsjID;
        self.functionCode = functionCode;
        self.parameterID = parameterdicArr;
    }
    return self;
}
#pragma mark --生成 写命令
- (NSData *)writeData{
    NSMutableString *mutStr = [NSMutableString string];
    for (NSDictionary *dic in self.parameterID) {
        ParameterModel *model = [ParameterModel getModelByparno:dic.allKeys[0]];
        model.parameterValue = dic.allValues[0];
        //先拼 参数和长度
        [mutStr appendFormat:@"%@%@",model.parno,[model.len ToHex]];
        [mutStr appendString:[model createResult:model]];
    }
    NSString *len = [[NSString stringWithFormat:@"%ld",mutStr.length/2] ToHex2];
    NSString * string = [NSString stringWithFormat:@"%@%@%@%@",self.fsjID,self.functionCode,len,mutStr];
    return [self addCRC16StrBaseString:string];
}
#pragma mark --响应 写命令
- (NSArray *)responsWriteData:(NSData *)data{
    
    NSString *str = [self convertDataToHexStr:data];
    if (str.length < 56) {
        VVDLog(@"响应 写 错误");
    }
     NSArray *bodyArr = [self getWriteBody:str];
    
     return bodyArr;
}
//解析帧体 利用参数数组
- (NSArray *)getWriteBody:(NSString *)str{
    NSMutableArray *result = @[].mutableCopy;
    //    NSMutableArray *parmMut = @[].mutableCopy;
    
    //备用字段
    NSString *bodyStr = [str substringFromIndex:56];
    NSString *mingliStr = [bodyStr substringWithRange:NSMakeRange(2, 2)];
    bodyStr = [bodyStr substringToIndex:bodyStr.length-4];
    NSString *paramStr = [bodyStr substringFromIndex:8];
    
    if ([mingliStr isEqualToString:@"10"]) {
        //写成功
        return nil;
    }else{
        // 分割参数表 返回写错误参数
        for (int i = 0; i<paramStr.length/4; i++) {
            [result addObject:[paramStr substringWithRange:NSMakeRange(i*4, 4)]];
        }
    }
    return result;
}
@end
