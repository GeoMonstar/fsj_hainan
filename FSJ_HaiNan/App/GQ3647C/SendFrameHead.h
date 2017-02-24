//
//  SendFrameHead.h
//  FSJ_HaiNan
//
//  Created by Monstar on 2016/12/8.
//  Copyright © 2016年 Monstar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SendFrameHead : NSObject
/**
 * @brief 命令类型吗
 */
@property (nonatomic,copy)NSString *head;
/**
 * @brief 站台编码
 */
@property (nonatomic,copy)NSString *fsjAddressCode;
/**
 * @brief 预留字段
 */
@property (nonatomic,copy)NSString *extendCode;


-(instancetype)initWithHead:(NSString *)head FsjAddressCode:(NSString *)fsjAddressCode ExtendCode:(NSString *)extendCode;
/**
 *  生成帧头数据
 */
-(NSData *)createHeadData;

@end
