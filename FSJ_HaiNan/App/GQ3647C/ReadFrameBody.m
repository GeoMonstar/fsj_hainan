//
//  ReadFrameBody.m
//  FSJ_HaiNan
//
//  Created by Monstar on 2016/12/8.
//  Copyright © 2016年 Monstar. All rights reserved.
//

#import "ReadFrameBody.h"
@interface ReadFrameBody()
@end

@implementation ReadFrameBody

- (instancetype)initWithFsjID:(NSString *)fsjID FunctionCode:(NSString *)functionCode ParameterID:(NSArray *)parameterID{
    self = [super init];
    if (self) {
        self.fsjID = fsjID;
        self.functionCode = functionCode;
        self.parameterID = parameterID;
    }
    return self;

}
#pragma mark --生成 读命令
- (NSData *)readData{
    
    NSMutableString *mutStr = [NSMutableString string];
    for (NSString *str in self.parameterID) {
        [mutStr appendString:str];
    }
    NSString *len = [[NSString stringWithFormat:@"%ld",(long)self.parameterID.count*2] ToHex2];
    NSString * string = [NSString stringWithFormat:@"%@%@%@%@",self.fsjID,self.functionCode,len,mutStr];
    
    return [self addCRC16StrBaseString:string];
}
//根据 发射机id 功能码 参数表 生成 crc16
- (NSData *)addCRC16StrBaseString:(NSString *)baseString{
    NSInteger length = baseString.length/2;
    //string 转 bytes数组
    
    Byte testByte[length];
    for (int i = 0; i < baseString.length/2; i++) {
        NSRange range = NSMakeRange(i*2, 2);
        NSString* hexStr = [baseString substringWithRange:range];
        testByte[i] =  *(Byte *)[[hexStr hexToBytes] bytes];
    }
    //生成crc16
    uint16_t jiaoyan = count_CRC(testByte, baseString.length/2);
    //转16进制 小端在前
    
    NSString *str = [self ToHex:jiaoyan];
    NSString * result = [NSString stringWithFormat:@"%@%@",baseString,str];
    NSData *framedata = [result hexToBytes];
    return framedata;
}

- (NSString *)ToHex:(uint16_t)tmpid
{
    NSString *nLetterValue;
    NSString *str =@"";
    uint16_t ttmpig;
    for (int i = 0; i<9; i++) {
        ttmpig=tmpid%16;
        tmpid=tmpid/16;
        switch (ttmpig)
        {
            case 10:
                nLetterValue =@"A";break;
            case 11:
                nLetterValue =@"B";break;
            case 12:
                nLetterValue =@"C";break;
            case 13:
                nLetterValue =@"D";break;
            case 14:
                nLetterValue =@"E";break;
            case 15:
                nLetterValue =@"F";break;
            default:
                nLetterValue = [NSString stringWithFormat:@"%u",ttmpig];
        }
        str = [nLetterValue stringByAppendingString:str];
        if (tmpid == 0) {
            break;
        }
    }
    NSString *head = [str substringFromIndex:2];
    NSString *tail = [str substringToIndex:2];
    str = [NSString stringWithFormat:@"%@%@",head,tail];
    return str;
}
//data转16进制字符串
- (NSString *)convertDataToHexStr:(NSData *)data
{
    if (!data || [data length] == 0) {
        return @"";
    }
    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:[data length]];
    
    [data enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
        unsigned char *dataBytes = (unsigned char*)bytes;
        for (NSInteger i = 0; i < byteRange.length; i++) {
            NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) & 0xff];
            if ([hexStr length] == 2) {
                [string appendString:hexStr];
            } else {
                [string appendFormat:@"0%@", hexStr];
            }
        }
    }];
    return string;
}
#pragma mark -- 响应读  返回测试字符串
- (NSArray *)responsReadData:(NSData *)data{
    
    
    NSString *str = [self convertDataToHexStr:data];
    
    if (str.length < 56) {
        VVDLog(@"响应 读 错误");
    }
    NSArray *headArr = [self getHead:str];
    NSArray *bodyArr = [self getBody:str];
    NSMutableArray *result = @[].mutableCopy;
    
    [result addObject:headArr];
    [result addObject:bodyArr];
    VVDLog(@"%@",result);
    return result;
}
//解析帧体 利用参数数组
- (NSArray *)getBody:(NSString *)str{

    NSString *bodyStr = [str substringFromIndex:56];
    
    
    bodyStr = [bodyStr substringToIndex:bodyStr.length-4];
    //备用字段
//    NSString *crc16Str = [bodyStr substringFromIndex:bodyStr.length-4];
//    NSString *shebeidizhiStr = [bodyStr substringToIndex:2];
//    NSString *mingliStr = [bodyStr substringWithRange:NSMakeRange(2, 2)];
//    
//    NSString *lengthStr = [bodyStr substringWithRange:NSMakeRange(4, 4)];
    NSString *paramStr = [bodyStr substringFromIndex:8];
    
    return [self recursionResult:paramStr];
}

