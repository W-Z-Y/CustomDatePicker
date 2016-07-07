//
//  ViewController.m
//  CustomDatePicker
//
//  Created by chuanglong03 on 16/6/20.
//  Copyright © 2016年 chuanglong. All rights reserved.
//

#import "ViewController.h"
#import "DatePickerView.h"
#import "SelectBirthdayViewController.h"

@interface ViewController ()<DatePickerViewDelegate, SelectBirthdayViewControllerDelegate>

@property (nonatomic, strong) DatePickerView *datePickerView;
@property (nonatomic, strong) SelectBirthdayViewController *selectBirthdayVC;
@property (nonatomic, strong) UIButton *datePickerButton;
@property (nonatomic, strong) UIButton *selectBirthdayButton;

@end

@implementation ViewController

@synthesize datePickerView;
@synthesize selectBirthdayVC;
@synthesize datePickerButton;
@synthesize selectBirthdayButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupDatePickerButton];
    [self setupSelectBirthdayButton];
}

- (void)setupDatePickerButton {
    datePickerButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    datePickerButton.center = CGPointMake(Device_Width/2.0, Device_Height/4.0);
    [datePickerButton setTitle:@"选择日期" forState:(UIControlStateNormal)];
    [datePickerButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [datePickerButton addTarget:self action:@selector(setupDatePicker) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:datePickerButton];
}

- (void)setupDatePicker {
    CGFloat width = Device_Width-100;
    CGFloat height = width*0.8;
    datePickerView = [[DatePickerView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    datePickerView.center = datePickerButton.center;
    datePickerView.delegate = self;
    [self.view addSubview:datePickerView];
}

- (void)confirmAction:(UIButton *)sender {
    [datePickerButton setTitle:datePickerView.selectedDate forState:(UIControlStateNormal)];
    [datePickerView removeFromSuperview];
}

- (void)cancelAction:(UIButton *)sender {
    [datePickerView removeFromSuperview];
}

- (void)setupSelectBirthdayButton {
    selectBirthdayButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    selectBirthdayButton.center = CGPointMake(Device_Width/2.0, Device_Height/4.0*3);
    [selectBirthdayButton setTitle:@"选择生日" forState:(UIControlStateNormal)];
    [selectBirthdayButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [ selectBirthdayButton addTarget:self action:@selector(setupBirthdayPicker) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:selectBirthdayButton];
}

- (void)setupBirthdayPicker {
    CGFloat width = Device_Width-100;
    CGFloat height = width*0.8;
    selectBirthdayVC = [[SelectBirthdayViewController alloc] init];
    selectBirthdayVC.view.frame = CGRectMake(0, 0, width, height);
    selectBirthdayVC.view.center = selectBirthdayButton.center;
    selectBirthdayVC.delegate = self;
    [self.view addSubview:selectBirthdayVC.view];
    [self addChildViewController:selectBirthdayVC];
}

- (void)finishWithSelectedBirthday:(NSString *)birthday {
    [selectBirthdayButton setTitle:birthday forState:(UIControlStateNormal)];
    [selectBirthdayVC.view removeFromSuperview];
    [selectBirthdayVC removeFromParentViewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
