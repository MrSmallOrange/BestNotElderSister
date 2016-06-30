//
//  ZCRecommendTagCell.m
//  BestNotElderSister
//
//  Created by ZhangCheng on 16/5/5.
//  Copyright © 2016年 ZhangCheng. All rights reserved.
//

#import "ZCRecommendTagCell.h"
#import "UIImageView+WebCache.h"
#import "ZCRecommendTag.h"

@interface ZCRecommendTagCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageListImageView;
@property (weak, nonatomic) IBOutlet UILabel *themeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subNumberLabel;

@end

@implementation ZCRecommendTagCell

- (void)setRecommendTag:(ZCRecommendTag *)recommendTag
{
    _recommendTag = recommendTag;
    
    [self.imageListImageView sd_setImageWithURL:[NSURL URLWithString:recommendTag.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
     self.themeNameLabel.text = recommendTag.theme_name;
    
    NSString *count = nil;
    
    if (recommendTag.sub_number < 10000) {
        count = [NSString stringWithFormat:@"%zd人订阅", recommendTag.sub_number];
    }else{
        count = [NSString stringWithFormat:@"%.1lf万人订阅", recommendTag.sub_number / 10000.0 ];
    }
    
    self.subNumberLabel.text = count;
     
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.x   = 10;
    frame.size.width -= 2 * frame.origin.x;
    frame.size.height -= 1;
    
    [super setFrame:frame];
    
}
@end
