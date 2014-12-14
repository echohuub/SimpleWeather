//
//  DailyConditionView.m
//  SimpleWeather
//
//  Created by 何清宝 on 14/12/6.
//  Copyright (c) 2014年 HeQingbao. All rights reserved.
//

#import "DailyConditionView.h"

@interface DailyConditionView ()

@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *descriptionLabel;
@property (nonatomic, strong) UILabel *highTemperatureLabel;
@property (nonatomic, strong) UILabel *lowTemperatureLabel;

@end

@implementation DailyConditionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initTimeLabel];
        [self initIconImageView];
        [self initDescriptionLabel];
        [self initHighTemperatureLabel];
        [self initLowTemperatureLabel];
    }
    return self;
}

- (void)initTimeLabel
{
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(6, 0, 80, 24)];
    self.timeLabel.textColor = [UIColor whiteColor];
    self.timeLabel.center = CGPointMake(self.timeLabel.center.x, self.bounds.size.height / 2);
    self.timeLabel.backgroundColor = RandomColor;
    self.timeLabel.text = @"12月7日";
    self.timeLabel.font = [UIFont fontWithName:LIGHT_FONT size:14.0];
    [self addSubview:self.timeLabel];
}

- (void)initIconImageView
{
    self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width * 0.4, 0, 26, 26)];
    self.iconImageView.center = CGPointMake(self.iconImageView.center.x, self.timeLabel.center.y);
    self.iconImageView.image = [UIImage imageNamed:@"weather_code_day_5"];
    [self addSubview:self.iconImageView];
}

- (void)initDescriptionLabel
{
    self.descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width * 0.50, 0, 60, 24)];
    self.descriptionLabel.textColor = [UIColor whiteColor];
    self.descriptionLabel.center = CGPointMake(self.descriptionLabel.center.x, self.bounds.size.height / 2);
    self.descriptionLabel.backgroundColor = RandomColor;
    self.descriptionLabel.text = @"多云";
    self.descriptionLabel.font = [UIFont fontWithName:LIGHT_FONT size:14.0];
    [self addSubview:self.descriptionLabel];
}

- (void)initHighTemperatureLabel
{
    self.highTemperatureLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width * 0.8, 0, 26, 24)];
    self.highTemperatureLabel.textColor = [UIColor whiteColor];
    self.highTemperatureLabel.center = CGPointMake(self.highTemperatureLabel.center.x, self.bounds.size.height / 2);
    self.highTemperatureLabel.backgroundColor = RandomColor;
    self.highTemperatureLabel.text = @"20°";
    self.highTemperatureLabel.font = [UIFont fontWithName:LIGHT_FONT size:14.0];
    [self addSubview:self.highTemperatureLabel];
}

- (void)initLowTemperatureLabel
{
    self.lowTemperatureLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width * 0.88, 0, 26, 24)];
    self.lowTemperatureLabel.textColor = [UIColor colorWithRed:131/255.0 green:177/255.0 blue:224/255.0 alpha:1.0];
    self.lowTemperatureLabel.center = CGPointMake(self.lowTemperatureLabel.center.x, self.bounds.size.height / 2);
    self.lowTemperatureLabel.backgroundColor = RandomColor;
    self.lowTemperatureLabel.text = @"14°";
    self.lowTemperatureLabel.font = [UIFont fontWithName:LIGHT_FONT size:14.0];
    [self addSubview:self.lowTemperatureLabel];
}

- (void)setDailyCondition:(DailyCondition *)dailyCondition
{
    ///
}

@end
