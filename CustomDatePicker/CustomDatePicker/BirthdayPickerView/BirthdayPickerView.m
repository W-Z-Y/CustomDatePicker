//
//  BirthdayPickerView.m
//  hah
//
//  Created by chuanglong03 on 16/5/16.
//  Copyright © 2016年 chuanglong02. All rights reserved.
//

#define kLabelHorizonal 10
#define kLabelHeight 50
#define kLineHeight 1
#define kButtonHeight 50
#define kPickerTop 10
#define kPickerLeft 30
#define kPickerMiddle 20

#import "BirthdayPickerView.h"

@implementation BirthdayPickerView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupBirthdayPickerViewWithFrame:frame];
    }
    return self;
}

- (void)setupBirthdayPickerViewWithFrame:(CGRect)frame {
    CGFloat width = frame.size.width;
    CGFloat height = frame.size.height;
    self.backgroundColor = [UIColor darkGrayColor];
    // 显示生日
    self.birthdayLabel = [[UILabel alloc] initWithFrame:CGRectMake(kLabelHorizonal, 0, width-2*kLabelHorizonal, kLabelHeight)];
    self.birthdayLabel.textColor = [UIColor cyanColor];
    [self addSubview:self.birthdayLabel];
    // 青色长直线
    UIView *cyanLongLine = [[UIView alloc] initWithFrame:CGRectMake(0, kLabelHeight, width, kLineHeight)];
    cyanLongLine.backgroundColor = [UIColor cyanColor];
    [self addSubview:cyanLongLine];
    CGFloat pickerY = kLabelHeight+kLineHeight+kPickerTop;
    CGFloat pickerWidth = (width-2*kPickerLeft-2*kPickerMiddle)/3.0;
    CGFloat pickerHeight = height-kButtonHeight-2*kLineHeight-kLabelHeight-2*kPickerTop;
    // 选择年
    self.yearPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(kPickerLeft, pickerY, pickerWidth, pickerHeight)];
    [self addSubview:self.yearPicker];
    // 选择月
    CGFloat monthX = kPickerLeft+pickerWidth+kPickerMiddle;
    self.monthPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(monthX, pickerY, pickerWidth, pickerHeight)];
    [self addSubview:self.monthPicker];
    // 选择日
    CGFloat dayX = monthX+pickerWidth+kPickerMiddle;
    self.dayPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(dayX, pickerY, pickerWidth, pickerHeight)];
    [self addSubview:self.dayPicker];
    // 青色短直线
    for (NSInteger i = 0; i < 6; i++) {
        CGFloat shortLineX = 0;
        CGFloat shortLineY = 0;
        if (i < 3) {
            shortLineX = kPickerLeft+i*(pickerWidth+kPickerMiddle);
            shortLineY = pickerY+pickerHeight/3.0-kLineHeight/2.0;
        } else {
            shortLineX = kPickerLeft+(i-3)*(pickerWidth+kPickerMiddle);
            shortLineY = pickerY+pickerHeight/3.0*2-kLineHeight/2.0;
        }
        UIView *cyanShortLine = [[UIView alloc] initWithFrame:CGRectMake(shortLineX, shortLineY, pickerWidth, kLineHeight)];
        cyanShortLine.backgroundColor = [UIColor cyanColor];
        [self addSubview:cyanShortLine];
    }
    // 灰色直线
    UIView *grayLongLine = [[UIView alloc] initWithFrame:CGRectMake(0, height-kButtonHeight-kLineHeight, width, kLineHeight)];
    grayLongLine.backgroundColor = [UIColor grayColor];
    [self addSubview:grayLongLine];
    // 完成按钮
    self.completeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, height-kButtonHeight, width, kButtonHeight)];
    [self.completeButton setTitle:@"完成" forState:(UIControlStateNormal)];
    [self.completeButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [self addSubview:self.completeButton];
}

@end
