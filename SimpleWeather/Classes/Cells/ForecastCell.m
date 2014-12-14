//
//  ForecastCell.m
//  SimpleWeather
//
//  Created by HeQingbao on 14/11/19.
//  Copyright (c) 2014年 HeQingbao. All rights reserved.
//

#import "ForecastCell.h"
#import "HourlyConditionView.h"
#import "DailyConditionView.h"
#import "Weather.h"

#define kHeight 337

@interface ForecastCell ()

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIView *dailyForecastView;
@property (nonatomic, strong) DailyConditionView *dailyConditionView;

@end

@implementation ForecastCell

+ (CGFloat)height
{
    return kHeight + kCellMargin;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self initHourlyScrollView];
    [self initDailyListView];
}

- (void)initHourlyScrollView
{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 36, CGRectGetWidth(self.bounds), kHourLyConditionViewHeight)];
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    [self.contentView addSubview:self.scrollView];
}

// 5 * 36 = 180
- (void)initDailyListView
{
    self.dailyForecastView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.scrollView.frame), self.bounds.size.width, 180)];
    [self.contentView addSubview:self.dailyForecastView];
}

- (void)setupHourlyScrollView
{
    NSArray *array = self.weather.hourlyForecast;
    if (self.scrollView.subviews.count == 0) {
        NSUInteger count = array.count;
        
        self.scrollView.contentSize = CGSizeMake(count * kHourlyConditionViewWidth, kHourLyConditionViewHeight);
        for (NSUInteger i = 0; i < count; i++) {
            HourlyConditionView *view = [[HourlyConditionView alloc] initWithFrame:CGRectMake(i * kHourlyConditionViewWidth, 0, 0, 0)];
            view.hourlyCondition = array[i];
            [self.scrollView addSubview:view];
        }
    } else {
        [self.scrollView.subviews enumerateObjectsUsingBlock:^(HourlyConditionView *view, NSUInteger idx, BOOL *stop) {
            view.hourlyCondition = array[idx];
        }];
    }
}

- (void)setupDailyListView
{
    if (self.dailyForecastView.subviews.count == 0) {
        for (NSInteger i = 0; i < 5; i++) {
            DailyConditionView *view = [[DailyConditionView alloc] initWithFrame:CGRectMake(0, i * 36, 300, 36)];
            view.backgroundColor = RandomColor;
            view.dailyCondition = self.weather.dailyForecast[i];
            [self.dailyForecastView addSubview:view];
        }
    } else {
        [self.dailyForecastView.subviews enumerateObjectsUsingBlock:^(DailyConditionView *view, NSUInteger idx, BOOL *stop) {
            view.dailyCondition = self.weather.dailyForecast[idx];
        }];
    }
}

- (void)setFrame:(CGRect)frame
{
    frame.size.height = kHeight;
    [super setFrame:frame];
}

- (void)setWeather:(Weather *)weather
{
    _weather = weather;
    [self setupHourlyScrollView];
    [self setupDailyListView];
}

@end
