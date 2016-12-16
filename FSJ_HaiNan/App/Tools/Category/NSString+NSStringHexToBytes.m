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
//    NSInteger tmpid = [self integerValue];
//    NSString *nLetterValue;
//    NSString *str =@"";
//    uint16_t ttmpig;
//    for (int i = 0; i<9; i++) {
//        ttmpig=tmpid%16;
//        tmpid=tmpid/16;
//        //小于16前面补0
//        if (tmpid == 0 && i == 0) {
//            switch (ttmpig)
//            {
//                case 10:
//                    nLetterValue =@"0A";break;
//                case 11:
//                    nLetterValue =@"0B";break;
//                case 12:
//                    nLetterValue =@"0C";break;
//                case 13:
//                    nLetterValue =@"0D";break;
//                case 14:
//                    nLetterValue =@"0E";break;
//                case 15:
//                    nLetterValue =@"0F";break;
//                default:
//                    nLetterValue = [NSString stringWithFormat:@"0%u",ttmpig==nil?0:ttmpig];
//            }
//        }else{
//            switch (ttmpig)
//            {
//                case 10:
//                    nLetterValue =@"A";break;
//                case 11:
//                    nLetterValue =@"B";break;
//                case 12:
//                    nLetterValue =@"C";break;
//                case 13:
//                    nLetterValue =@"D";break;
//                case 14:
//                    nLetterValue =@"E";break;
//                case 15:
//                    nLetterValue =@"F";break;
//                default:
//                    nLetterValue = [NSString stringWithFormat:@"%u",ttmpig];
//            }
//        }
//        str = [nLetterValue stringByAppendingString:str];
//        
//        if (tmpid == 0) {
//            
//            break;
//        }
//        
//    }
//    return str;
    return [self ToHexWith:1];
}
//2字节10进制转16 小端  01 —> 0100; 123 -> 23 01; 1234-> 34 12; 22-> 22 00
- (NSString *)ToHex2{
//    NSInteger tmpid = [self integerValue];
//    NSString *nLetterValue;
//    NSString *str =@"";
//    uint16_t ttmpig;
//    for (int i = 0; i<9; i++) {
//        ttmpig=tmpid%16;
//        tmpid=tmpid/16;
//        //小于16前面补0
//        if (tmpid == 0 && i == 0) {
//            switch (ttmpig)
//            {
//                case 10:
//                    nLetterValue =@"0A";break;
//                case 11:
//                    nLetterValue =@"0B";break;
//                case 12:
//                    nLetterValue =@"0C";break;
//                case 13:
//                    nLetterValue =@"0D";break;
//                case 14:
//                    nLetterValue =@"0E";break;
//                case 15:
//                    nLetterValue =@"0F";break;
//                default:
//                    nLetterValue = [NSString stringWithFormat:@"0%u",ttmpig==nil?0:ttmpig];
//            }
//        }else{
//            switch (ttmpig)
//            {
//                case 10:
//                    nLetterValue =@"A";break;
//                case 11:
//                    nLetterValue =@"B";break;
//                case 12:
//                    nLetterValue =@"C";break;
//                case 13:
//                    nLetterValue =@"D";break;
//                case 14:
//                    nLetterValue =@"E";break;
//                case 15:
//                    nLetterValue =@"F";break;
//                default:
//                    nLetterValue = [NSString stringWithFormat:@"%u",ttmpig];
//            }
//        }
//        str = [nLetterValue stringByAppendingString:str];
//        
//        if (tmpid == 0) {
//            if (str.length == 2) {
//             return [NSString stringWithFormat:@"%@00",str];
//            }
//            if (str.length == 3) {
//                NSString *tail = [str substringToIndex:1];
//                NSString *head = [str substringFromIndex:1];
//                return [NSString stringWithFormat:@"%@0%@",head,tail];
//            }
//            if (str.length == 4) {
//            NSString *tail = [str substringToIndex:2];
//            NSString *head = [str substringFromIndex:2];
//            return [NSString stringWithFormat:@"%@%@",head,tail];
//            }
//            
//            
//            break;
//        }
//        
//    }
//    
//    return str;
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
    NSMutableString *str =@"";
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
@end
