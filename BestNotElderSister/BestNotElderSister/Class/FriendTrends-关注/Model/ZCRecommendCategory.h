//
//  ZCRecommendCategory.h
//  BestNotElderSister
//
//  Created by ZhangCheng on 16/5/1.
//  Copyright © 2016年 ZhangCheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCRecommendCategory : NSObject
/** id*/
@property (nonatomic, assign) NSInteger id;
/** 总数*/
@property (nonatomic, assign) NSInteger count;
/** 名字*/
@property (nonatomic, copy) NSString *name;

/**  */
@property (nonatomic, strong) NSMutableArray *users;
/** 总页数*/
@property (nonatomic, assign) NSInteger total_page;
/** 总数*/
@property (nonatomic, assign) NSInteger total;
/** 下一页*/
@property (nonatomic, assign) NSInteger next_page;
/** 当前页*/
@property (nonatomic, assign) NSInteger current_page;


@end
