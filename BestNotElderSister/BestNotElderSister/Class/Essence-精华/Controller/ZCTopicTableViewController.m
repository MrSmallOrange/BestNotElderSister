//
//  ZCTopicTableViewController.m
//  BestNotElderSister
//
//  Created by ZhangCheng on 16/5/11.
//  Copyright © 2016年 ZhangCheng. All rights reserved.
//

#import "ZCTopicTableViewController.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "MJExtension.h"
#import "ZCTopic.h"
#import "MJRefresh.h"
#import "ZCTopicCell.h"
#define ZCTopicCellID @"topic"

@interface ZCTopicTableViewController ()
/** */
@property (nonatomic, strong) NSMutableArray *topics;
/** 当前页*/
@property (nonatomic, assign) NSInteger page;
/**  */
@property (nonatomic, copy) NSString *maxtime;
/** 存储最后一次的请求参数*/
@property (nonatomic, strong) NSMutableDictionary *parameters;

@end
@implementation ZCTopicTableViewController

- (NSMutableArray *)topics
{
    if (_topics == nil) {
        _topics = [NSMutableArray array];
    }
    
    return _topics;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupTableView];
    [self refresh];
    
    
}

- (void)setupTableView
{
    
    CGFloat top =  ZCTitilesViewHeight + ZCTitilesViewY;
    CGFloat bottom = self.tabBarController.tabBar.height;
    self.tableView.contentInset = UIEdgeInsetsMake(top + ZCTopicCellMargin, 0, bottom, 0);
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(top + ZCTopicCellMargin, 0, bottom, 0);
    
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZCTopicCell class]) bundle:nil] forCellReuseIdentifier:ZCTopicCellID];
    
}

#pragma mark - 刷新控件
- (void)refresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    [self.tableView.mj_header beginRefreshing];
    //根据下拉的程度自动改变透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopic)];
    
}

#pragma mark - 加载新的帖子数据
- (void)loadNewTopics
{
    //下拉刷新时，先结束上啦刷新
    [self.tableView.mj_footer endRefreshing];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(self.type);
    self.parameters = parameters;
    
    [manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //        [responseObject writeToFile:@"/Users/ZhangCheng/Desktop/duanzi.plist" atomically:YES];
        if (self.parameters != parameters) {
            return ;
        }
        
        self.maxtime = responseObject[@"info"][@"maxtime"];
        [self.tableView.mj_header endRefreshing];
        self.topics = [ZCTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [self.tableView reloadData];
        
        self.page = 0;
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //        ZCLog(@"加载失败----%@", error);
        if (self.parameters != parameters) {
            return ;
        }
        [self.tableView.mj_header endRefreshing];
    }];
}
#pragma mark - 上拉加载更多数据
- (void)loadMoreTopic
{
    //上拉刷新时，先结束下拉刷新
    [self.tableView.mj_header endRefreshing];
    
    self.page ++;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] =  @(self.type);
    parameters[@"page"] = @(self.page);
    parameters[@"maxtime"] = self.maxtime;
    self.parameters = parameters;
    
    [manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (self.parameters != parameters) {
            return ;
        }
        
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        [self.tableView.mj_footer endRefreshing];
        NSArray *newTopic = [ZCTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topics addObjectsFromArray:newTopic];
        
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //        ZCLog(@"加载失败----%@", error);
        if (self.parameters != parameters) {
            return ;
        }
        
        [self.tableView.mj_footer endRefreshing];
        
        self.page--;
    }];
}

#pragma mark - Table View Data Source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    tableView.mj_footer.hidden = self.topics.count == 0;
    return self.topics.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ZCTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:ZCTopicCellID];

    cell.topic = self.topics[indexPath.row];
    
    
    return cell;
}

#pragma mark - Table View Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZCTopic *topic = self.topics[indexPath.row];
    
    

    return topic.cellHeight;
}

@end
