

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "VKMsgSend.h"

@interface HTMediatorAction : NSObject

+ (instancetype)sharedInstance;

/**
 *  远程调用入口(服务器下发)
 */
- (void)performActionWithUrl:(NSString *)url animated:(BOOL)animated;
/**
 *  本地组件调用入口
 */
- (id)performTarget:(NSString *)targetName action:(NSString *)actionName;

@end
