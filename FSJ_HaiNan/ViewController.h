//
//  ViewController.h
//  FSJ_HaiNan
//
//  Created by Monstar on 2016/12/8.
//  Copyright © 2016年 Monstar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSJUdpSocketTool.h"
@interface ViewController : UIViewController


@property (nonatomic, copy)NSData* headData;

@property (nonatomic, copy)NSString* ShebeiIP;
@property (nonatomic, strong)FSJUdpSocketTool *Udptool;

@end

