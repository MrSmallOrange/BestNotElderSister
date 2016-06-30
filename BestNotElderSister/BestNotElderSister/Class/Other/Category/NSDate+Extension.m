//
//  NSDate+Extension.m
//  BestNotElderSister
//
//  Created by ZhangCheng on 16/5/14.
//  Copyright © 2016年 ZhangCheng. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)
- (NSDateComponents *)deltaFrom:(NSDate *)from
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *components = [calendar components:unit fromDate:from toDate:self options:0];
    
    return components;
}
- (BOOL)isThisYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *components = [calendar components:unit fromDate:[NSDate date] toDate:self options:0];
    
    return components.year == 0;
}

- (BOOL)isToday
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *components = [calendar components:unit fromDate:[NSDate date] toDate:self options:0];
    
    return components.year == 0 && components.month == 0 && components.day == 0;
}

- (BOOL)isYesterday
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    
    NSDate *lastDate = [formatter dateFromString:[formatter stringFromDate:self]];
    NSDate *now = [formatter dateFromString:[formatter stringFromDate:[NSDate date]]];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    
    NSDateComponents *components = [calendar components:unit fromDate:lastDate toDate:now options:0];
    
    return components.year == 0 && components.month == 0 && components.day == 1;

    
}


@end
