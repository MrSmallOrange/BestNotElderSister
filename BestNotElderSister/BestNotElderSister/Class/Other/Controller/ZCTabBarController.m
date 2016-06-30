//
//  ZCTabBarController.m
//  BestNotElderSister
//
//  Created by ZhangCheng on 16/4/30.
//  Copyright © 2016年 ZhangCheng. All rights reserved.
//

#import "ZCTabBarController.h"
#import "ZCEssenceViewController.h"
#import "ZCNewViewController.h"
#import "ZCFriendTrendsViewController.h"
#import "ZCMeViewControllerr.h"
#import "ZCTabBar.h"
#import "ZCNavigationController.h"

@implementation ZCTabBarController

+ (void)initialize
{
    UITabBarItem *item = [UITabBarItem appearance];
    
    NSMutableDictionary *attribute = [NSMutableDictionary dictionary];
    
    
    attribute[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attribute[NSForegroundColorAttributeName] = [UIColor grayColor];
    [item setTitleTextAttributes:attribute forState:UIControlStateNormal];
    
    NSMutableDictionary *selectedAttribute = [NSMutableDictionary dictionary];
    selectedAttribute[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    selectedAttribute[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    ZCEssenceViewController *essence = [[ZCEssenceViewController alloc] init];
    [self setupChildViewController:essence image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon" title:@"精华"];

    ZCNewViewController *new = [[ZCNewViewController alloc] init];
    [self setupChildViewController:new image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon" title:@"新帖"];
    
    ZCFriendTrendsViewController *friendTrends = [[ZCFriendTrendsViewController alloc] init];
    [self setupChildViewController:friendTrends image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon" title:@"关注"];
    
    ZCMeViewControllerr *me = [[ZCMeViewControllerr alloc] init];
    [self setupChildViewController:me image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon" title:@"我"];
    
    ZCTabBar *tabBar = [[ZCTabBar alloc] init];
    [self setValue:tabBar forKeyPath:@"tabBar"];

    
}

- (void)setupChildViewController:(UIViewController *)ChildViewController image:(NSString *)image selectedImage:(NSString *)selectedImage title:(NSString *)title
{
    ChildViewController.tabBarItem.image = [UIImage imageNamed:image];
    ChildViewController.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    ChildViewController.tabBarItem.title = title;
    ChildViewController.navigationItem.title = title;
    
    ZCNavigationController *navi = [[ZCNavigationController alloc] initWithRootViewController:ChildViewController];

    
    [self addChildViewController:navi];
    
}
@end
