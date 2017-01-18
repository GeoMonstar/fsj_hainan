//
//  ReadFrameBody.h
//  FSJ_HaiNan
//
//  Created by Monstar on 2016/12/8.
//  Copyright © 2016年 Monstar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CRC16.h"
//#import "NSString+NSStringHexToBytes.h"
//#import "ParameterModel.h"
//#import "ParametersList.h"
//#import "EGOCache.h"
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
/**
 *  生成 读 命令
 */
- (NSData *)readData;

/**
 *  响应 读 帧体和帧体一起解析
 *
 *  @param data 返回数据
 *  @return 解析结果数组
 */
- (NSArray *)responsReadData:(NSData *)data;
/**
 *  响应 读 帧体和帧体一起解析
 *
 *  @param data 返回数据
 *  @return 一个发射机模型需要的字典
 */
- (NSDictionary *)responsReadDataWithData:(NSData *)data andFSJID:(NSString *)fsjId;



//  添加 crc16
- (NSData *)addCRC16StrBaseString:(NSString *)baseString;
//  10 进制数字转16
- (NSString *)ToHex:(uint16_t)tmpid;
//  data 转16进制字符串
- (NSString *)convertDataToHexStr:(NSData *)data;
@end
