//
//  BirthdayPickerView.h
//  hah
//
//  Created by chuanglong03 on 16/5/16.
//  Copyright © 2016年 chuanglong02. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BirthdayPickerView : UIView

@property (nonatomic, strong) UILabel *birthdayLabel; // 显示生日
@property (nonatomic, strong) UIPickerView *yearPicker; // 选择年
@property (nonatomic, strong) UIPickerView *monthPicker; // 选择月
@property (nonatomic, strong) UIPickerView *dayPicker; // 选择日
@property (nonatomic, strong) UIButton *completeButton; // 完成按钮

@end
