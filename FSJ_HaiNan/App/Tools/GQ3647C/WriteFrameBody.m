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


@end
