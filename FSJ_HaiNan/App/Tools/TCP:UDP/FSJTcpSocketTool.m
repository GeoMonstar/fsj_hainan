//
//  FSJTcpSocketTool.m
//  FSJ_HaiNan
//
//  Created by Monstar on 2016/12/12.
//  Copyright © 2016年 Monstar. All rights reserved.
//

#import "FSJTcpSocketTool.h"
static FSJTcpSocketTool *sharedInstance = nil;
#define TIME_OUT        -1
@implementation FSJTcpSocketTool
+ (FSJTcpSocketTool *)sharedInstance{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[super allocWithZone:NULL]init];
    });
    return sharedInstance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    return [FSJTcpSocketTool sharedInstance];
}

- (void)socketConHost{
    self.tcpSocket = [[AsyncSocket alloc]initWithDelegate:self];
    NSError *error = nil;
    [self.tcpSocket connectToHost:self.socketHost onPort:self.socketPort error:&error];
}
- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
    NSLog(@"tcp连接成功");
//    self.socketTimer = [NSTimer scheduledTimerWithTimeInterval:25 target:self selector:@selector(messageToSocket) userInfo:nil repeats:YES];
//    [self.socketTimer fire];
    
    [self.tcpSocket readDataWithTimeout:TIME_OUT tag:0];
}
//向服务器发送和接收数据
//- (void)messageToSocket
//{
//    //后台要求发送的数据
//    NSString *SocketConnect = @"message";
//    NSData *data = [SocketConnect dataUsingEncoding:NSUTF8StringEncoding];
//    [self.tcpSocket writeData:data withTimeout:-1 tag:0];
//}
- (void)tcpSendData:(NSData *)data{

    NSLog(@"sendData == %@",data);
    [self.tcpSocket writeData:data withTimeout:TIME_OUT tag:1];
    
}
//得到数据
- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    
    if (self.reciveTcpDataBlock) {
        self.reciveTcpDataBlock(data,self.socketHost,self.socketPort);
    }
    
    [self.tcpSocket readDataWithTimeout:TIME_OUT tag:0];
}
//断开Socket
- (void)DisconnectSocket{
    self.tcpSocket.userData = SocketUserDrops; //用户断开
    [self.socketTimer invalidate];
    //立即断开Socket
    [self.tcpSocket disconnect];
    
}
//服务器断开
- (void)onSocketDidDisconnect:(AsyncSocket *)sock

{
    //服务器断开状态
    if (sock.userData == SocketServerDrops) {
        //如果是服务器
        NSLog(@"服务器断开了");
        [self socketConHost];
        
    } else if(sock.userData == SocketUserDrops)
    {
        //用户断开不重连
        NSLog(@"断开连接");
        return;
    } else if (sock.userData == SocketWIFIDrops)
    {
        //用户断开不重连
        NSLog(@"wifi断开连接");
        [self socketConHost];
        return;
    }
}
@end
