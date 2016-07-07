//
//  DatePickerView.h
//  CustomDatePicker
//
//  Created by chuanglong03 on 16/6/20.
//  Copyright © 2016年 chuanglong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomPickerView;

@protocol DatePickerViewDelegate <NSObject>

- (void)confirmAction:(UIButton *)sender;
- (void)cancelAction:(UIButton *)sender;

@end

@interface DatePickerView : UIView

@property (nonatomic, strong) NSString *selectedDate;
@property (nonatomic, assign) id<DatePickerViewDelegate> delegate;

@end
