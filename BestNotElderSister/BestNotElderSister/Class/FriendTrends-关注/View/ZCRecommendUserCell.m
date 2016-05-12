//
//  ZCRecommendUserCell.m
//  BestNotElderSister
//
//  Created by ZhangCheng on 16/5/1.
//  Copyright © 2016年 ZhangCheng. All rights reserved.
//

#import "ZCRecommendUserCell.h"
#import "ZCRecommendUser.h"
#import "UIImageView+WebCache.h"

@interface ZCRecommendUserCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansCountLabel;

@end

@implementation ZCRecommendUserCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setUser:(ZCRecommendUser *)user
{
    _user = user;
    
    self.screenNameLabel.text = user.screen_name;
    self.fansCountLabel.text = [NSString stringWithFormat:@"%zd人关注", user.fans_count];
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:user.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
}

@end
