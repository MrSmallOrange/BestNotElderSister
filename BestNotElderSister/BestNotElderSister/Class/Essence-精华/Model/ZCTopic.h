//
//  ZCTopic.h
//  BestNotElderSister
//
//  Created by ZhangCheng on 16/5/12.
//  Copyright © 2016年 ZhangCheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCTopic : NSObject
/** 头像URL*/
@property (nonatomic, copy) NSString *profile_image;
/** 用户昵称*/
@property (nonatomic, copy) NSString *screen_name;
/** 帖子内容*/
@property (nonatomic, copy) NSString *text;
/** 发帖时间*/
@property (nonatomic, copy) NSString *created_at;
/** 顶*/
@property (nonatomic, assign) NSInteger ding;
/** 踩*/
@property (nonatomic, assign) NSInteger cai;
/** 转发数*/
@property (nonatomic, assign) NSInteger repost;
/** 评论数*/
@property (nonatomic, assign) NSInteger comment;
/** 是否为新浪会员*/
@property (nonatomic, assign, getter=isSina_v) BOOL sina_v;

/** cell高度*/
@property (nonatomic, assign, readonly) CGFloat cellHeight;
/** 图片宽度*/
@property (nonatomic, assign) CGFloat width;
/** 图片高度*/
@property (nonatomic, assign) CGFloat height;
/** 帖子类型*/
@property (nonatomic, assign) ZCTopicType type;

/** 图片高度*/
@property (nonatomic, assign) CGFloat pictureHeight;
/** 图片宽度*/
@property (nonatomic, assign) CGFloat pictureWidth;

/** 小图片URL*/
@property (nonatomic, copy) NSString *small_image;
/** 中图片URL*/
@property (nonatomic, copy) NSString *middle_image;
/** 大图片URL*/
@property (nonatomic, copy) NSString *large_image;
/** 图片空间的frame*/
@property (nonatomic, assign, readonly) CGRect pictureViewFrame;





@end
