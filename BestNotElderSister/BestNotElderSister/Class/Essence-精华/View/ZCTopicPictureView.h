//
//  ZCTopicPictureView.h
//  BestNotElderSister
//
//  Created by MrSmallOrange on 16/6/30.
//  Copyright © 2016年 ZhangCheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZCTopic;
@interface ZCTopicPictureView : UIView
+ (instancetype)topicPictureView;
/** 模型*/
@property (nonatomic, strong) ZCTopic *topic;
@end
