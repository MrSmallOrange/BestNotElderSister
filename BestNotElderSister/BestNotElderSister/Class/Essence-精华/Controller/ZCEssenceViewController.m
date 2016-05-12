//
//  ZCEssenceViewController.m
//  BestNotElderSister
//
//  Created by ZhangCheng on 16/4/30.
//  Copyright © 2016年 ZhangCheng. All rights reserved.
//

#import "ZCEssenceViewController.h"
#import "ZCRecommendTagsViewController.h"
#import "ZCAllTableViewController.h"
#import "ZCVideoTableViewController.h"
#import "ZCVoiceTableViewController.h"
#import "ZCPictureTableViewController.h"
#import "ZCWordTableViewController.h"


@interface ZCEssenceViewController () <UIScrollViewDelegate>
/** 红色标签指示器*/
@property (nonatomic, weak) UIView *indicator;
/** 被选中的标题按钮*/
@property (nonatomic, weak) UIButton *selectedTitle;
/** 顶部标签*/
@property (nonatomic, weak) UIView *titleView;
/** */
@property (nonatomic, weak) UIScrollView *contentView;
@end
@implementation ZCEssenceViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
   
    [self setupNavigation];
    [self setupChildViewController];

    [self setupTitileView];
    [self setupContentView];
    

}

- (void)setupNavigation
{
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.view.backgroundColor = ZCColor(223, 223, 223);
    UIBarButtonItem *mainTagSubItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(clickMainTagSubItem)];
    self.navigationItem.leftBarButtonItem = mainTagSubItem;
    
}

- (void)setupTitileView
{
    UIView *titleView = [[UIView alloc] init];
    titleView.width = self.view.width;
    titleView.height = 35;
    titleView.x = 0;
    titleView.y = 64;
    titleView.backgroundColor = [[UIColor alloc] initWithRed:1 green:1 blue:1 alpha:0.8];
    [self.view addSubview:titleView];
    self.titleView = titleView;
    
    
    UIView *indicator = [[UIView alloc] init];
    indicator.backgroundColor = [UIColor redColor];
    indicator.height = 3;
    
    indicator.y = titleView.height - indicator.height;
    [titleView addSubview:indicator];
    self.indicator = indicator;
    
    
    NSArray *titles = @[@"全部", @"视频", @"声音", @"图片", @"段子"];
    CGFloat buttonWidth = titleView.width / titles.count;
    for (int i = 0; i < titles.count; i ++) {
        UIButton *button = [[UIButton alloc] init];
        button.tag = i;
        button.x = i * buttonWidth;
        button.y = 0;
        button.height = titleView.height;
        button.width = buttonWidth;
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];


        [button addTarget:self action:@selector(clickTitle:) forControlEvents:UIControlEventTouchUpInside];
        [titleView addSubview:button];
        
        if (i == 0) {
            button.enabled = NO;
            self.selectedTitle = button;
            [button.titleLabel sizeToFit];
            self.indicator.width = button.titleLabel.width;
            self.indicator.centerX = button.centerX;
        }
    }
    

}

- (void)setupContentView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *contentView = [[UIScrollView alloc] init];
    
    contentView.frame = self.view.bounds;
    contentView.delegate = self;
    contentView.pagingEnabled = YES;
    contentView.contentSize = CGSizeMake(contentView.width * self.childViewControllers.count, 0);
    [self.view insertSubview:contentView atIndex:0];
    self.contentView = contentView;
    
    [self scrollViewDidEndScrollingAnimation:contentView];
}

- (void)setupChildViewController
{
    ZCAllTableViewController *all = [[ZCAllTableViewController alloc] init];
    [self addChildViewController:all];
    
    ZCVideoTableViewController *video = [[ZCVideoTableViewController alloc] init];
    [self addChildViewController:video];
    
    ZCVoiceTableViewController *voice = [[ZCVoiceTableViewController alloc] init];
    [self addChildViewController:voice];
    
    ZCPictureTableViewController *picture = [[ZCPictureTableViewController alloc] init];
    [self addChildViewController:picture];
    
    ZCWordTableViewController *word = [[ZCWordTableViewController alloc]  init];
    [self addChildViewController:word];
                                   
                                   
}

- (void)clickTitle:(UIButton *)button
{

    
    self.selectedTitle.enabled = YES;
    button.enabled = NO;
    self.selectedTitle = button;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.indicator.width = button.titleLabel.width;
        self.indicator.centerX = button.centerX;
    }];
    
    //切换控制器
    CGPoint offset = self.contentView.contentOffset;
    offset.x = button.tag * self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];


}

- (void)clickMainTagSubItem
{
    ZCRecommendTagsViewController *tags = [[ZCRecommendTagsViewController alloc] init];
    
    [self.navigationController pushViewController:tags animated:YES];
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    
    
    
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    UITableViewController *childVieController = self.childViewControllers[index];
    childVieController.view.x = scrollView.contentOffset.x;
    childVieController.view.y = 0;
    childVieController.view.height = scrollView.height;
    
    CGFloat top = CGRectGetMaxY(self.titleView.frame);
    CGFloat bottom = self.tabBarController.tabBar.height;
    childVieController.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    
    [scrollView addSubview:childVieController.view];
    

    
    
    
}



- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}
@end
