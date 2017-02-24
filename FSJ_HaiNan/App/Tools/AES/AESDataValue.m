//
//  AESDataValue.m
//  CDOTO
//
//  Created by yier on 16/3/29.
//  Copyright © 2016年 newdoone. All rights reserved.
//

#import "AESDataValue.h"
#import "AESEncryption.h"
#import "Constants.h"

@implementation AESDataValue

+ (NSDictionary *)sendJsonDataToAESData:(NSMutableDictionary *)dic
{
    NSMutableDictionary * dataDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    if (dataDic[@"data"]) {
        dataDic[@"data"] = [AESEncryption encryptAESData:dataDic[@"data"] app_key:AESKey];
    }
    return dataDic;
}

+ (NSString *)sendAESHexJsonDataToJsonStr:(NSString *)jsonData
{
    return  [AESEncryption decryptAESData:jsonData app_key:AESKey];;
}

@end
