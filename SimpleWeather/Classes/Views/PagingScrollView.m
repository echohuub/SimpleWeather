//
//  PagingScrollView.m
//  SimpleWeather
//
//  Created by HeQingbao on 14/11/15.
//  Copyright (c) 2014年 HeQingbao. All rights reserved.
//

#import "PagingScrollView.h"

@implementation PagingScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.pagingEnabled = YES;
        self.bounces = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
    }
    return self;
}

- (void)addWeatherView:(UIView *)weatherView isLaunch:(BOOL)launch
{
    [super addSubview:weatherView];
    
    NSUInteger numSubViews = self.subviews.count;
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat height = CGRectGetHeight(self.bounds);
    weatherView.frame = CGRectMake(width * (numSubViews - 1), 0, width, height);
    self.contentSize = CGSizeMake(width * numSubViews, height);
    
    weatherView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:[NSString stringWithFormat:@"gradient%lu", (unsigned long)numSubViews]]];
    
    if (!launch) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self setContentOffset:CGPointMake(width * (numSubViews - 1), 0) animated:YES];
        });
    }
}

- (void)insertWeatherView:(UIView *)weatherView atIndex:(NSUInteger)index
{
    [super insertSubview:weatherView atIndex:index];
    weatherView.frame = CGRectMake(CGRectGetWidth(self.bounds) * index, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
    NSUInteger numSubviews = self.subviews.count;
    for (NSInteger i = index + 1; i < numSubviews; i++) {
        UIView *view = [self.subviews objectAtIndex:i];
        view.frame = CGRectMake(CGRectGetWidth(self.bounds) * i, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
    }
    self.contentSize = CGSizeMake(CGRectGetWidth(self.bounds) * numSubviews, CGRectGetHeight(self.bounds));
}

- (void)removeWeatherView:(UIView *)weatherView
{
    NSUInteger index = [self.subviews indexOfObject:weatherView];
    if (index != NSNotFound) {
        NSUInteger numSubviews = self.subviews.count;
        for (NSInteger i = index + 1; i < numSubviews; i++) {
            UIView *view = [self.subviews objectAtIndex:i];
            view.frame = CGRectOffset(view.frame, -1.0 * CGRectGetWidth(weatherView.bounds), 0);
        }
        
        [weatherView removeFromSuperview];
        self.contentSize = CGSizeMake(CGRectGetWidth(self.bounds) * (numSubviews - 1), self.contentSize.height);
    }
}

- (void)scrollToIndex:(NSUInteger)index
{
    CGFloat width = CGRectGetWidth(self.bounds);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self setContentOffset:CGPointMake(width * index, 0) animated:YES];
    });
}

- (void)delay:(CGPoint)point
{
    
}

@end
