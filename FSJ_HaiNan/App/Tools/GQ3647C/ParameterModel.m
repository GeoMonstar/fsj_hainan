//
//  ParameterModel.m
//  FSJ_HaiNan
//
//  Created by Monstar on 2016/12/12.
//  Copyright © 2016年 Monstar. All rights reserved.
//

#import "ParameterModel.h"
#import "NSString+NSStringHexToBytes.h"

typedef union { float f; uint32_t i; } FloatInt;

@implementation ParameterModel
+ (instancetype)initWithDictionary:(NSDictionary *)dictionary{
    ParameterModel *model = [self mj_objectWithKeyValues:dictionary];
    return model;
}
+ (ParameterModel *)getModelByparno:(NSString *)parno{
    NSMutableArray *mutArr = @[].mutableCopy;
    NSString * jsonPath = [[NSBundle mainBundle]pathForResource:@"ParametersList" ofType:@"json"];
    NSData * jsonData = [[NSData alloc]initWithContentsOfFile:jsonPath];
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    NSArray *jsonArr = [[[jsonDic objectForKey:@"tables"]objectForKey:@"parameter"]objectForKey:@"item"];
    
    for (NSDictionary *dic in jsonArr) {
        ParameterModel *model = [ParameterModel initWithDictionary:dic];
        [mutArr addObject:model];
    }
    
    for (ParameterModel *model  in mutArr) {
        if ([model.parno isEqualToString:parno]) {
            return model;
        }
    }
    return nil;
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"deci":@"-deci",@"detail":@"-detail",@"len":@"-len",@"name":@"-name",@"parno":@"-parno",@"type":@"-type"};
}
- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{
    NSString *oldValueStr = (NSString *)oldValue;
    //"0x0001"转0100
    if ([property.name isEqualToString: @"parno"]) {
         NSMutableString *mutstr = [NSMutableString string];
        for ( NSInteger i = oldValueStr.length/2-1; i > 0; i --) {
            NSString *tempstr =  [oldValueStr substringWithRange:NSMakeRange(i*2, 2)];
            tempstr= [tempstr lowercaseString];
            [mutstr appendString:tempstr];
        }
        return mutstr;
    }
    
    return oldValue;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    
}

