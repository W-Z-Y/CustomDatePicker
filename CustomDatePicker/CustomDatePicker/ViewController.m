//
//  ViewController.m
//  CustomDatePicker
//
//  Created by chuanglong03 on 16/6/20.
//  Copyright © 2016年 chuanglong. All rights reserved.
//

#import "ViewController.h"
#import "DatePickerView.h"

@interface ViewController ()<DatePickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *birthdayButton;
@property (nonatomic, strong) DatePickerView *datePicker;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)setBirthday:(UIButton *)sender {
    CGFloat width = [UIScreen mainScreen].bounds.size.width-100;
    CGFloat height = width*0.8;
    DatePickerView *datePicker = [[DatePickerView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    datePicker.center = self.view.center;
    datePicker.delegate = self;
    [self.view addSubview:datePicker];
    self.datePicker = datePicker;
}

- (void)confirmAction:(UIButton *)sender {
    [self.datePicker removeFromSuperview];
    [self.birthdayButton setTitle:self.datePicker.selectedDate forState:(UIControlStateNormal)];
}

- (void)cancelAction:(UIButton *)sender {
    [self.datePicker removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
