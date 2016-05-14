//
//  ZCTopicCell.m
//  BestNotElderSister
//
//  Created by ZhangCheng on 16/5/13.
//  Copyright © 2016年 ZhangCheng. All rights reserved.
//

#import "ZCTopicCell.h"
#import "UIImageView+WebCache.h"
#import "ZCTopic.h"

@interface ZCTopicCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;

@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIImageView *sina_v;
@property (weak, nonatomic) IBOutlet UILabel *contentTextLabel;

@end

@implementation ZCTopicCell
- (IBAction)follow:(id)sender {
    ZCLog(@"follow");
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    
    return self;
}

- (void)awakeFromNib
{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"mainCellBackground"];
    imageView.layer.masksToBounds = YES;
    imageView.layer.cornerRadius = 10;
    self.backgroundView = imageView;
}

- (void)setTopic:(ZCTopic *)topic
{
    _topic = topic;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.nameLabel.text = topic.screen_name;
    


    self.sina_v.hidden = !topic.isSina_v;
    
    
    self.createTimeLabel.text = topic.created_at;
    [self setButton:self.dingButton titleWithNumber:topic.ding placeholder:@"顶"];
    [self setButton:self.caiButton titleWithNumber:topic.cai placeholder:@"踩"];
    [self setButton:self.shareButton titleWithNumber:topic.repost placeholder:@"分享"];
    [self setButton:self.commentButton titleWithNumber:topic.comment placeholder:@"评论"];
    
    self.contentTextLabel.text = topic.text;
}
//设置cell的间隔
- (void)setFrame:(CGRect)frame
{
    frame.origin.x = ZCTopicCellMargin;
    frame.size.width -= 2 * frame.origin.x;
    frame.origin.y += ZCTopicCellMargin;
    frame.size.height -= ZCTopicCellMargin ;
    
    [super setFrame:frame];
}

- (void)setButton:(UIButton *)button titleWithNumber:(NSInteger)number placeholder:(NSString * )placeholder
{
    
    NSString *titleText = nil;
    if (number == 0) {
        titleText = placeholder;
    }else if (number > 10000) {
        titleText = [NSString stringWithFormat:@"%.1lf万", number /10000.0];
    }else{
        titleText = [NSString stringWithFormat:@"%zd", number];
    }
    
    [button setTitle:titleText forState:UIControlStateNormal];
}

@end
