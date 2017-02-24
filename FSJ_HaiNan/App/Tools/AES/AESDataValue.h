//
//  AESDataValue.h
//  CDOTO
//
//  Created by yier on 16/3/29.
//  Copyright © 2016年 newdoone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AESDataValue : NSObject

//发送请求之前将字典中data的数据进行AES加密，并转成16进制
+ (NSDictionary *)sendJsonDataToAESData:(NSMutableDictionary *)dic;

//网络传回的16进制加密数据先进行解密
+ (NSString *)sendAESHexJsonDataToJsonStr:(NSString *)jsonData;

@end
