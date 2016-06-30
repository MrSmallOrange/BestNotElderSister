//
//  ZCTabBar.m
//  BestNotElderSister
//
//  Created by ZhangCheng on 16/4/30.
//  Copyright © 2016年 ZhangCheng. All rights reserved.
//

#import "ZCTabBar.h"

@interface ZCTabBar ()
/** publish*/
@property (nonatomic, weak) UIButton *publishButton;
@end
@implementation ZCTabBar
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *publishButton = [[UIButton alloc] init];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateSelected];
        [self setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
        [self addSubview:publishButton];
        self.publishButton = publishButton;
        
//        publishButton.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
    
    CGFloat width = self.width / 5;
    CGFloat height = self.height;
    CGFloat y = 0;
    NSUInteger index = 0;
    
    self.publishButton.y = y;
    self.publishButton.x = (self.width - self.publishButton.width) * 0.5;
    [self.publishButton sizeToFit];
    
    for (UIView *button in self.subviews) {
        if ([button isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            
            if (index == 2) {
                index ++;
            }
            button.y = y;
            button.x = index * width;
            button.width = width;
            button.height = height;
            
            
            index ++;
        }
    }
}
@end
