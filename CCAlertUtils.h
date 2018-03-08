//
//  CCAlertUtils.h
//  ColdChain
//
//  Created by X on 2017/10/10.
//  Copyright © 2017年 supconit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCAlertUtils : NSObject

+ (void)tipMessage:(NSString *)msg;
+ (void)tipMessage:(NSString *)msg delay:(CGFloat)seconds;
+ (void)tipMessage:(NSString *)msg delay:(CGFloat)seconds completion:(void (^)(void))completion;



+ (void)alert:(NSString *)msg;
+ (void)alert:(NSString *)msg action:(void(^)(void))action;
+ (void)alert:(NSString *)msg cancel:(NSString *)cancel;
+ (void)alert:(NSString *)msg cancel:(NSString *)cancel action:(void(^)(void))action;
+ (void)alertTitle:(NSString *)title message:(NSString *)msg cancel:(NSString *)cancel;
+ (void)alertTitle:(NSString *)title message:(NSString *)msg cancel:(NSString *)cancel action:(void(^)(void))action;
+ (void)alertTitle:(NSString *)title message:(NSString *)msg cancelButtonTitle:(NSString *)cancelButtonTitle cancelAction:(void(^)(void))cancelAction otherButtonTitle:(NSString *)otherButtonTitle otherAction:(void(^)(void))otherAction;


+ (void)showLoadingAlertView;
+ (void)showLoadingAlertView:(NSString *)alertText;
+ (void)showLoadingAlertView:(NSString *)alertText inView:(UIView *)view;

+ (void)hideLoadingAlertView:(UIView *)view;

@end
