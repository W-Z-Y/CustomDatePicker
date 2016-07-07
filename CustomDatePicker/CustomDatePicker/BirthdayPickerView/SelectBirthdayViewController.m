//
//  SelectBirthdayViewController.m
//  hah
//
//  Created by chuanglong03 on 16/5/30.
//  Copyright © 2016年 chuanglong02. All rights reserved.
//

#define kHorizonal 20
#define kCount self.yearsArray.count

#import "SelectBirthdayViewController.h"
#import "BirthdayPickerView.h"

@interface SelectBirthdayViewController ()<UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) BirthdayPickerView *birPickerView; // 选择生日
@property (nonatomic, strong) NSMutableArray *yearsArray; // 存储年份
@property (nonatomic, strong) NSMutableArray *monthsArray; //存储月份
@property (nonatomic, strong) NSMutableArray *daysArray; // 存储天
@property (nonatomic, strong) NSMutableArray *grayDaysArray; // 存储不存在的天所在的行
@property (nonatomic, assign) NSInteger year; // 年
@property (nonatomic, assign) NSInteger month; // 月
@property (nonatomic, assign) NSInteger day; // 日

@end

@implementation SelectBirthdayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置初始数据
    [self setInitialData];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self addBirthdayPickerView];
}

#pragma mark - 设置初始数据
- (void)setInitialData {
    self.yearsArray = [NSMutableArray array];
    self.grayDaysArray = [NSMutableArray array];
    for (NSInteger i = 1900; i < 2101; i++) {
        [self.yearsArray addObject:[NSString stringWithFormat:@"%ld年", (long)i]];
        for (NSInteger j = 1; j < 13; j++) {
            if (j==2 || j==4 || j==6 || j==9 || j==11) {
                if (j == 2) {
                    if (![self judgeIsLeapYear:i]) {
                        [self.grayDaysArray addObject:[NSNumber numberWithInteger:(i-1900)*12*31+(j-1)*31+29-1]];
                    }
                    [self.grayDaysArray addObject:[NSNumber numberWithInteger:(i-1900)*12*31+(j-1)*31+30-1]];
                }
                [self.grayDaysArray addObject:[NSNumber numberWithInteger:(i-1900)*12*31+(j-1)*31+31-1]];
            }
        }
    }
    self.monthsArray = [NSMutableArray array];
    self.daysArray = [NSMutableArray array];
    for (NSInteger i = 1; i < 32; i++) {
        if (i < 13) {
            [self.monthsArray addObject:[NSString stringWithFormat:@"%ld月", (long)i]];
        }
        NSString *str = nil;
        if (i < 10) {
            str = [NSString stringWithFormat:@"0%ld日", (long)i];
        } else {
            str = [NSString stringWithFormat:@"%ld日", (long)i];
        }
        [self.daysArray addObject:str];
    }
}

#pragma mark - 添加生日选择页面
- (void)addBirthdayPickerView {
    self.birPickerView = [[BirthdayPickerView alloc] initWithFrame:self.view.bounds];
    self.birPickerView.yearPicker.delegate = self;
    self.birPickerView.yearPicker.dataSource = self;
    self.birPickerView.monthPicker.delegate = self;
    self.birPickerView.monthPicker.dataSource = self;
    self.birPickerView.dayPicker.delegate = self;
    self.birPickerView.dayPicker.dataSource = self;
    [self scrollToTodayWithPickerView];
    [self.birPickerView.completeButton addTarget:self action:@selector(completeAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.birPickerView.completeButton addTarget:self action:@selector(setBackGroundColorForHighLighted:) forControlEvents:(UIControlEventTouchDown)];
    [self.view addSubview:self.birPickerView];
}

#pragma mark - 完成生日选择
- (void)completeAction:(UIButton *)sender {
    sender.backgroundColor = [UIColor clearColor];
    if (self.delegate && [self.delegate respondsToSelector:@selector(finishWithSelectedBirthday:)]) {
        [self.delegate finishWithSelectedBirthday:[NSString stringWithFormat:@"%ld-%ld-%ld", (long)self.year, (long)self.month, (long)self.day]];
    }
}

#pragma mark - 完成按钮高亮状态下的颜色
- (void)setBackGroundColorForHighLighted:(UIButton *)sender {
    sender.backgroundColor = [UIColor cyanColor];
}

#pragma mark - pickerView 滚动到当天
- (void)scrollToTodayWithPickerView {
    // 年
    self.year = [DateHelper setNowTime:0];
    NSInteger yearRow = [self.yearsArray indexOfObject:[NSString stringWithFormat:@"%ld年", (long)self.year]];
    [self.birPickerView.yearPicker selectRow:yearRow inComponent:0 animated:NO];
    // 月
    self.month = [DateHelper setNowTime:1];
    NSInteger monthRow = (self.year-1900)*12+[self.monthsArray indexOfObject:[NSString stringWithFormat:@"%ld月", (long)self.month]];
    [self.birPickerView.monthPicker selectRow:monthRow inComponent:0 animated:NO];
    // 日
    self.day = [DateHelper setNowTime:2];
    NSString *dayString = nil;
    if (self.day < 10) {
        dayString = [NSString stringWithFormat:@"0%ld日", (long)self.day];
    } else {
        dayString = [NSString stringWithFormat:@"%ld日", (long)self.day];
    }
    NSInteger dayRow = (self.year-1900)*12*31+(self.month-1)*31+[self.daysArray indexOfObject:dayString];
    [self.birPickerView.dayPicker selectRow:dayRow inComponent:0 animated:NO];
    // 在 label 上显示生日
    self.birPickerView.birthdayLabel.text = [NSString stringWithFormat:@"%ld-%ld-%ld", (long)self.year, (long)self.month, (long)self.day];
}

#pragma mark - 列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

#pragma mark - 每列的行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (pickerView == self.birPickerView.yearPicker) {
        return kCount;
    } else if (pickerView == self.birPickerView.monthPicker) {
        return kCount*12;
    } else {
        return kCount*12*31;
    }
}