#pragma mark 方法
//写
- (NSString *)createResult:(ParameterModel *)model{
    NSString *str =[NSString stringWithFormat:@"%@生成错误",model.name];
    NSMutableString *mutstr = [NSMutableString string];
    //    V_TIMEARRAY	时间表类型	6*n字节	- 时分秒 12:10:12
    if ([model.type isEqualToString:@"V_TIMEARRAY"]) {
        
        for (int i = 0; i< model.parameterValue.length/6; i++) {
            NSString *arrStr =  [model.parameterValue substringWithRange:NSMakeRange(i*6, 6)];
            NSInteger time;
            for ( NSInteger j=0 ; j < arrStr.length/2 ; j++) {
                NSString *tempstr =  [arrStr substringWithRange:NSMakeRange(j*2, 2)];
                                //16进制字符串转10进制数字转ascii
                time  += [tempstr integerValue] * pow(60, (2-j));
               
           }
            [mutstr appendString:[[NSString stringWithFormat:@"%ld",time] ToHex3]];
        }
        return mutstr;
    }
    //    V_UINT_IP	IP地址类型	固定4字节	-
    if ([model.type isEqualToString:@"V_UINT_IP"]) {
        NSArray *strArr = [model.parameterValue componentsSeparatedByString:@"."];
        
        for (NSString * str  in strArr) {
            [mutstr appendString:[str ToHex]];
        }
        return mutstr;        
    }
    //    V_UNIXTIME	64位Unix时间戳	固定8字节	-
    if ([model.type isEqualToString:@"V_UNIXTIME"]) {
        NSDateFormatter *format=[[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
        NSDate *fromdate=[format dateFromString:model.parameterValue];
        NSTimeZone *zone = [NSTimeZone localTimeZone];
        NSInteger interval = [zone secondsFromGMTForDate:fromdate];
        NSDate *localeDate = [fromdate  dateByAddingTimeInterval:interval];
        long  time= [localeDate timeIntervalSince1970];
        return [[NSString stringWithFormat:@"%ld",time]ToHex8];
    }
        //    V_ENUM_BIT	枚举位	可变根据len参数定义	枚举位的定义
    if ([model.type isEqualToString:@"V_ENUM_BIT"]){
        
        //暂定直接value为 各枚举的和 10进制
        if ([model.len isEqualToString:@"1"]) {
            return  [model.parameterValue ToHex];
        }
        else if ([model.len isEqualToString:@"4"]) {
            return  [model.parameterValue ToHex4];
        }else{
            VVDLog(@"V_ENUM_BIT 未知长度")
        }
    }
    //    V_FLOAT	单精度浮点数	固定4字节
    if ([model.type isEqualToString:@"V_FLOAT"]) {
         NSScanner *scanner = [NSScanner scannerWithString:model.parameterValue];
         FloatInt fl;
        if([scanner scanFloat:&fl.f])        //
        {
            //得到float对应十进制再转换hex
            str = [[NSString stringWithFormat:@"%u",fl.i] ToHex4];
        }
        else
        {
            VVDLog(@"float转换错误");
        }
        for ( NSInteger i = [model.len  integerValue]-1; i >= 0; i --) {
            
            NSString *tempstr =  [str substringWithRange:NSMakeRange(i*2, 2)];
            [mutstr appendString:tempstr];
        }
        return mutstr;
    }
    //    V_UINT	无符号整型	固定4字节	参数单位 暂时不可写
    if ([model.type isEqualToString:@"V_UINT"]) {
        return  [model.parameterValue ToHex];
    }
    //    V_UCHAR	无符号单字节	固定1字节	参数单位
    if ([model.type isEqualToString:@"V_UCHAR"]) {
        return  [model.parameterValue ToHex];
    }
    //    V_ENUM	枚举型	固定1字节	-
    if ([model.type isEqualToString:@"V_ENUM"]) {
        return  [model.parameterValue ToHex];
    }
    //    V_USHORT	无符号短整型	由deci定义精度	参数单位
    if ([model.type isEqualToString:@"V_USHORT"]) {
        return  [model.parameterValue ToHex2];
    }

    //    V_STRING	字符串类型	根据len参数定义	-
    if ([model.type isEqualToString:@"V_STRING"] && [model.detail isEqualToString:@"-"]) {
        for ( int i = 0; i < [model.len integerValue]; i ++) {
            if (i<model.parameterValue.length) {
                int asciiCode  = [model.parameterValue characterAtIndex:i];
                [mutstr appendString: [[NSString stringWithFormat:@"%d",asciiCode] ToHex]];
            }else{
                [mutstr appendString:@"00"];
            }
          
        }
        return mutstr;
    }
    if ([model.type isEqualToString:@"V_STRING"] && [model.detail isEqualToString:@"字符串"]) {
        NSStringEncoding enc =CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        NSString *gbkStr = [self convertDataToHexStr:[model.parameterValue dataUsingEncoding:enc]];
        [mutstr appendString:gbkStr];
        for (long i = gbkStr.length/2; i<[model.len integerValue]; i++) {
            [mutstr appendString:@"00"];
        }
        return mutstr;
        
    }
        return str;
}
//读
- (NSString *)getResult:(ParameterModel *)model{
    NSString *str =[NSString stringWithFormat:@"%@解析错误",model.name];
    NSMutableString *mutstr = [NSMutableString string];
//    V_STRING	字符串类型	根据len参数定义	-
    if ([model.type isEqualToString:@"V_STRING"] && [model.detail isEqualToString:@"-"]) {
        for ( int i = 0; i < model.parameterValue.length/2; i ++) {
            
            NSString *tempstr =  [model.parameterValue substringWithRange:NSMakeRange(i*2, 2)];
            if ([tempstr isEqualToString:@"00"] ) {
                //暂时空位
            }else{
                //16进制字符串转10进制数字转ascii
                NSString * tenStr = [NSString stringWithFormat:@"%ld",strtoul([tempstr UTF8String],0,16)];
                unichar asciiCode = [tenStr intValue];
                tenStr = [NSString stringWithFormat:@"%c",asciiCode];
                [mutstr appendString:tenStr];
            }
        }
        return mutstr;
    }
    if ([model.type isEqualToString:@"V_STRING"] && [model.detail isEqualToString:@"字符串"]) {
        NSStringEncoding enc =CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        NSData *data = [model.parameterValue hexToBytes];
        NSString *str = [[NSString alloc]initWithData:data encoding:enc];
        
        return str;
        
    }
//    V_USHORT	无符号短整型	由deci定义精度	参数单位
    if ([model.type isEqualToString:@"V_USHORT"]) {
        for ( NSInteger i = model.parameterValue.length/2-1; i >= 0; i --) {
            NSString *tempstr =  [model.parameterValue substringWithRange:NSMakeRange(i*2, 2)];
            //16进制字符串转10进制数字转ascii
            [mutstr appendString:tempstr];
        }
        return [NSString stringWithFormat:@"%ld",strtoul([mutstr UTF8String],0,16)];
    }
//    V_ENUM	枚举型	固定1字节	-
    if ([model.type isEqualToString:@"V_ENUM"]) {
        return [NSString stringWithFormat:@"%ld",strtoul([model.parameterValue UTF8String],0,16)];
    }
    
//    V_UCHAR	无符号单字节	固定1字节	参数单位
    if ([model.type isEqualToString:@"V_UCHAR"]) {
        return [NSString stringWithFormat:@"%ld",strtoul([model.parameterValue UTF8String],0,16)];
    }
//    V_UINT	无符号整型	固定4字节	参数单位
    if ([model.type isEqualToString:@"V_UINT"]) {
        for ( NSInteger i = model.parameterValue.length/2-1; i >= 0; i --) {
            NSString *tempstr =  [model.parameterValue substringWithRange:NSMakeRange(i*2, 2)];
            //16进制字符串转10进制数字转ascii
            [mutstr appendString:tempstr];
        }
        return [NSString stringWithFormat:@"%ld",strtoul([mutstr UTF8String],0,16)];
    }
//    V_FLOAT	单精度浮点数	固定4字节
    if ([model.type isEqualToString:@"V_FLOAT"]) {
        for ( NSInteger i = model.parameterValue.length/2-1; i >= 0; i --) {
            NSString *tempstr =  [model.parameterValue substringWithRange:NSMakeRange(i*2, 2)];
            //16进制字符串转10进制数字转ascii
            [mutstr appendString:tempstr];
        }
        FloatInt fl;
        
        NSScanner *scanner = [NSScanner scannerWithString:mutstr];
        if([scanner scanHexInt:&fl.i])        // scan into the i field
        {
            return [NSString stringWithFormat:@"%.2f",fl.f];
        }
        else
        {
            VVDLog(@"float转换错误");
        }
        
    }
//    V_ENUM_BIT	枚举位	可变根据len参数定义	枚举位的定义，使用;枚举位定义 90 = 144 = 2^4+2^7 
    if ([model.type isEqualToString:@"V_ENUM_BIT"]) {
        //暂定
        int num = [model.len integerValue] == 1?8:16;
        NSMutableArray *arr = @[].mutableCopy;
        for (int i = 0; i< num; i++) {
            [arr addObject:[NSString stringWithFormat:@"%d",1<<i]];
        }
        
        long result = strtoul([model.parameterValue UTF8String],0,16);
        for (int i = 1; i < 1<<num; i++) {
            int sum = 0;
            NSMutableArray *mutArr = @[].mutableCopy;
            for (int j=0;j<num;j++) {
                if ((i & 1<<j) !=0) {
                    sum += [arr[j] intValue];
                    [mutArr addObject:[NSString stringWithFormat:@"%d",j]];
                }
            }
            if (sum == result) {
                //返回序号
                for (NSString *str  in mutArr) {
                    return str;
                }
            }
        }
    }
//    V_UNIXTIME	64位Unix时间戳	固定8字节	-
    if ([model.type isEqualToString:@"V_UNIXTIME"]) {
        for ( NSInteger i = model.parameterValue.length/2-1; i >= 0; i --) {
            NSString *tempstr =  [model.parameterValue substringWithRange:NSMakeRange(i*2, 2)];
            //16进制字符串转10进制数字转ascii
            [mutstr appendString:tempstr];
        }
        long Timesp = strtoul([mutstr UTF8String],0,16);
        NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:Timesp];
        NSTimeZone *zone = [NSTimeZone localTimeZone];
        NSInteger interval = [zone secondsFromGMTForDate:confromTimesp];
        //时差处理 有问题？
        NSDate *localeDate = [confromTimesp  dateByAddingTimeInterval: -interval];
        NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
        [dateFormat setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
        NSString* string=[dateFormat stringFromDate:localeDate];
        
        return string;
    }
//    V_UINT_IP	IP地址类型	固定4字节	-
    if ([model.type isEqualToString:@"V_UINT_IP"]) {
        for ( int i = 0; i < model.parameterValue.length/2; i ++) {
            NSString *tempstr =  [model.parameterValue substringWithRange:NSMakeRange(i*2, 2)];
            if ([tempstr isEqualToString:@"00"] ) {
                //暂时空位
                [mutstr appendString:@"0"];
            }else{
                //16进制字符串转10进制数字转ascii
                NSString * tenStr = [NSString stringWithFormat:@"%ld",strtoul([tempstr UTF8String],0,16)];
                tenStr = [NSString stringWithFormat:@"%d",[tenStr intValue]];
                [mutstr appendString:tenStr];
            }
            if (i < model.parameterValue.length/2 -1) {
                [mutstr appendString:@"."];
            }
        }
        return mutstr;
    }
//    V_TIMEARRAY	时间表类型	6*n字节	- 时分秒
    if ([model.type isEqualToString:@"V_TIMEARRAY"]) {
         //先分割每组
        for (NSInteger i = 0 ; i < (model.parameterValue.length/6) ; i ++){
             NSString *arrStr =  [model.parameterValue substringWithRange:NSMakeRange(i*6, 6)];
            //再取值
            for ( NSInteger j = arrStr.length/2-1; j >= 0; j --) {
                NSString *tempstr =  [arrStr substringWithRange:NSMakeRange(j*2, 2)];
                //16进制字符串转10进制数字转ascii
                [mutstr appendString:tempstr];
            }
            long timeNum =strtoul([mutstr UTF8String],0,16);
            return [NSString stringWithFormat:@"%ld:%ld:%ld",timeNum/3600,timeNum/60%60,timeNum%60];
        }
    }
//    V_HEX	16进制数据	可变根据len参数定义	-
    if ([model.type isEqualToString:@"V_HEX"]) {
        
        for ( int i = 0; i < model.parameterValue.length/2; i ++) {
            NSString *tempstr =  [model.parameterValue substringWithRange:NSMakeRange(i*2, 2)];
            [mutstr appendString:tempstr];
            if (i < model.parameterValue.length/2 -1) {
                [mutstr appendString:@" "];
            }
        }
        return mutstr;
    }

    return str;
}
- (NSString *)getHead:(ParameterModel *)model{
   
    if ([model.name isEqualToString:@"设备类型码"]) {
        switch ([model.parameterValue integerValue]) {
            case 100:
                return @"模拟电视发射机";
                break;
            case 200:
                return @"调频广播发射机";
                break;
            case 300:
                return @"地面数字电视广播发射机";
                break;
            case 400:
                return @"移动多媒体广播发射机（CMMB）";
                break;
            case 500:
                return @"中波广播发射机";
                break;
            case 600:
                return @"短波广播发射机";
                break;
            case 700:
                return @"短波跳频发射机";
                break;
            case 800:
                return @"收转式地面数字电视广播发射机";
                break;
                
            default:
                break;
        }
        return 0;
    }
    if ([model.name isEqualToString:@"生产厂家"]) {
        switch ([model.parameterValue integerValue]) {
            case 100:
                return @"凯腾四方";
                break;
            case 200:
                return @"成都成广";
                break;
            case 300:
                return @"成都康特";
                break;
            case 400:
                return @"北京吉兆";
                break;
            case 500:
                return @"陕西数广";
                break;
            case 600:
                return @"成都德芯";
                break;
            case 700:
                return @"辽宁普天";
                break;
            case 800:
                return @"高斯贝尔";
                break;
            case 900:
                return @"南京熊猫";
                break;
            case 1000:
                return @"RVR";
                break;
                
            case 2000:
                return @"上海明珠";
                break;
            case 2100:
                return @"哈广";
                break;
            case 2200:
                return @"哈尔滨正泰";
                break;
            case 2300:
                return @"北广";
                break;
                
            default:
                break;
        }
        return 0;
    }
    return 0;
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
    
    return str;
}
MJExtensionCodingImplementation
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

@end
