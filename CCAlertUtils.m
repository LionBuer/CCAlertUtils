//
//  CCAlertUtils.m
//  ColdChain
//
//  Created by X on 2017/10/10.
//  Copyright © 2017年 supconit. All rights reserved.
//

#import "CCAlertUtils.h"
#import "MBProgressHUD.h"

static NSInteger const kAlertViewTag = 10000;

@implementation CCAlertUtils

#pragma mark - publicMethod
#pragma mark - 纯文字（会自动消失）
+ (void)tipMessage:(NSString *)msg{
    [self tipMessage:msg delay:1.f];
}

+ (void)tipMessage:(NSString *)msg delay:(CGFloat)seconds{
    [self tipMessage:msg delay:seconds completion:nil];
}

+ (void)tipMessage:(NSString *)msg delay:(CGFloat)seconds completion:(void (^)(void))completion{
    
    if (!msg || !msg.length) {
        return;
    }
    
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            MBProgressHUD *hud = [self HUDForView:[UIApplication sharedApplication].windows.firstObject];
            
            hud.mode = MBProgressHUDModeText;
            hud.label.text = msg;
            [hud showAnimated:YES];
            [hud hideAnimated:YES afterDelay:seconds];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(seconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [hud hideAnimated:YES];
                completion ? completion() : nil;
            });
            
        });
    } else {
        
        MBProgressHUD *hud = [self HUDForView:[UIApplication sharedApplication].windows.firstObject];
        
        hud.mode = MBProgressHUDModeText;
        hud.label.text = msg;
        [hud showAnimated:YES];
        [hud hideAnimated:YES afterDelay:seconds];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(seconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [hud hideAnimated:YES];
            completion ? completion() : nil;
        });
    }
}


+ (void)alert:(NSString *)msg
{
    [self alert:msg cancel:@"确定"];
}
+ (void)alert:(NSString *)msg action:(void(^)(void))action
{
    [self alert:msg cancel:@"确定" action:action];
}
+ (void)alert:(NSString *)msg cancel:(NSString *)cancel
{
    [self alertTitle:@"提示" message:msg cancel:cancel];
}
+ (void)alert:(NSString *)msg cancel:(NSString *)cancel action:(void(^)(void))action
{
    [self alertTitle:@"提示" message:msg cancel:cancel action:action];
}
+ (void)alertTitle:(NSString *)title message:(NSString *)msg cancel:(NSString *)cancel
{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:cancel otherButtonTitles:nil, nil];
        [alert show];
    });
}

+ (void)alertTitle:(NSString *)title message:(NSString *)msg cancel:(NSString *)cancel action:(void(^)(void))action
{
    
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertView *alert = [UIAlertView bk_showAlertViewWithTitle:title message:msg cancelButtonTitle:cancel otherButtonTitles:nil handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
                if (action)
                {
                    action();
                }
            }];
            [alert show];
        });
    } else {
        UIAlertView *alert = [UIAlertView bk_showAlertViewWithTitle:title message:msg cancelButtonTitle:cancel otherButtonTitles:nil handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
            if (action)
            {
                action();
            }
        }];
        [alert show];
    }
}

+ (void)alertTitle:(NSString *)title message:(NSString *)msg cancelButtonTitle:(NSString *)cancelButtonTitle cancelAction:(void(^)(void))cancelAction otherButtonTitle:(NSString *)otherButtonTitle otherAction:(void(^)(void))otherAction{
    
    
    
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertView *alert = [UIAlertView bk_showAlertViewWithTitle:title message:msg cancelButtonTitle:cancelButtonTitle otherButtonTitles:@[otherButtonTitle] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
                
                if (buttonIndex == 0) {
                    cancelAction ? cancelAction() : nil;
                }else if (buttonIndex == 1){
                    otherAction ? otherAction() : nil;
                }
            }];
            [alert show];
        });
    } else {
        UIAlertView *alert = [UIAlertView bk_showAlertViewWithTitle:title message:msg cancelButtonTitle:cancelButtonTitle otherButtonTitles:@[otherButtonTitle] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
            
            if (buttonIndex == 0) {
                cancelAction ? cancelAction() : nil;
            }else if (buttonIndex == 1){
                otherAction ? otherAction() : nil;
            }
        }];
        [alert show];
    }
}


#pragma mark - 菊花指示器+文字(不会自动消失)
+ (void)showLoadingAlertView{
    [self showLoadingAlertView:nil];
}

+ (void)showLoadingAlertView:(NSString *)alertText{
    [self showLoadingAlertView:alertText inView:nil];
}

+ (void)showLoadingAlertView:(NSString *)alertText inView:(UIView *)view{
    
    UIView *inView = view ? view : [UIApplication sharedApplication].windows.firstObject;
    
    if (!inView) {
        return;
    }
    
    MBProgressHUD *hud = [self HUDForView:inView];
    if ([NSThread isMainThread]) {
        
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.label.text = alertText;
        [hud showAnimated:YES];
        
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            hud.mode = MBProgressHUDModeIndeterminate;
            hud.label.text = alertText;
            [hud showAnimated:YES];
            
        });
    }
}

+ (void)hideLoadingAlertView:(UIView *)view{
    
    if ([NSThread isMainThread]) {
        [MBProgressHUD hideHUDForView:view animated:YES];
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:view animated:YES];
        });
    }
}

#pragma mark - privateMethod
+ (MBProgressHUD *)HUDForView:(UIView *)view{

    UIView *alertView = [view viewWithTag:kAlertViewTag];

    MBProgressHUD *hud;

    if (alertView)
    {
        if ([alertView isKindOfClass:[MBProgressHUD class]]) {
            hud = (MBProgressHUD *)alertView;
        }
    }
    else
    {
        hud = [[MBProgressHUD alloc] initWithView:view];
        hud.tag = kAlertViewTag;
        hud.removeFromSuperViewOnHide = YES;
        [view addSubview:hud];
    }
    return hud;
}

@end
