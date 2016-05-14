//
//  ZCRecommendTagsViewController.m
//  BestNotElderSister
//
//  Created by ZhangCheng on 16/5/5.
//  Copyright © 2016年 ZhangCheng. All rights reserved.
//

#import "ZCRecommendTagsViewController.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "MJExtension.h"
#import "ZCRecommendTag.h"
#import "ZCRecommendTagCell.h"
#define ZCRecommendTagID @"tag"

@interface ZCRecommendTagsViewController ()
@property (nonatomic, strong) NSArray *recommendTags;

@end

@implementation ZCRecommendTagsViewController

- (NSArray *)recommendTags
{
    if (_recommendTags == nil) {
        _recommendTags = [NSArray array];
    }
    
    return _recommendTags;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZCRecommendTagCell class]) bundle:nil] forCellReuseIdentifier:ZCRecommendTagID];
    
    self.tableView.rowHeight = 70;
    self.tableView.backgroundColor = ZCColor(223, 223, 223);
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    [SVProgressHUD showWithStatus:@"正在加载"];
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"tag_recommend";
    parameters[@"action"] = @"sub";
    parameters[@"c"] = @"topic";
    

    [manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        
        self.recommendTags = [ZCRecommendTag mj_objectArrayWithKeyValuesArray:responseObject];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"网络加载失败"];
    }];

}

- (void)viewDidDisappear:(BOOL)animated
{
    [SVProgressHUD dismiss];
}

#pragma mark - TableView Data Source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.recommendTags.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZCRecommendTagCell *cell = [tableView dequeueReusableCellWithIdentifier:ZCRecommendTagID];
    cell.recommendTag = self.recommendTags[indexPath.row];
    
    
    return cell;
}


@end
