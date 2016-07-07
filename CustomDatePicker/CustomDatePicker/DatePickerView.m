//
//  DatePickerView.m
//  CustomDatePicker
//
//  Created by chuanglong03 on 16/6/20.
//  Copyright © 2016年 chuanglong. All rights reserved.
//

#define kRight 20
#define kLabelHorizonal 10
#define kStartYear 1950

#import "DatePickerView.h"
#import "CustomPickerView.h"

@interface DatePickerView ()<CustomPickerViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) CustomPickerView *yearPicker; // 年
@property (nonatomic, strong) CustomPickerView *monthPicker; // 月
@property (nonatomic, strong) CustomPickerView *dayPicker; // 日
@property (nonatomic, strong) UIButton *confirmButton; // 确认
@property (nonatomic, strong) UIButton *cancelButton; // 取消
@property (nonatomic, assign) NSInteger selectedYear; // 年
@property (nonatomic, assign) NSInteger selectedMonth; // 月
@property (nonatomic, assign) NSInteger selectedDay; // 日

@end

@implementation DatePickerView

@synthesize yearPicker;
@synthesize monthPicker;
@synthesize dayPicker;
@synthesize confirmButton;
@synthesize cancelButton;
@synthesize selectedYear;
@synthesize selectedMonth;
@synthesize selectedDay;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setDatePickerViewWithFrame:frame];
    }
    return self;
}

- (void)setDatePickerViewWithFrame:(CGRect)frame {
    CGFloat width = frame.size.width/7.0;
    CGFloat height = frame.size.height;
    CGFloat pickerHeight = height/4.0*3;
    self.backgroundColor = [UIColor colorWithWhite:0.901 alpha:1.000];
    [self addLabelViewWithFrame:CGRectMake(0, height/4.0, width*7, height/4.0)];
    [self addYearPickerViewWithFrame:CGRectMake(0, 0, width*3-kRight, pickerHeight)];
    [self addMonthPickerViewWithFrame:CGRectMake(width*3, 0, width*2-kRight, pickerHeight)];
    [self addDayPickerViewWithFrame:CGRectMake(width*5, 0, width*2-kRight, pickerHeight)];
    [self addButtonViewWithFrame:CGRectMake(0, pickerHeight, width*7, height/4.0)];
}

- (void)addLabelViewWithFrame:(CGRect)frame {
    CGFloat width = frame.size.width/7.0;
    CGFloat height = frame.size.height;
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = [UIColor colorWithWhite:0.800 alpha:1.000];
    
    // yearLabel
    [view addSubview:[self addLabelWithFrame:CGRectMake(0, 0, width*3-kLabelHorizonal, height) title:@"年"]];
    
    // monthLabel
    [view addSubview:[self addLabelWithFrame:CGRectMake(width*3, 0, width*2-kLabelHorizonal, height) title:@"月"]];
    
    // dayLabel
    [view addSubview:[self addLabelWithFrame:CGRectMake(width*5, 0, width*2-kLabelHorizonal, height) title:@"日"]];
    
    // whiteLine
    UIView *whiteLine1 = [[UIView alloc] initWithFrame:CGRectMake(width*3, 0, 1, height)];
    whiteLine1.backgroundColor = [[UIColor colorWithWhite:0.996 alpha:1.000] colorWithAlphaComponent:0.5];
    [view addSubview:whiteLine1];
    UIView *whiteLine2 = [[UIView alloc] initWithFrame:CGRectMake(width*5, 0, 1, height)];
    whiteLine2.backgroundColor = [[UIColor colorWithWhite:0.996 alpha:1.000] colorWithAlphaComponent:0.5];
    [view addSubview:whiteLine2];
    
    [self addSubview:view];
}

- (UILabel *)addLabelWithFrame:(CGRect)frame title:(NSString *)title {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = title;
    label.textAlignment = NSTextAlignmentRight;
    return label;
}

- (void)addYearPickerViewWithFrame:(CGRect)frame {
    yearPicker = [[CustomPickerView alloc] initWithFrame:frame];
    selectedYear = [self setNowTime:0];
    [yearPicker setSelectedIndex:selectedYear-kStartYear];
    yearPicker.delegate = self;
    [self addSubview:yearPicker];
}

- (void)addMonthPickerViewWithFrame:(CGRect)frame {
    monthPicker = [[CustomPickerView alloc] initWithFrame:frame];
    selectedMonth = [self setNowTime:1];
    [monthPicker setSelectedIndex:selectedMonth-1];
    monthPicker.delegate = self;
    [self addSubview:monthPicker];
}

