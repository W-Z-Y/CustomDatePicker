//
//  SelectBirthdayViewController.h
//  hah
//
//  Created by chuanglong03 on 16/5/30.
//  Copyright © 2016年 chuanglong02. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectBirthdayViewControllerDelegate <NSObject>

- (void)finishWithSelectedBirthday:(NSString *)birthday;

@end

@interface SelectBirthdayViewController : UIViewController

@property (nonatomic, assign) id<SelectBirthdayViewControllerDelegate> delegate;

@end
