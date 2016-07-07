//
//  DateHelper.m
//  CustomDatePicker
//
//  Created by chuanglong03 on 16/7/7.
//  Copyright © 2016年 chuanglong. All rights reserved.
//

#import "DateHelper.h"

@implementation DateHelper

#pragma mark - 当前时间
+ (NSInteger)setNowTime:(NSInteger)timeType {
    NSDate *nowDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSString *dateString = [dateFormatter stringFromDate:nowDate];
    switch (timeType) {
        case 0: {
            NSRange range = NSMakeRange(0, 4);
            NSString *yearString = [dateString substringWithRange:range];
            return yearString.integerValue;
            break;
        }
        case 1: {
            NSRange range = NSMakeRange(4, 2);
            NSString *yearString = [dateString substringWithRange:range];
            return yearString.integerValue;
            break;
        }
        case 2: {
            NSRange range = NSMakeRange(6, 2);
            NSString *yearString = [dateString substringWithRange:range];
            return yearString.integerValue;
            break;
        }
    }
    return 0;
}

@end