//递归分割 依次取出parno 和 value
- (NSArray *)recursionResult:(NSString *)resultStr{
    
    NSMutableArray *modelArr = @[].mutableCopy;
    
    while (resultStr.length >0){
        NSString *parnoStr = [resultStr substringToIndex:4];
        long i = strtoul([[resultStr substringWithRange:NSMakeRange(4, 2)] UTF8String],0,16)*2;
        NSString *parameterValueStr = [resultStr substringWithRange:NSMakeRange(6, i)];
        resultStr = [resultStr substringFromIndex:6+i];
        // VVDLog(@"%@--%@",parnoStr,parameterValueStr);
        ParameterModel *model = [ParameterModel getModelByparno:parnoStr];
        
        model.parameterValue = parameterValueStr;
        [modelArr addObject:[model getResult:model]];
       
        if (resultStr.length <1) {
            break;
        }
    };
    return modelArr;
}
//帧头 格式固定
- (NSArray *)getHead:(NSString *)str{
    NSString *headStr = [str substringToIndex:56];
    NSMutableArray *mutArr = @[].mutableCopy;
    NSArray *paraArr = @[BaseInfo0100,BaseInfo0300,BaseInfo0400,BaseInfo0800,BaseInfo0500];
    for (NSString *parno in paraArr) {
        ParameterModel *model = [ParameterModel getModelByparno:parno];
        
        if ([parno isEqualToString:@"0100"]) {
           
            model.parameterValue = [headStr substringWithRange:NSMakeRange(2, 34)];
            [mutArr addObject:[model getResult:model]];
        }
        if ([parno isEqualToString:@"0300"]) {
            model.parameterValue =  [headStr substringWithRange:NSMakeRange(44, 4)];
            [mutArr addObject:[model getResult:model]];
        }
        if ([model.parno isEqualToString:@"0400"]) {
            model.parameterValue =  [headStr substringWithRange:NSMakeRange(48, 4)];
            [mutArr addObject:[model getResult:model]];
        }
        //本地写死
        if ([parno isEqualToString:@"0800"]) {
            model.parameterValue =  [headStr substringWithRange:NSMakeRange(36, 4)];
            [mutArr addObject:[model getHead:model]];
        }
        if ([parno isEqualToString:@"0500"]) {
            model.parameterValue =  [headStr substringWithRange:NSMakeRange(40, 4)];
            [mutArr addObject:[model getHead:model]];
        }
    }
    
    return mutArr;
}

