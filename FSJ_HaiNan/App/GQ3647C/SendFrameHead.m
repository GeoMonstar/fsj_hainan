//
//  SendFrameHead.m
//  FSJ_HaiNan
//
//  Created by Monstar on 2016/12/8.
//  Copyright © 2016年 Monstar. All rights reserved.
//

#import "SendFrameHead.h"
#import "NSString+NSStringHexToBytes.h"
@implementation SendFrameHead

-(instancetype)initWithHead:(NSString *)head FsjAddressCode:(NSString *)fsjAddressCode ExtendCode:(NSString *)extendCode{
    self = [super init];
    if (self) {
        self.head = head;
        self.fsjAddressCode = fsjAddressCode;
        self.extendCode = extendCode;
    }
    return self;

}
-(NSData *)createHeadData{
    NSString * string = [NSString stringWithFormat:@"%@%@%@",self.head,self.fsjAddressCode,self.extendCode];
   
    NSData *frameHeaddata = [string hexToBytes];
    //VVDLog(@"请求帧头 == %@",frameHeaddata);
    return frameHeaddata;

}

@end
