//
//  ViewController.m
//  FSJ_HaiNan
//
//  Created by Monstar on 2016/12/8.
//  Copyright © 2016年 Monstar. All rights reserved.
//

#import "ViewController.h"
#import "DOPDropDownMenu.h"
#import "ReadFrameBody.h"
#import "NSString+NSStringHexToBytes.h"
#import "ViewController.h"

@interface ViewController ()<DOPDropDownMenuDataSource, DOPDropDownMenuDelegate,UITextFieldDelegate>{
   
}

@property (nonatomic, strong) DOPDropDownMenu *menu;
@property (nonatomic, retain) NSArray *mainArr;
@property (nonatomic, retain) NSArray *mainArrValue;
@property (nonatomic, retain) NSArray *firstArr;
@property (nonatomic, retain) NSArray *firstArrValue;
@property (nonatomic, retain) NSArray *SecondArr;
@property (nonatomic, retain) NSArray *SecondArrValue;
@property (nonatomic, retain) NSArray *ThirdArr;
@property (nonatomic, retain) NSArray *FourthArr;
@property (nonatomic, strong) NSMutableArray *ParametersArr;
@property (nonatomic, strong) UITextField *valueTF;
@property (nonatomic, copy)NSString *valueStr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.valueTF = [[UITextField alloc]initWithFrame:CGRectMake(50, 400, 200, 50)];
    self.valueTF.placeholder = @"请输入值";
    self.valueTF.delegate = self;
    [self.view addSubview:self.valueTF];
    self.mainArr = @[@"读命令",@"写命令",@"搜索命令",@"短期网络配置命令"];
    self.mainArrValue = @[@"03",@"10",@"5A",@"5D"];
    self.firstArr = @[@"读台站编码",@"设备名称",@"设备硬件版本",@"设备软件版本号",@"生产厂家",@"产品序列号"];
    self.firstArrValue = @[BaseInfo0100,BaseInfo0200,BaseInfo0300,BaseInfo0400,BaseInfo0500,BaseInfo0700];
    self.SecondArr = @[@"读台站编码",@"设备名称"];
    self.SecondArrValue = @[BaseInfo0100,BaseInfo0200];
    
    self.ParametersArr = @[].mutableCopy;
    self.view.backgroundColor = [UIColor whiteColor];
    DOPDropDownMenu *menu = [[DOPDropDownMenu alloc] initWithOrigin:CGPointMake(0, 64) andHeight:40];
    menu.dataSource = self;
    menu.delegate = self;
    [self.view addSubview:menu];
    self.menu = menu;
}

- (NSInteger)numberOfColumnsInMenu:(DOPDropDownMenu *)menu
{
    return 1;
}
- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column
{
    
    return self.mainArr.count;
    
}
- (NSString *)menu:(DOPDropDownMenu *)menu titleForRowAtIndexPath:(DOPIndexPath *)indexPath
{
   
    return self.mainArr[indexPath.row];
    
}
- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfItemsInRow:(NSInteger)row column:(NSInteger)column
{
    if (column == 0) {
        if (row == 0) {
            return self.firstArr.count;
        }
        if (row == 1) {
            return self.SecondArr.count;
        }
    }
    return 0;
}

- (NSString *)menu:(DOPDropDownMenu *)menu titleForItemsInRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if (indexPath.column == 0) {
        if (indexPath.row == 0) {
            return self.firstArr[indexPath.item];
        }
        if (indexPath.row == 1) {
            return self.SecondArr[indexPath.item];
        }
    }
    return nil;
}
- (void)menu:(DOPDropDownMenu *)menu didSelectRowAtIndexPath:(DOPIndexPath *)indexPath
{
    [self.valueTF endEditing:YES];
    if (indexPath.row ==2) {
        [self sendMessageWithFunctionCode:self.mainArrValue[indexPath.row] andParamArr:nil];
    }
    if (indexPath.row ==1) {
        if (self.ParametersArr.count >0) {
            [self.ParametersArr removeAllObjects];
        }
        if (indexPath.item >0) {
            [self.ParametersArr addObject:self.SecondArrValue[indexPath.item]];
            [self sendMessageWithFunctionCode:self.mainArrValue[indexPath.row] andParamArr:self.ParametersArr];
        }
       
    }
    if (indexPath.row ==0) {
        if (self.ParametersArr.count >0) {
            [self.ParametersArr removeAllObjects];
        }
        [self.ParametersArr addObject:self.firstArrValue[indexPath.item]];
        [self sendMessageWithFunctionCode:self.mainArrValue[indexPath.row] andParamArr:self.ParametersArr];
    }
    
}

