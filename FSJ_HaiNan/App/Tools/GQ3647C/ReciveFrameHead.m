//
//  ReciveFrameHead.m
//  FSJ_HaiNan
//
//  Created by Monstar on 2016/12/8.
//  Copyright © 2016年 Monstar. All rights reserved.
//

#import "ReciveFrameHead.h"
#import "NSString+NSStringHexToBytes.h"
@implementation ReciveFrameHead

-(instancetype)initWithHead:(NSString *)head
             FsjAddressCode:(NSString *)fsjAddressCode
                FsjTypeCode:(NSString *)fsjTypeCode
                CompanyCode:(NSString *)companyCode
        HardwareVersionCode:(NSString *)hardwareVersionCode
        SoftwareVersionCode:(NSString *)softwareVersionCode
                 ExtendCode:(NSString *)extendCode{
    self = [super init];
    if (self) {
        self.head = head;
        self.fsjAddressCode = fsjAddressCode;
        self.extendCode = extendCode;
        self.fsjTypeCode = fsjTypeCode;
        
        self.companyCode = companyCode;
        self.hardwareVersionCode = hardwareVersionCode;
        self.softwareVersionCode = softwareVersionCode;
    }
    return self;


}
//-(NSData *)description{
//    NSString * string = [NSString stringWithFormat:@"%@%@%@%@%@%@%@",self.head,self.fsjAddressCode,self.fsjTypeCode,self.companyCode,self.hardwareVersionCode,self.softwareVersionCode,self.extendCode];
//    
//    NSData *frameHeaddata = [string hexToBytes];
//    VVDLog(@"响应帧头 == %@",frameHeaddata);
//    return frameHeaddata;
//}

@end
