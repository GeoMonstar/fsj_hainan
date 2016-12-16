//
//  ReciveFrameHead.h
//  FSJ_HaiNan
//
//  Created by Monstar on 2016/12/8.
//  Copyright © 2016年 Monstar. All rights reserved.
//

//地点站台编码
#import <Foundation/Foundation.h>

@interface ReciveFrameHead : NSObject

//命令类型吗
@property (nonatomic,copy)NSString *head;
//站台编码
@property (nonatomic,copy)NSString *fsjAddressCode;
//设备类型
@property (nonatomic,copy)NSString *fsjTypeCode;
//厂家编号
@property (nonatomic,copy)NSString *companyCode;
//硬件版本号
@property (nonatomic,copy)NSString *hardwareVersionCode;
//软件版本号
@property (nonatomic,copy)NSString *softwareVersionCode;
//预留字段
@property (nonatomic,copy)NSString *extendCode;

-(instancetype)initWithHead:(NSString *)head
             FsjAddressCode:(NSString *)fsjAddressCode
                FsjTypeCode:(NSString *)fsjTypeCode
                CompanyCode:(NSString *)companyCode
        HardwareVersionCode:(NSString *)hardwareVersionCode
        SoftwareVersionCode:(NSString *)softwareVersionCode
                 ExtendCode:(NSString *)extendCode;

-(NSData *)description;
-(NSArray *)responsHeadData:(NSData *)data;
@end
