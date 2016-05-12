//
//  ZCRecommendUser.h
//  BestNotElderSister
//
//  Created by ZhangCheng on 16/5/1.
//  Copyright © 2016年 ZhangCheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCRecommendUser : NSObject
/** 头像*/
@property (nonatomic, copy) NSString *header;
/** 粉丝数*/
@property (nonatomic, assign) NSInteger fans_count;
/** 昵称*/
@property (nonatomic, copy) NSString *screen_name;


@end
