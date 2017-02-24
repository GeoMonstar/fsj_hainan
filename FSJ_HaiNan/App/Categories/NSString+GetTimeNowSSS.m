//
//  NSString+GetTimeNowSSS.m
//  PontexlifeOwner
//
//  Created by yier on 16/5/27.
//  Copyright © 2016年 newdoone. All rights reserved.
//

#import "NSString+GetTimeNowSSS.h"

@implementation NSString (GetTimeNowSSS)

+ (NSString *)getTimeNow
{
    NSString* date;
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
    //[formatter setDateFormat:@"YYYY.MM.dd.hh.mm.ss"];//秒
    //        [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss:SSS"];//毫秒
    [formatter setDateFormat:@"YYYYMMddhhmmssSSS"];
    date = [formatter stringFromDate:[NSDate date]];
    NSString * timeNow = [[NSString alloc] initWithFormat:@"%@", date];
    NSString * ss= timeNow;
    for(int i = 0;i<timeNow.length;i++)
    {
        unichar s = [timeNow characterAtIndex:i];
        if (s >= '0' && s <= '9') {
            
        }
        else
        {
            
            ss =  [ss stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%c",s] withString:@""];
        }
    }
    
    return ss;
}


@end
