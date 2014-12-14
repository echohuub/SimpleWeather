//
//  HourlyConditionView.m
//  SimpleWeather
//
//  Created by 何清宝 on 14/12/6.
//  Copyright (c) 2014年 HeQingbao. All rights reserved.
//

#import "HourlyConditionView.h"
#import "HourlyCondition.h"

@interface HourlyConditionView ()

@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *temperatureLabel;

@end

@implementation HourlyConditionView

- (id)initWithFrame:(CGRect)frame
{
    frame.size.width = kHourlyConditionViewWidth;
    frame.size.height = kHourLyConditionViewHeight;

    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RandomColor;
        [self initTimeView];
        [self initIconView];
        [self initTemperatureView];
    }
    return self;
}

- (void)initTimeView
{
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 6, self.bounds.size.width, 20)];
    self.timeLabel.backgroundColor = [UIColor clearColor];
    self.timeLabel.textColor = [UIColor whiteColor];
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    self.timeLabel.text = @"12时";
    self.timeLabel.font = [UIFont fontWithName:LIGHT_FONT size:14.0];
    [self addSubview:self.timeLabel];
}

- (void)initIconView
{
    self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 26, 26)];
    self.iconImageView.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    self.iconImageView.image = [UIImage imageNamed:@"weather_code_day_5"];
    [self addSubview:self.iconImageView];
}

- (void)initTemperatureView
{
    self.temperatureLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 54, self.bounds.size.width, 20)];
    self.temperatureLabel.backgroundColor = [UIColor clearColor];
    self.temperatureLabel.textColor = [UIColor whiteColor];
    self.temperatureLabel.textAlignment = NSTextAlignmentCenter;
    self.temperatureLabel.text = @"18°";
    self.temperatureLabel.font = [UIFont fontWithName:LIGHT_FONT size:14.0];
    [self addSubview:self.temperatureLabel];
}

- (void)setHourlyCondition:(HourlyCondition *)hourlyCondition
{
    _hourlyCondition = hourlyCondition;
    self.timeLabel.text = [NSString stringWithFormat:@"%ld时", (long)hourlyCondition.hour];
    self.temperatureLabel.text = [NSString stringWithFormat:@"%d°", hourlyCondition.temperature.celsius];
    
    NSString *iconName = [NSString stringWithFormat:@"weather_code_day_%ld", (long)hourlyCondition.iconIndex];
    self.iconImageView.image = [UIImage imageNamed:iconName];
}

@end