#pragma mark -- 响应读 返回模型
- (NSDictionary *)responsReadDataWithData:(NSData *)data andFSJID:(NSString *)fsjId{
    
    NSString *str = [self convertDataToHexStr:data];
    
    if (str.length < 56) {
        VVDLog(@"响应 读 错误");
    }
    NSDictionary *headDic = [self getHeadWithStr:str];
    NSDictionary *bodyDic = [self getBodyWithStr:str];
    VVDLog(@"解析题字典个数 %ld",bodyDic.allKeys.count);
    
//    OneFSJModel *model = [[OneFSJModel alloc]initOneFSJModelWithID:fsjId andHeadValueDictionary:headDic andBodyValueDictionary:bodyDic];
//    [[EGOCache globalCache]setObject:(OneFSJModel *) model forKey:fsjId];
    
    
    return @{@"head":headDic,@"body":bodyDic};
}
//帧头 格式固定
- (NSDictionary *)getHeadWithStr:(NSString *)str{
    NSString *headStr = [str substringToIndex:56];
    NSMutableDictionary *mutDic = @{}.mutableCopy;
    NSArray *paraArr = @[BaseInfo0100,BaseInfo0300,BaseInfo0400,BaseInfo0800,BaseInfo0500];
 //   NSArray *paraArr = @[@"0x0001",@"0x0003",@"0x0004",@"0x0008",@"0x0005"];
    for (NSString *parno in paraArr) {
        ParameterModel *model = [ParameterModel getModelByparno:parno];
        
        if ([parno isEqualToString:@"0100"]) {
            
            model.parameterValue = [headStr substringWithRange:NSMakeRange(2, 34)];
            [mutDic setObject:[model getResult:model] forKey:parno];
           
        }
        if ([parno isEqualToString:@"0300"]) {
            model.parameterValue =  [headStr substringWithRange:NSMakeRange(44, 4)];
            
           [mutDic setObject:[model getResult:model] forKey:parno];
        }
        if ([model.parno isEqualToString:@"0400"]) {
            model.parameterValue =  [headStr substringWithRange:NSMakeRange(48, 4)];
            [mutDic setObject:[model getResult:model] forKey:parno];
        }
        //本地写死
        if ([parno isEqualToString:@"0800"]) {
            model.parameterValue =  [headStr substringWithRange:NSMakeRange(36, 4)];
            [mutDic setObject:[model getResult:model] forKey:parno];
        }
        if ([parno isEqualToString:@"0500"]) {
            model.parameterValue =  [headStr substringWithRange:NSMakeRange(40, 4)];
            [mutDic setObject:[model getResult:model] forKey:parno];
        
        }
    }
    
    return mutDic;
}
//解析帧体 利用参数数组
- (NSDictionary *)getBodyWithStr:(NSString *)str{
    
    NSString *bodyStr = [str substringFromIndex:56];
    
    
    bodyStr = [bodyStr substringToIndex:bodyStr.length-4];
   
    //备用字段
    //    NSString *crc16Str = [bodyStr substringFromIndex:bodyStr.length-4];
    //    NSString *shebeidizhiStr = [bodyStr substringToIndex:2];
    //    NSString *mingliStr = [bodyStr substringWithRange:NSMakeRange(2, 2)];
    //
    //    NSString *lengthStr = [bodyStr substringWithRange:NSMakeRange(4, 4)];
    NSString *paramStr = [bodyStr substringFromIndex:8];
    
    return [self recursionResultWithStr:paramStr];
}

//递归分割 依次取出parno 和 value
- (NSDictionary *)recursionResultWithStr:(NSString *)resultStr{
    NSMutableDictionary *modelDic = @{}.mutableCopy;
    while (resultStr.length >0){
                NSString *parnoStr = [resultStr substringToIndex:4];
        long i = strtoul([[resultStr substringWithRange:NSMakeRange(4, 2)] UTF8String],0,16)*2;
        
        NSString *parameterValueStr = [resultStr substringWithRange:NSMakeRange(6, i)];
        resultStr = [resultStr substringFromIndex:6+i];
        
        ParameterModel *model = [ParameterModel getModelByparno:parnoStr ];
        
        model.parameterValue = parameterValueStr;
        if (model) {
            [modelDic setObject:[model getResult:model] forKey:model.parno];
        }else{
            VVDLog(@"%@",parnoStr);
        }
        if (resultStr.length <1) {
            break;
        }
    };

    return modelDic;
}
@end
