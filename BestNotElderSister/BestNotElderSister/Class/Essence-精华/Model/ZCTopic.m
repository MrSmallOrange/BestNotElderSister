//
//  ZCTopic.m
//  BestNotElderSister
//
//  Created by ZhangCheng on 16/5/12.
//  Copyright © 2016年 ZhangCheng. All rights reserved.
//

#import "ZCTopic.h"
#import <MJExtension.h>

@implementation ZCTopic
{
    CGFloat _cellHeight;
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"smallImage":@"image0",
             @"largeImage":@"image1",
             @"middleImage":@"image2"
             
             };
}


- (NSString *)created_at
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *createTime = [formatter dateFromString:_created_at];
    
    if (createTime.isThisYear) {//是今年
        if (createTime.isToday) {
            NSDateComponents *components = [[NSDate date] deltaFrom:createTime];
            if (components.hour >= 1 ) {
                return  [NSString stringWithFormat:@"%zd小时前", components.hour];
            }else if(components.minute >= 1){
                return [NSString stringWithFormat:@"%zd分钟前", components.minute];
                
            }else{
                 return @"刚刚";
            }
        }else if (createTime.isYesterday){
            formatter.dateFormat = @"昨天 HH:mm:ss";
            return [formatter stringFromDate:createTime];
        }else{
            formatter.dateFormat = @"MM-dd HH:mm:ss";
            return [formatter stringFromDate:createTime];
        }
    }else{//不是今年
        
        return _created_at;
        
    }
}

- (CGFloat)cellHeight
{
    //文字的Y
    if (!_cellHeight) {
        
        
    
        CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 4 * ZCTopicCellMargin, MAXFLOAT);
        
        CGFloat textH = [_text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height;
        _cellHeight = ZCTopicCellTextY + textH + ZCTopicCellBottomBarHeight + 2 * ZCTopicCellMargin;
        
        if (self.type == ZCTopicTypePicture) {
            _cellHeight += self.height;
        }
    }

    return _cellHeight;
}
@end
