//
//  ZCVideoTableViewController.m
//  BestNotElderSister
//
//  Created by ZhangCheng on 16/5/11.
//  Copyright © 2016年 ZhangCheng. All rights reserved.
//

#import "ZCVideoTableViewController.h"

@implementation ZCVideoTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
}

#pragma mark - Table View Data Source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@------%zd", [self class], indexPath.row];
    
    return cell;
}

@end
