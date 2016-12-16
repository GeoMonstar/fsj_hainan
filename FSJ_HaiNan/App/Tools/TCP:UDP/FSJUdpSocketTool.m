//
//  FSJUdpSocketTool.m
//  FSJ
//
//  Created by Monstar on 2016/12/6.
//  Copyright © 2016年 Monstar. All rights reserved.
//

#import "FSJUdpSocketTool.h"

#import <sys/socket.h>

#import <netinet/in.h>

#import <arpa/inet.h>

#import <unistd.h>
#ifdef DEBUG
#define VVDLog(format, ...) NSLog((@"\n[函数名:%s]" "[行号:%d]  \n" format), __FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define VVDLog(format, ...);
#endif

#define LOCAL_BIND      9000
#define TIME_OUT        -1


@implementation FSJUdpSocketTool

+ (FSJUdpSocketTool *)sharedInstance{
    
    static FSJUdpSocketTool *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[self alloc]init];
    });
    return shareInstance;
}
/*
 *  socket 连接
 */
- (void)socketConnectHost{
    //sender
    NSError *error = nil;
    self.udpSocket = [[AsyncUdpSocket alloc] initWithDelegate:self];
    [self.udpSocket enableBroadcast:YES error:&error];
    if (error) {
        VVDLog(@"sendSocket enableBroadcast error : %@", error);
    }
    [self.udpSocket bindToPort:LOCAL_BIND error:&error];
    [self.udpSocket receiveWithTimeout:TIME_OUT tag:200];
    if (error) {
        VVDLog(@"sendSocket bindToPort error : %@", error);
    }

    
}
/*
 *  断开socket连接
 */
- (void)cutOffSocket{

   
    [self.udpSocket close];
}

- (void)sendMsg:(NSData *) data{
 
    BOOL result = [self.udpSocket sendData:data toHost:self.hostAddress port:self.serverPort withTimeout:TIME_OUT tag:100];
    VVDLog(@"send data to %@:%d -- %@ ",self.hostAddress,self.serverPort,data);
   
    if (!result) {
        //VVDLog(@"send failed");
    }
    else{
        //VVDLog(@"send succeed");
    }
    //VVDLog(@"数据还没有发完");
    //sendData只是告诉系统发送，但是这个内容还没有发完
}
#pragma mark -- delegate
- (void) onUdpSocket:(AsyncUdpSocket *)sock didSendDataWithTag:(long)tag
{
    // 当前tag这个数据包发送完成
    if (tag == 100) {
        // 证明tag 100
        //VVDLog(@"tag 100 packet send finished");
    }
}

- (void)onUdpSocket:(AsyncUdpSocket *)sock didNotSendDataWithTag:(long)tag dueToError:(NSError *)error
{
    VVDLog(@"didNotSendDataWithTag = %@", error);
}

- (BOOL) onUdpSocket:(AsyncUdpSocket *)sock didReceiveData:(NSData *)data withTag:(long)tag fromHost:(NSString *)host port:(UInt16)port
{
    // data 对方出过来的数据
    // tag == 200
    // host从哪里来数据 ip
    // port 对象的端口
    
    
    if (tag == 200) {
        //NSString *sData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
       
        [sock receiveWithTimeout:TIME_OUT tag:tag];
        if (self.reciveDataBlock) {
            self.reciveDataBlock(data,host,port);
        }
        // 此处处理接受到的数据
        
    }
    return YES;
}

- (void)onUdpSocket:(AsyncUdpSocket *)sock didNotReceiveDataWithTag:(long)tag dueToError:(NSError *)error
{
    VVDLog(@"didNotReceiveDataWithTag = %@", error);
}
@end
