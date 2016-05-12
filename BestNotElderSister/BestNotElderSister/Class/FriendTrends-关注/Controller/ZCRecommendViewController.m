//
//  ZCRecommendViewController.m
//  BestNotElderSister
//
//  Created by ZhangCheng on 16/5/1.
//  Copyright © 2016年 ZhangCheng. All rights reserved.
//

#import "ZCRecommendViewController.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "MJExtension.h"
#import "ZCRecommendCategory.h"
#import "ZCRecommendCategoryCell.h"
#import "ZCRecommendUserCell.h"
#import "ZCRecommendUser.h"
#import "MJRefresh.h"
#define ZCCategoryCellID @"category"
#define ZCUserCellID @"user"


@interface ZCRecommendViewController () <UITableViewDelegate, UITableViewDataSource>
/** 模型*/
@property (nonatomic, strong) NSArray *recommendCategories;
/** 模型*/
//@property (nonatomic, strong) NSArray *users;
/** 左侧*/
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
/** 右侧*/
@property (weak, nonatomic) IBOutlet UITableView *userTableView;
/**  */
@property (nonatomic, strong) NSMutableDictionary *parameters;
/** 请求管理者*/
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@end



@implementation ZCRecommendViewController

- (AFHTTPSessionManager *)manager
{
    if (_manager == nil) {
        _manager = [AFHTTPSessionManager manager];
    }
    
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    
    [self setupCategories];

    
    [self setupRefresh];
    


}

- (void)setupCategories
{
    [SVProgressHUD showWithStatus:@"正在加载"];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"category";
    parameters[@"c"] = @"subscribe";
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        self.recommendCategories = [ZCRecommendCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.categoryTableView reloadData];
        
        
        //默认选中首行
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        //让用户表格进入下拉刷新状态
        [self.userTableView.mj_header beginRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];
    
}
- (void)setupTableView
{
    //注册
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZCRecommendCategoryCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:ZCCategoryCellID];
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZCRecommendUserCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:ZCUserCellID];
    
    
    self.categoryTableView.backgroundColor = [UIColor clearColor];
    self.userTableView.backgroundColor = [UIColor clearColor];
    
    self.navigationItem.title = @"推荐关注";
    self.view.backgroundColor = ZCColor(223, 223, 223);
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.rowHeight = 70;
}

- (void)setupRefresh{
    
    self.userTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    
    self.userTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
    self.userTableView.mj_footer.hidden = YES;
}

#pragma mark - 刷新加载更多数据
- (void)loadNewUsers
{
    ZCRecommendCategory *category = self.recommendCategories[self.categoryTableView.indexPathForSelectedRow.row];

    
    //设置当前页为1
    category.current_page = 1;
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"subscribe";
    parameters[@"category_id"] = @(category.id);
    parameters[@"page"] = @(category.current_page);
    self.parameters = parameters;
    
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *user = [ZCRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [category.users removeAllObjects];
        
        [category.users addObjectsFromArray:user];
        
        category.total  = [responseObject[@"total"] integerValue];
        
        
        if (self.parameters != parameters) {
            return ;
        }
        
       
        [self.userTableView reloadData];
        
        [self.userTableView.mj_header endRefreshing];
        
        if (category.total == category.users.count) {
            [self.userTableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self.userTableView.mj_footer endRefreshing];
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (self.parameters != parameters) {
            return ;
        }
        
        [SVProgressHUD showErrorWithStatus:@"网络加载失败"];
        [self.userTableView.mj_header endRefreshing];
    }];
}



- (void)loadMoreUsers
{
    ZCRecommendCategory *category = self.recommendCategories[self.categoryTableView.indexPathForSelectedRow.row];

    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"subscribe";
    parameters[@"category_id"] = @(category.id);
    parameters[@"page"] = @(++category.current_page);
    self.parameters = parameters;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *user = [ZCRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [category.users addObjectsFromArray:user];
        
        
        if (self.parameters != parameters) {
            return ;
        }
        

        [self.userTableView reloadData];
        
        if (category.total == category.users.count) {
            [self.userTableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self.userTableView.mj_footer endRefreshing];
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (self.parameters != parameters) {
            return ;
        }
        
        [SVProgressHUD showErrorWithStatus:@"网络加载失败"];
        [self.userTableView.mj_header endRefreshing];
    }];

}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.categoryTableView) {
        return  self.recommendCategories.count;
    }else{
        
        ZCRecommendCategory *category = self.recommendCategories[self.categoryTableView.indexPathForSelectedRow.row];
        //每次刷新表格后，控制footer的隐藏和出现
        self.userTableView.mj_footer.hidden = (category.users.count == 0);
        
        if (category.total == category.users.count) {
            [self.userTableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self.userTableView.mj_footer endRefreshing];
        }
//
        return category.users.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.categoryTableView) {
        ZCRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:ZCCategoryCellID];
        cell.category = self.recommendCategories[indexPath.row];
        return cell;
    }else{
        ZCRecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:ZCUserCellID];
        
        ZCRecommendCategory *category = self.recommendCategories[self.categoryTableView.indexPathForSelectedRow.row];
        cell.user = category.users[indexPath.row];
        
        
        return cell;
    }
}

#pragma mark -UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self.userTableView.mj_header endRefreshing];
    [self.userTableView.mj_footer endRefreshing];
    
    ZCRecommendCategory *category = self.recommendCategories[indexPath.row];
    
    
    if (category.users.count) {
        
        [self.userTableView reloadData];
        
    }else{
        [self.userTableView reloadData];
        
        [self.userTableView.mj_header beginRefreshing];

    }
    
}

//销毁控制器后取消所有的请求
- (void)dealloc
{
    [SVProgressHUD dismiss];
    [self.manager.operationQueue cancelAllOperations];
}

@end
