//
//  CustomPickerView.m
//  CustomDatePicker
//
//  Created by chuanglong03 on 16/7/4.
//  Copyright © 2016年 chuanglong. All rights reserved.
//

#import "CustomPickerView.h"

@interface CustomPickerView ()<UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *labelsArray;

@end

@implementation CustomPickerView

@synthesize pickerScrollView;
@synthesize totalRows;
@synthesize currentIndex;
@synthesize labelsArray;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat height = self.bounds.size.height;
        pickerScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        pickerScrollView.contentSize = CGSizeMake(0, height/3*5);
        pickerScrollView.showsVerticalScrollIndicator = NO;
        pickerScrollView.contentOffset = CGPointMake(0, height/3);
        pickerScrollView.delegate = self;
        [self addSubview:pickerScrollView];
    }
    return self;
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    currentIndex = selectedIndex;
}

- (void)setDelegate:(id<CustomPickerViewDelegate>)delegate {
    _delegate = delegate;
    [self reloadData];
}

- (void)reloadData {
    if (self.delegate) {
        totalRows = [self.delegate totalRows:self];
    }
    if (totalRows == 0) {
        return;
    }
    [self loadData];
}

- (void)loadData {
    NSArray *subviewsArray = [pickerScrollView subviews];
    if (subviewsArray.count > 0) {
        [subviewsArray makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    [self addObjectsForLabelsArray];
    for (NSInteger i = 0; i < 5; i++) {
        UILabel *label = [labelsArray objectAtIndex:i];
        label.frame = CGRectOffset(label.frame, 0, label.frame.size.height*i);
        [pickerScrollView addSubview:label];
    }
    [pickerScrollView setContentOffset:CGPointMake(0, self.bounds.size.height/3)];
}

- (void)addObjectsForLabelsArray {
    NSInteger index1;
    NSInteger index2;
    NSInteger index3;
    NSInteger index4;
    NSInteger index5;
    if (currentIndex == 0) {
        index1 = totalRows-2;
        index2 = totalRows-1;
        index3 = 0;
        index4 = 1;
        index5 = 2;
    } else if (currentIndex == 1) {
        index1 = totalRows-1;
        index2 = 0;
        index3 = 1;
        index4 = 2;
        index5 = 3;
    } else if (currentIndex >= totalRows-1) {
        index1 = totalRows-3;
        index2 = totalRows-2;
        index3 = totalRows-1;
        index4 = 0;
        index5 = 1;
        if (currentIndex > totalRows-1) {
            currentIndex = totalRows-1;
        }
    } else if (currentIndex == totalRows-2) {
        index1 = totalRows-4;
        index2 = totalRows-3;
        index3 = totalRows-2;
        index4 = totalRows-1;
        index5 = 0;
    } else {
        index1 = currentIndex-2;
        index2 = currentIndex-1;
        index3 = currentIndex;
        index4 = currentIndex+1;
        index5 = currentIndex+2;
    }
    if (!labelsArray) {
        labelsArray = [NSMutableArray array];
    }
    [labelsArray removeAllObjects];
    if (self.delegate) {
        [labelsArray addObject:[self.delegate labelAtIndex:index1 customPickerView:self]];
        [labelsArray addObject:[self.delegate labelAtIndex:index2 customPickerView:self]];
        [labelsArray addObject:[self.delegate labelAtIndex:index3 customPickerView:self]];
        [labelsArray addObject:[self.delegate labelAtIndex:index4 customPickerView:self]];
        [labelsArray addObject:[self.delegate labelAtIndex:index5 customPickerView:self]];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger offsetY = scrollView.contentOffset.y;
    if (offsetY > self.bounds.size.height/3*2) {
        if (currentIndex == totalRows-1) {
            currentIndex = 0;
        } else {
            currentIndex += 1;
        }
        [self loadData];
    }
    if (offsetY < 0) {
        if (currentIndex == 0) {
            currentIndex = totalRows-1;
        } else {
            currentIndex -= 1;
        }
        [self loadData];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [pickerScrollView setContentOffset:CGPointMake(0, self.bounds.size.height/3) animated:YES];
    if (self.delegate) {
        [self.delegate changeTotalRows:self];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [pickerScrollView setContentOffset:CGPointMake(0, self.bounds.size.height/3) animated:YES];
    if (self.delegate) {
        [self.delegate changeTotalRows:self];
    }
}

@end