- (void)sendMessageWithFunctionCode:(NSString *)functionCode andParamArr:(NSArray *)paramArr {
    
    NSMutableData *mutData = [[NSMutableData alloc]initWithData:self.headData];
    if ([functionCode isEqualToString:@"03"] ) {
        ReadFrameBody *body = [[ReadFrameBody alloc]initWithFsjID:self.ShebeiIP FunctionCode:functionCode ParameterID:paramArr];
        NSData *bodyData = [body readData];
        [mutData appendData:bodyData];
        WeakSelf(weakself);
      //  self.Udptool udpSendData:mutData;
        [self.Udptool udpSendData:mutData];
        self.Udptool.reciveDataBlock = ^(NSData *data,NSString *host,UInt16 port){
            NSString *str =   [weakself convertDataToHexStr:data];
            NSLog(@"recv data from %@:%d -- %@   %ld", host, port,str,str.length);
            NSArray *arr =  [body responsReadData:data];
        };
    }
    if ([functionCode isEqualToString:@"5A"]) {
        SearchFrameBody *body = [[SearchFrameBody alloc]initWithFsjID:self.ShebeiIP FunctionCode:functionCode ParameterID:paramArr];
        NSData *bodyData = [body readData];
        [mutData appendData:bodyData];
        
        [[FSJUdpSocketTool sharedInstance]udpSendData:mutData];
        [FSJUdpSocketTool sharedInstance].reciveDataBlock = ^(NSData *data,NSString *host,UInt16 port){
            NSString *str =   [self convertDataToHexStr:data];
            NSLog(@"recv data from %@:%d -- %@   %ld", host, port,str,str.length);
            NSArray *arr =  [body responsReadData:data];
        };
    }
    if ([functionCode isEqualToString:@"10"]) {
        NSDictionary *dic = @{paramArr[0]:self.valueStr};
        NSMutableArray *dicArr = @[].mutableCopy;
        [dicArr addObject:dic];
        WriteFrameBody *body = [[WriteFrameBody alloc]initWithFsjID:self.ShebeiIP FunctionCode:functionCode ParameterdicArr:dicArr];
        NSData *bodyData = [body writeData];
        [mutData appendData:bodyData];
        [[FSJUdpSocketTool sharedInstance]udpSendData:mutData];
        [FSJUdpSocketTool  sharedInstance].reciveDataBlock = ^(NSData *data,NSString *host,UInt16 port){
            NSString *str =   [self convertDataToHexStr:data];
            NSLog(@"recv data from %@:%d -- %@   %ld", host, port,str,str.length);
        };
    }
}

- (NSString *)convertDataToHexStr:(NSData *)data
{
    if (!data || [data length] == 0) {
        return @"";
    }
    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:[data length]];
    
    [data enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
        unsigned char *dataBytes = (unsigned char*)bytes;
        for (NSInteger i = 0; i < byteRange.length; i++) {
            NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) & 0xff];
            if ([hexStr length] == 2) {
                [string appendString:hexStr];
            } else {
                [string appendFormat:@"0%@", hexStr];
            }
        }
    }];
    return string;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)chaneToHex:(NSString *)string and:(int)num and:(BOOL)isUInt16{
    NSString *result = @"";
    //asciicode
    if (!isUInt16) {
        
        NSMutableString *mutiStr = [NSMutableString string];
        for ( int i = 0; i < num; i ++) {
            if (i<string.length) {//查表转Hex
                int asciiCode = [string characterAtIndex:i];
                NSString *tempStr =  [string ToHex];
                [mutiStr appendFormat:@"%@",tempStr];
                
            }else{
                [mutiStr appendFormat:@"00"];
            }
        }
        return  mutiStr;
    }
    //16进制
    else{
        NSMutableString *mutiStr = [NSMutableString string];
        for (int i = 0; i < num; i ++) {
            //16进制
            if ([string hasPrefix:@"0x"]) {
                //分割16进制字符串 小端对齐
                NSArray *stringArr =  [string componentsSeparatedByString:@"0x"];
                if (i < stringArr.count) {
                    [mutiStr insertString:stringArr[i] atIndex:0];
                }else{
                    [mutiStr insertString:@"00" atIndex:0];
                }
                //return mutiStr;
            }
            //十进制转16进制字符串 默认一位
            else{
                if (i < 1) {
                    result = [string ToHex];//有问题
                    [mutiStr appendString:result ];
                }else{
                    [mutiStr appendString:@"00" ];

                }
            }
            
        }
        return mutiStr;
    }
    return result;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    self.valueStr = self.valueTF.text;

}
@end
