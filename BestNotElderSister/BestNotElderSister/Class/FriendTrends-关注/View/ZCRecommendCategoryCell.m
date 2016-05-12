//
//  ZCRecommendCategoryCell.m
//  BestNotElderSister
//
//  Created by ZhangCheng on 16/5/1.
//  Copyright © 2016年 ZhangCheng. All rights reserved.
//

#import "ZCRecommendCategoryCell.h"
#import "ZCRecommendCategory.h"

@interface ZCRecommendCategoryCell ()
@property (weak, nonatomic) IBOutlet UIView *selectedIndicator;

@end
@implementation ZCRecommendCategoryCell

- (void)awakeFromNib {
    self.backgroundColor = ZCColor(244, 244, 244);
    self.selectedIndicator.backgroundColor = ZCColor(219, 21, 26);
    self.textLabel.textColor = ZCColor(78, 78, 78);
    self.textLabel.highlightedTextColor = ZCColor(219, 21, 26);

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.selectedIndicator.hidden = !selected;
    self.textLabel.textColor = selected ? ZCColor(219, 21, 26) : ZCColor(78, 78, 78);
}

- (void)setCategory:(ZCRecommendCategory *)category
{
    _category = category;
    
    self.textLabel.text = category.name;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.textLabel.y = 2;
    self.textLabel.height = self.contentView.height - 2 * self.textLabel.y;
}


@end
