//
//  ZCRecommendCategory.m
//  BestNotElderSister
//
//  Created by ZhangCheng on 16/5/1.
//  Copyright © 2016年 ZhangCheng. All rights reserved.
//

#import "ZCRecommendCategory.h"
#import "MJExtension.h"

@implementation ZCRecommendCategory
- (NSMutableArray *)users
{
    if (_users == nil) {
        _users = [NSMutableArray array];
    }
    
    return _users;
}
@end
