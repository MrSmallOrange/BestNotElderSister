//
//  ZCMeViewControllerr.m
//  BestNotElderSister
//
//  Created by ZhangCheng on 16/4/30.
//  Copyright © 2016年 ZhangCheng. All rights reserved.
//

#import "ZCMeViewControllerr.h"

@implementation ZCMeViewControllerr
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的";
    self.view.backgroundColor = ZCColor(223, 223, 223);

    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:@selector(clickSettingItem)];
    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithImage:@"mine-moon-icon" highImage:@"mine-moon-icon-click" target:self action:@selector(clickMoonItem)];

    

    
    self.navigationItem.rightBarButtonItems = @[settingItem, moonItem];
}

- (void)clickSettingItem
{
    
}

- (void)clickMoonItem
{
    
}


@end
