//
//  ZCNewViewController.m
//  BestNotElderSister
//
//  Created by ZhangCheng on 16/4/30.
//  Copyright © 2016年 ZhangCheng. All rights reserved.
//

#import "ZCNewViewController.h"

@implementation ZCNewViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.view.backgroundColor = ZCColor(223, 223, 223);

    
    UIBarButtonItem *mainTagSubItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(clickMainTagSubItem)];
    self.navigationItem.leftBarButtonItem = mainTagSubItem;
    
    
}

- (void)clickMainTagSubItem
{
    
}
@end