- (void)addDayPickerViewWithFrame:(CGRect)frame {
    dayPicker = [[CustomPickerView alloc] initWithFrame:frame];
    selectedDay = [self setNowTime:2];
    [dayPicker setSelectedIndex:selectedDay-1];
    dayPicker.delegate = self;
    [self addSubview:dayPicker];
}

- (void)addButtonViewWithFrame:(CGRect)frame {
    CGFloat width = frame.size.width;
    CGFloat height = frame.size.height;
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
    
    // confirmButton
    confirmButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, width/2.0, height)];
    [confirmButton setTitle:@"确定" forState:(UIControlStateNormal)];
    [confirmButton setTitleColor:[UIColor colorWithWhite:0.200 alpha:1.000] forState:(UIControlStateNormal)];
    [confirmButton addTarget:self action:@selector(confirmAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [view addSubview:confirmButton];
    
    // cancelButton
    cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(width/2.0, 0, width/2.0, height)];
    [cancelButton setTitle:@"取消" forState:(UIControlStateNormal)];
    [cancelButton setTitleColor:[UIColor colorWithWhite:0.200 alpha:1.000] forState:(UIControlStateNormal)];
    [cancelButton addTarget:self action:@selector(cancelAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [view addSubview:cancelButton];
    
    // 分割线
    UIView *cutLine1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 1)];
    cutLine1.backgroundColor = [UIColor colorWithRed:1.000 green:0.580 blue:0.302 alpha:1.000];
    [view addSubview:cutLine1];
    UIView *cutLine2 = [[UIView alloc] initWithFrame:CGRectMake(width/2.0, 0, 1, height)];
    cutLine2.backgroundColor = [UIColor colorWithRed:1.000 green:0.580 blue:0.302 alpha:1.000];
    [view addSubview:cutLine2];
    
    [self addSubview:view];
}

- (void)confirmAction:(UIButton *)sender {
    selectedYear = yearPicker.currentIndex+kStartYear;
    selectedMonth = monthPicker.currentIndex+1;
    selectedDay = dayPicker.currentIndex+1;
    self.selectedDate = [NSString stringWithFormat:@"%ld-%ld-%ld", selectedYear, selectedMonth, selectedDay];
    if (self.delegate && [self.delegate respondsToSelector:@selector(confirmAction:)]) {
        [self.delegate confirmAction:sender];
    }
}

- (void)cancelAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancelAction:)]) {
        [self.delegate cancelAction:sender];
    }
}

- (NSInteger)totalRows:(CustomPickerView *)customPickerView {
    if (customPickerView == yearPicker) {
        return selectedYear-kStartYear+1;
    } else if (customPickerView == monthPicker) {
        return 12;
    } else {
        return [self daysWithYear:selectedYear month:selectedMonth];
    }
}

- (void)changeTotalRows:(CustomPickerView *)customPickerView {
    if (customPickerView != dayPicker) {
        dayPicker.totalRows = [self daysWithYear:yearPicker.currentIndex+kStartYear month:monthPicker.currentIndex+1];
        [dayPicker loadData];
    }
}

- (UILabel *)labelAtIndex:(NSInteger)index customPickerView:(CustomPickerView *)customPickerView {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, customPickerView.bounds.size.width, customPickerView.bounds.size.height/3.0)];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    if (customPickerView == yearPicker) {
        label.text = [NSString stringWithFormat:@"%ld", index+kStartYear];
    } else {
        label.text = [NSString stringWithFormat:@"%ld", index+1];
    }
    return label;
}

#pragma mark - 当前时间
- (NSInteger)setNowTime:(NSInteger)timeType {
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

#pragma mark - 获取选中的年中选中月的天数
- (NSInteger)daysWithYear:(NSInteger)year month:(NSInteger)month {
    if (month == 2) {
        if ([self judgeIsLeapYear:year]) {
            return 29;
        }
        return 28;
    } else if (month==4 || month==6 || month==9 || month==11) {
        return 30;
    } else {
        return 31;
    }
}

#pragma mark - 判断年份是否为闰年
- (BOOL)judgeIsLeapYear:(NSInteger)year {
    if(((year%4 == 0) && (year%100 != 0)) || (year%400 == 0)) {
        return YES;
    }
    return NO;
}

@end
