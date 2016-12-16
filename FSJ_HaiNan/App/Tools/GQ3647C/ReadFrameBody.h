//
//  ReadFrameBody.h
//  FSJ_HaiNan
//
//  Created by Monstar on 2016/12/8.
//  Copyright © 2016年 Monstar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CRC16.h"
#import "NSString+NSStringHexToBytes.h"
#import "ParameterModel.h"
#import "ParametersList.h"
#import "EGOCache.h"
@interface ReadFrameBody : NSObject
//设备ID
@property (nonatomic,copy)NSString *fsjID;
//功能码
@property (nonatomic,copy)NSString *functionCode;
//数据长度
@property (nonatomic,copy)NSString *dataLength;
//参数序号
@property (nonatomic,copy)NSArray *parameterID;
//参数序号
@property (nonatomic,copy)NSDictionary *parameterDic;


- (instancetype)initWithFsjID:(NSString *)fsjID FunctionCode:(NSString *)functionCode ParameterID:(NSArray *)parameterID;
//生成 读 命令
- (NSData *)readData;
//响应读 帧体和帧体一起解析
- (NSArray *)responsReadData:(NSData *)data andParameterArr:(NSArray *)paramArr;

//添加crc16
- (NSData *)addCRC16StrBaseString:(NSString *)baseString;
//10进制数字转16
- (NSString *)ToHex:(uint16_t)tmpid;
//data转16进制字符串
- (NSString *)convertDataToHexStr:(NSData *)data;
@end
