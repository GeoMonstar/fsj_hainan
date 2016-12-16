//
//  SecondViewController.m
//  FSJ_HaiNan
//
//  Created by Monstar on 2016/12/8.
//  Copyright © 2016年 Monstar. All rights reserved.
//

#import "BaseViewController.h"
#import "FSJUdpSocketTool.h"
#import "SendFrameHead.h"
#import "ReadFrameBody.h"
#import "NSString+NSStringHexToBytes.h"
#import "ViewController.h"
#import "FSJTcpSocketTool.h"
#import "ParameterModel.h"
#import "EGOCache.h"
#import "ParametersList.h"
#define kParametersKey @"test"

@interface BaseViewController ()<UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate>{

    NSString *fsjAddr;
    NSString *zhantaiCode;
    NSString *extendCode;
    NSData *adata;
}
@property (weak, nonatomic) IBOutlet UITextField *hostAddrTF;
@property (weak, nonatomic) IBOutlet UITextField *portTF;
@property (weak, nonatomic) IBOutlet UITextField *fsjAddrTF;
@property (weak, nonatomic) IBOutlet UITextField *zhantaiCodeTF;
@property (weak, nonatomic) IBOutlet UIPickerView *chosePickView;
@property (weak, nonatomic) IBOutlet UITextField *hardwareVersion;
@property (weak, nonatomic) IBOutlet UITextField *softwareVersion;

@property (nonatomic,retain)NSArray *firstArr;
@property (nonatomic,retain)NSArray *secondArr;


@end

@implementation BaseViewController
- (void)textFieldDidEndEditing:(UITextField *)textField{
    fsjAddr = self.fsjAddrTF.text;
    fsjAddr = [self chaneToHex:fsjAddr and:1 and:YES];
    
    NSString *zhantaiStr = self.zhantaiCodeTF.text;
    zhantaiCode = [self chaneToHex:zhantaiStr and:17 and:NO];
    extendCode = [self chaneToHex:extendCode and:2 and:YES];
}
- (void)tcpTest{

    //Byte byte[] ={0x01 ,0x5A ,0x00 ,0x00 ,0x21 ,0xCB};
    Byte byte[] = {0x26,0x00, 0x00 , 0x00 , 0x00 , 0x00 , 0x00 ,0x00 ,0x00 , 0x00 , 0x00 , 0x00 , 0x00 , 0x00 , 0x00 , 0x00 , 0x00 , 0x00 , 0x00 , 0x00 , 0x01 , 0x03 , 0x02 , 0x00 , 0x01 , 0x00 , 0x45 , 0xE2};
    //NSString *orderStr = @"26 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01 5A 00 00 21 CB";
    [FSJTcpSocketTool sharedInstance].socketHost = @"192.168.10.203";
    [FSJTcpSocketTool sharedInstance].socketPort    = 6000;
    [[FSJTcpSocketTool sharedInstance]socketConHost];
    adata = [[NSData alloc] initWithBytes:byte length:sizeof(byte)/sizeof(byte[0])];
   
}
- (void)getJsonData{
    NSMutableArray *mutArr = @[].mutableCopy;
    NSString * jsonPath = [[NSBundle mainBundle]pathForResource:@"Parameters" ofType:@"json"];
    NSData * jsonData = [[NSData alloc]initWithContentsOfFile:jsonPath];
    NSArray *jsonArr = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    
    for (NSDictionary *dic in jsonArr) {
        ParameterModel *model = [ParameterModel initWithDictionary:dic];
        [mutArr addObject:model];
    }
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:mutArr];
    [[EGOCache globalCache]setData:data forKey:kParametersKey];
    NSData *data2 = [[EGOCache globalCache]dataForKey:kParametersKey];
    NSArray *arr = [NSKeyedUnarchiver unarchiveObjectWithData:data2];
  
    for (ParameterModel *model in arr) {
        
        if ([model.parno isEqualToString:BaseInfo0100]) {
           // VVDLog(@" model== %@ %@",model.parametername,model.parameterLength);
        }
        
    }
    
}

