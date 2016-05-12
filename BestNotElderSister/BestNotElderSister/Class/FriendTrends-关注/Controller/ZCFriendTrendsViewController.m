//
//  ZCFriendTrendsViewController.m
//  BestNotElderSister
//
//  Created by ZhangCheng on 16/4/30.
//  Copyright © 2016年 ZhangCheng. All rights reserved.
//

#import "ZCFriendTrendsViewController.h"
#import "ZCRecommendViewController.h"
#import "ZCLoginRegisterController.h"

@implementation ZCFriendTrendsViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的关注";
    self.view.backgroundColor = ZCColor(223, 223, 223);

    UIBarButtonItem *friendItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" target:self action:@selector(clickFriendItem)];
    self.navigationItem.leftBarButtonItem = friendItem;

}

- (void)clickFriendItem
{
    ZCRecommendViewController *recommend = [[ZCRecommendViewController alloc] init];
    [self.navigationController pushViewController:recommend animated:YES];
}
- (IBAction)loginRegister {
    
    ZCLoginRegisterController *loginRegister = [[ZCLoginRegisterController alloc] init];
    
    [self presentViewController:loginRegister animated:YES completion:nil];
}
@end
