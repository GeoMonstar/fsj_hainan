//
//  NSString+NSStringHexToBytes.m
//  FSJ_HaiNan
//
//  Created by Monstar on 2016/12/8.
//  Copyright © 2016年 Monstar. All rights reserved.
//

#import "NSString+NSStringHexToBytes.h"

@implementation NSString (NSStringHexToBytes)
-(NSData*)hexToBytes {
    NSMutableData* data = [NSMutableData data];
    int idx;
    for (idx = 0; idx+2 <= self.length; idx+=2) {
        NSRange range = NSMakeRange(idx, 2);
        NSString* hexStr = [self substringWithRange:range];
        NSScanner* scanner = [NSScanner scannerWithString:hexStr];
        unsigned int intValue;
        [scanner scanHexInt:&intValue];
        [data appendBytes:&intValue length:1];
    }
    return data;
}
- (NSString *)ToHex{

    return [self ToHexWith:1];
}
//2字节10进制转16 小端  01 —> 0100; 123 -> 23 01; 1234-> 34 12; 22-> 22 00
- (NSString *)ToHex2{

    return [self ToHexWith:2];
}
- (NSString *)ToHex3{
    return [self ToHexWith:3];
}
- (NSString *)ToHex4{
    return [self ToHexWith:4];
}
- (NSString *)ToHex8{
    return [self ToHexWith:8];
}
- (NSString *)ToHexWith:(NSInteger)len{
     NSInteger tmpid = [self integerValue];
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
            NSMutableString *mutString = [NSMutableString string];
            NSMutableString *mutStr = [NSMutableString string];
            NSInteger num = len*2;
            for (int i = 0; i<num; i++) {
                if (num-i > str.length) {
                    [mutString appendString:@"0"];
                }else{
                    [mutString appendString:str];
                    break;
                }
            }
            for ( NSInteger i = mutString.length/2-1; i >= 0; i --) {
                
                NSString *tempstr =  [mutString substringWithRange:NSMakeRange(i*2, 2)];
                [mutStr appendString:tempstr];
            }
            return mutStr;
        }
    }
    return str;
}
 //0100转"0x0001"
//- (NSString *)ReverseStr{
//    NSMutableString *mutstr = [NSMutableString string];
//    [mutstr appendString:@"0x"];
//    for ( NSInteger i = self.length/2-1; i >= 0; i --) {
//        NSString *tempstr =  [self substringWithRange:NSMakeRange(i*2, 2)];
//        tempstr= [tempstr lowercaseString];
//        [mutstr appendString:[tempstr uppercaseString]];
//    }
//    return mutstr;
//}
//"0x0001"转0100
- (NSString *)ReverseStr{
    NSMutableString *mutstr = [NSMutableString string];
   
    for ( NSInteger i = self.length/2-1; i > 0; i --) {
        NSString *tempstr =  [self substringWithRange:NSMakeRange(i*2, 2)];
        tempstr= [tempstr lowercaseString];
        [mutstr appendString:tempstr ];
    }
    return mutstr;
}
@end
