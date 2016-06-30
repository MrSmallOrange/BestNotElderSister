//
//  ZCTopicPictureView.m
//  BestNotElderSister
//
//  Created by MrSmallOrange on 16/6/30.
//  Copyright © 2016年 ZhangCheng. All rights reserved.
//

#import "ZCTopicPictureView.h"
#import "ZCTopic.h"
#import "UIImageView+WebCache.h"

@interface ZCTopicPictureView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigPicture;
@property (weak, nonatomic) IBOutlet UIImageView *gifImageView;

@end


@implementation ZCTopicPictureView


- (void)awakeFromNib
{
 
    self.autoresizingMask = UIViewAutoresizingNone;
}


+ (instancetype)topicPictureView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ZCTopicPictureView class]) owner:nil options:nil] lastObject];
}

- (void)setTopic:(ZCTopic *)topic
{
    _topic = topic;
    

    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.middle_image]];
    
    

}

@end