#pragma mark - 行高
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return self.birPickerView.yearPicker.frame.size.height/3.0;
}

#pragma mark - 列的宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return self.birPickerView.yearPicker.frame.size.width;
}

#pragma mark - 自定义视图
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(12.0f, 0.0f, [pickerView rowSizeForComponent:component].width-12, [pickerView rowSizeForComponent:component].height)];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    if (pickerView == self.birPickerView.yearPicker) {
        label.text = self.yearsArray[row];
    } else if (pickerView == self.birPickerView.monthPicker) {
        label.text = self.monthsArray[row%12];
    } else {
        label.text = self.daysArray[row%31];
        if ([self.grayDaysArray containsObject:[NSNumber numberWithInteger:row]]) {
            label.textColor = [UIColor grayColor];
        }
    }
    return label;
}

#pragma mark - 选中的行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (pickerView == self.birPickerView.yearPicker) {
        [self.birPickerView.monthPicker selectRow:row*12+self.month-1 inComponent:0 animated:NO];
        [self.birPickerView.dayPicker selectRow:row*12*31+(self.month-1)*31+self.day-1 inComponent:0 animated:NO];
        self.year = [[self.yearsArray objectAtIndex:row] integerValue];
    } else if (pickerView == self.birPickerView.monthPicker) {
        [self.birPickerView.yearPicker selectRow:row/12 inComponent:0 animated:YES];
        [self.birPickerView.dayPicker selectRow:row*31+self.day-1 inComponent:0 animated:NO];
        self.year = [[self.yearsArray objectAtIndex:row/12] integerValue];
        self.month = row%12+1;
    } else {
        NSInteger yearRow = row/(12*31);
        NSInteger monthRow = (row%(12*31))/31;
        NSInteger dayRow = row%31;
        if ([self.grayDaysArray containsObject:[NSNumber numberWithInteger:row]]) {
            if ((monthRow+1) == 2) {
                if (![self judgeIsLeapYear:[[self.yearsArray objectAtIndex:yearRow] integerValue]]) {
                    if ((dayRow+1) == 31) {
                        [self.birPickerView.dayPicker selectRow:row-3 inComponent:0 animated:YES];
                    } else if ((dayRow+1) == 30) {
                        [self.birPickerView.dayPicker selectRow:row-2 inComponent:0 animated:YES];
                    } else {
                        [self.birPickerView.dayPicker selectRow:row-1 inComponent:0 animated:YES];
                    }
                    self.day = 28;
                } else {
                    if ((dayRow+1) == 31) {
                        [self.birPickerView.dayPicker selectRow:row-2 inComponent:0 animated:YES];
                    } else {
                        [self.birPickerView.dayPicker selectRow:row-1 inComponent:0 animated:YES];
                    }
                    self.day = 29;
                }
            } else {
                [self.birPickerView.dayPicker selectRow:row-1 inComponent:0 animated:YES];
                self.day = 30;
            }
        } else {
            self.day = dayRow+1;
        }
        [self.birPickerView.yearPicker selectRow:yearRow inComponent:0 animated:YES];
        [self.birPickerView.monthPicker selectRow:monthRow inComponent:0 animated:YES];
        self.year = [[self.yearsArray objectAtIndex:yearRow] integerValue];
        self.month = monthRow+1;
    }
    self.birPickerView.birthdayLabel.text = [NSString stringWithFormat:@"%ld-%ld-%ld", (long)self.year, (long)self.month, (long)self.day];
}

#pragma mark - 判断年份是否为闰年
- (BOOL)judgeIsLeapYear:(NSInteger)year {
    if(((year%4 == 0) && (year%100 != 0)) || (year%400 == 0)) {
        return YES;
    }
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
