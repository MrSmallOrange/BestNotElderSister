//
//  ZCRecommendTag.h
//  BestNotElderSister
//
//  Created by ZhangCheng on 16/5/5.
//  Copyright © 2016年 ZhangCheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCRecommendTag : NSObject
/** 图片*/
@property (nonatomic, copy) NSString *image_list;
/** 名字*/
@property (nonatomic, copy) NSString *theme_name;
/** 订阅数*/
@property (nonatomic, assign) NSInteger sub_number;


@end
