//
//  ZCPushGuideView.m
//  BestNotElderSister
//
//  Created by ZhangCheng on 16/5/8.
//  Copyright © 2016年 ZhangCheng. All rights reserved.
//

#import "ZCPushGuideView.h"

@implementation ZCPushGuideView

+ (instancetype)pushGuideView
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ZCPushGuideView class]) owner:nil options:nil][0];
}
+ (void)show
{
    NSString *key = @"CFBundleShortVersionString";
    
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    
    if ([currentVersion isEqualToString:lastVersion] == false) {
        ZCPushGuideView *pushGuideView = [ZCPushGuideView pushGuideView];
        pushGuideView.frame = [UIScreen mainScreen].bounds;
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:pushGuideView];
        
        //存储当前版本号
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
}
- (IBAction)close:(id)sender {
    
    [self removeFromSuperview];
}

@end
