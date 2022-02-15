//
//  NSDate+Calendar.m
//  linyi
//
//  Created by caike on 2017/3/13.
//  Copyright © 2017年 com.kunekt.healthy. All rights reserved.
//

#import "NSDate+Calendar.h"

@implementation NSDate (Calendar)

- (NSInteger)dateDay {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitDay fromDate:self];
    return components.day;
}

- (NSInteger)dateMonth {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitMonth fromDate:self];
    return components.month;
}

- (NSInteger)dateYear {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear fromDate:self];
    return components.year;
}

//获取date的下个月日期
- (NSDate *)nextMonthDate {
    NSDateComponents *components = [[NSDateComponents alloc]init];
    components.month = 1;
    NSDate *nextMonthDate = [[[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian] dateByAddingComponents:components toDate:self options:NSCalendarMatchStrictly];
    return nextMonthDate;
}

//获取date的上一月日期
- (NSDate *)previousMonthDate {
    NSDateComponents *components = [[NSDateComponents alloc]init];
    components.month = -1;
    NSDate *previousMonthDate = [[[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian] dateByAddingComponents:components toDate:self options:NSCalendarMatchStrictly];
    return previousMonthDate;
}


- (NSInteger)totalDaysInMonth {
    NSInteger totalDays = [[[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self].length;
    return totalDays;
}

- (NSInteger)firstWeekDayInMonth {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
    components.day = 1; // 定位到当月第一天
    NSDate *firstDay = [calendar dateFromComponents:components];
    
    // 默认一周第一天序号为 1 ，而日历中约定为 0 ，故需要减一
    NSInteger firstWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDay] - 1;
    
    return firstWeekday;
}

- (NSDate *)dateStartMonthOfDate {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *firstDay;
    [calendar rangeOfUnit:NSCalendarUnitMonth startDate:&firstDay interval:nil forDate:self];
    return firstDay;
}

+ (NSInteger)getCurrentYear {
    NSDate *date =[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.locale=[[NSLocale alloc]initWithLocaleIdentifier:@"en_us"];
    formatter.calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    
    [formatter setDateFormat:@"YYYY"];
    NSInteger currentYear=[[formatter stringFromDate:date] integerValue];
    return currentYear;
}

@end