-(NSDate *)changeSpToTime:(NSString*)spString
{
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[spString intValue]];
    NSTimeZone *zone = [NSTimeZone localTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:confromTimesp];
    //时差处理
    NSDate *localeDate = [confromTimesp  dateByAddingTimeInterval: -interval];
    
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSString* string=[dateFormat stringFromDate:localeDate];
    NSLog(@"%@",string);
    return confromTimesp;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [FSJUdpSocketTool sharedInstance].hostAddress = self.hostAddrTF.text;
    [FSJUdpSocketTool sharedInstance].serverPort  = [self.portTF.text integerValue];
    
    [self tcpTest];
  
    
    
    
     self.chosePickView.delegate   = self;
     self.chosePickView.dataSource = self;
     zhantaiCode = [self chaneToHex:@"" and:17 and:NO];
     extendCode = @"0000";
     fsjAddr = @"01";
     self.firstArr = @[@"0x0001模拟电视发射机",@"0x0002调频广播发射机",@"0x0003地面数字电视广播发射机",@"0x0004移动多媒体广播发射机",@"0x0005中波广播发射机",@"0x0006短波广播发射机",@"0x0007短波跳频发射机",@"0x0008收转式地面数字电视广播发射机",];
     self.secondArr = @[@"0x0008高斯贝尔"];

     self.hostAddrTF.delegate = self;
     self.portTF.delegate = self;
     self.fsjAddrTF.delegate = self;
     self.zhantaiCodeTF.delegate = self;
     self.hardwareVersion.delegate = self;
     self.softwareVersion.delegate = self;
    
}
//10进制转换16进制 位数
- (NSString *)chaneToHex:(NSString *)string and:(int)num and:(BOOL)isUInt16{
    NSString *result = @"";
    //asciicode
    if (!isUInt16) {

        NSMutableString *mutiStr = [NSMutableString string];
        for ( int i = 0; i < num; i ++) {
                if (i<string.length) {//查表转Hex
                    int asciiCode = [string characterAtIndex:i];
                    NSString *tempStr =  [self ToHex:asciiCode];
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
                    [mutiStr insertString:result atIndex:0];
                }else{
                    [mutiStr insertString:@"00" atIndex:0];
                }
            }
            
        }
        return mutiStr;
    }

    return result;
}
- (NSString *)ToHex:(uint16_t)tmpid
{
    
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
            break;
        }
    }

    return str;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
#pragma mark UIPickerView DataSource Method 数据源方法

//指定pickerview有几个表盘
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;//第一个展示字母、第二个展示数字
}

//指定每个表盘上有几行数据
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    NSInteger result = 0;
    switch (component) {
        case 0:
            result = self.firstArr.count;//根据数组的元素个数返回几行数据
            break;
        case 1:
            result = self.secondArr.count;
            break;
            
        default:
            break;
    }
    return result;
}

#pragma mark UIPickerView Delegate Method 代理方法

//指定每行如何展示数据（此处和tableview类似）
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString * title = nil;
    switch (component) {
        case 0:
            title = self.firstArr[row];
            break;
        case 1:
            title = self.secondArr[row];
            break;
        default:
            break;
    }
    return title;
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        //Setup label properties - frame, font, colors etc
        //adjustsFontSizeToFitWidth property to YES
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:13]];
    }
    // Fill the label text here
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}
- (IBAction)gotoNext:(id)sender {
    for (UITextField *TF in self.view.subviews) {
        [TF endEditing:YES];
    }
     [[FSJUdpSocketTool sharedInstance] socketConnectHost];
    SendFrameHead *head = [[SendFrameHead alloc]initWithHead:@"26" FsjAddressCode:zhantaiCode ExtendCode:extendCode];
    NSData *Data =  [head description];
    
    
    ViewController *vc = [[ViewController alloc]init];
    vc.headData = Data;
    vc.ShebeiIP = fsjAddr;
    
//     [[FSJTcpSocketTool sharedInstance]tcpSendData:adata];
//    [FSJTcpSocketTool sharedInstance].reciveTcpDataBlock = ^(NSData *data,NSString *host,UInt16 port){
//        NSLog(@"receive data from %@ %d data == %@",host,port,data);
//    };
    
    
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
