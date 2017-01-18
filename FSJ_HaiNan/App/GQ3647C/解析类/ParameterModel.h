//
//  ParameterModel.h
//  FSJ_HaiNan
//
//  Created by Monstar on 2016/12/12.
//  Copyright © 2016年 Monstar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
typedef NS_ENUM(NSInteger, ParameterType){

//基础参数类型
    
    ByteType = 0 ,//无符号，0-255
    UInt16Type =1,//无符号，0-65535
    UInt32Type=2,//无符号，0- 429496729
    FloatType=3,//-3.4 × 10^38 到 +3.4 × 10^38
    BitType=4,//占用1字节，但取值时主要利用1个字节内的八个位，bit0-bit7。二进制表示。
    StringType=5,//表示一个字符串，长度不固定。编码采用GB2312—1980标准。
    DatetimeType=6,//64位Unix时间戳

//特殊参数类型
    
    DevType=7,//设备类型码表
    MfrCode=8,//厂家编号表
    CoolingMode=9,//设备冷却方式表
    Schedule=10,/*每条定时6字节（开时分秒关时分秒，BCD码），左对齐，条与条之间是“或”相关。
                全天开机：00:00:00-23:59:59
                定时检测结束：00:00:00-00:00:00*/
    IPType=11,//每段1字节，Byte。如IP为“192.168.1.1”，发送时192在前。
    MacType=12,//每段1字节，Byte。如Mac为“00:2E:36:49:FF:E0”，发送时00在前。
    ContReadType = 13,//起始参数编号(2字节,UInt16)，结束参数编号(2字节,UInt16)
    AutoMsgCfgType=14,//自动报文参数序号1，自动报文参数序号2……自动报文参数序号N
    BitOp=15,//参数编号(2字节),位偏移（1字节)
    ByteOp=16,//参数编号(2字节),运算数值(1字节)
    UShortOp=17,//参数编号(2字节),运算数值(2字节，UInt16)
    SingleOp=18//参数编号(2字节),运算数值(4字节，Single)
    
};

typedef NS_ENUM(NSInteger, ParameterStatus){
    R = 0,
    W = 1,
    RW = 2
    
};

@interface ParameterModel : NSObject

//@property (nonatomic, copy)     NSString *parameterNum;

//@property (nonatomic, copy)     NSString *parametername;

//@property (nonatomic, copy)     NSString  *parameterLength;

//@property (nonatomic, assign)   ParameterType parameterType;
/**
 *  参数读写 0 可读 1 可写 2 可读写
 */
@property (nonatomic, assign)   ParameterStatus parameterStatus;


/**
 *  返回串口信息值
 */
@property (nonatomic, copy)     NSString  *parameterValue;
/**
 *  数据精度
 */
@property (nonatomic, copy)     NSString  *deci;
/**
 *  数据描述
 */
@property (nonatomic, copy)     NSString  *detail;
/**
 *  数据长度
 */
@property (nonatomic, copy)     NSString  *len;
/**
 *  参数名称
 */
@property (nonatomic, copy)     NSString  *name;
/**
 *  参数序号
 */
@property (nonatomic, copy)     NSString  *parno;
/**
 *  参数类型 根据类型处理不同数据
 */
@property (nonatomic, copy)     NSString  *type;


+ (instancetype)initWithDictionary:(NSDictionary *)dictionary;

/**
 *  读 返回解析字段 根据模型value和type返回解析值
 *
 *  @param model 数据模型
 *  @return 解析结果
 */
- (NSString *)getResult:(ParameterModel *)model;

/**
 *  写 生成串口命令
 *
 *  @param model 数据模型
 *  @return 串口命令
 */
- (NSString *)createResult:(ParameterModel *)model;
/**
 *  解析 帧头
 *
 *  @param model 数据模型
 *  @return 帧体信息
 */
- (NSString *)getHead:(ParameterModel *)model;

/**
 *  根据 参数序号读取参数模型
 *
 *  @param parno 参数序号
 *  @return 参数模型
 */
+ (ParameterModel *)getModelByparno:(NSString *)parno;
@end
