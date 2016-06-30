//
//  ZCEssenceViewController.m
//  BestNotElderSister
//
//  Created by ZhangCheng on 16/4/30.
//  Copyright © 2016年 ZhangCheng. All rights reserved.
//

#import "ZCEssenceViewController.h"
#import "ZCRecommendTagsViewController.h"
#import "ZCTopicTableViewController.h"


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
    titleView.tag = -2;
    titleView.width = self.view.width;
    titleView.height = ZCTitilesViewHeight;
    titleView.x = 0;
    titleView.y = ZCTitilesViewY;
    titleView.backgroundColor = [[UIColor alloc] initWithRed:1 green:1 blue:1 alpha:0.8];
    [self.view addSubview:titleView];
    self.titleView = titleView;
    

    UIView *indicator = [[UIView alloc] init];
    indicator.backgroundColor = [UIColor redColor];
    indicator.tag = -1;
    indicator.height = 3;
    indicator.y = titleView.height - indicator.height;
    [titleView addSubview:indicator];
    self.indicator = indicator;
    
    
    CGFloat buttonWidth = titleView.width / self.childViewControllers.count;
    for (int i = 0; i < self.childViewControllers.count; i ++) {
        UIButton *button = [[UIButton alloc] init];
        button.tag = i;
        button.x = i * buttonWidth;
        button.y = 0;
        button.height = titleView.height;
        button.width = buttonWidth;
        UIViewController *childViewCotroller = self.childViewControllers[i];
        [button setTitle:childViewCotroller.title forState:UIControlStateNormal];
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
    
    ZCTopicTableViewController *all = [[ZCTopicTableViewController alloc] init];
    all.type = ZCTopicTypeAll;
    all.title = @"全部";
    [self addChildViewController:all];
    
    ZCTopicTableViewController *word = [[ZCTopicTableViewController alloc]  init];
    word.type = ZCTopicTypeWord;
    word.title = @"段子";
    [self addChildViewController:word];
    

    
    ZCTopicTableViewController *video = [[ZCTopicTableViewController alloc] init];
    video.type = ZCTopicTypeVideo;
    video.title = @"视频";
    [self addChildViewController:video];
    
    ZCTopicTableViewController *voice = [[ZCTopicTableViewController alloc] init];
    voice.type = ZCTopicTypeVoice;
    voice.title = @"声音";
    [self addChildViewController:voice];
    
    ZCTopicTableViewController *picture = [[ZCTopicTableViewController alloc] init];
    picture.type = ZCTopicTypePicture;
    picture.title = @"图片";
    [self addChildViewController:picture];

                                   
                                   
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
    UIViewController *childVieController = self.childViewControllers[index];
    childVieController.view.x = scrollView.contentOffset.x;
    childVieController.view.y = 0;
    childVieController.view.height = scrollView.height;

    [scrollView addSubview:childVieController.view];
    
}



- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    NSInteger tag = scrollView.contentOffset.x / scrollView.width;
    [self clickTitle:[self.titleView viewWithTag:tag]];
    
}
@end
