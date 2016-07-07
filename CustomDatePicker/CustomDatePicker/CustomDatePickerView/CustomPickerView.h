//
//  CustomPickerView.h
//  CustomDatePicker
//
//  Created by chuanglong03 on 16/7/4.
//  Copyright © 2016年 chuanglong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomPickerView;

@protocol CustomPickerViewDelegate <NSObject>

- (NSInteger)totalRows:(CustomPickerView *)customPickerView;
- (UILabel *)labelAtIndex:(NSInteger)index customPickerView:(CustomPickerView *)customPickerView;
- (void)changeTotalRows:(CustomPickerView *)customPickerView;

@end

@interface CustomPickerView : UIView

@property (nonatomic, strong) UIScrollView *pickerScrollView;
@property (nonatomic, assign) NSInteger totalRows;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, assign) id<CustomPickerViewDelegate> delegate;

- (void)setSelectedIndex:(NSInteger)selectedIndex;
- (void)reloadData;
- (void)loadData;

@end