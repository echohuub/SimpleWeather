//
//  WeatherHeaderView.m
//  SimpleWeather
//
//  Created by HeQingbao on 14/11/22.
//  Copyright (c) 2014年 HeQingbao. All rights reserved.
//

#import "WeatherHeaderView.h"
#import "PollutionDegreeView.h"
#import "DailyCondition.h"

#define kMargin 10

@interface WeatherHeaderView ()

@property (nonatomic, strong) UILabel *describeLabel;
@property (nonatomic, strong) UILabel *temperatureLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) PollutionDegreeView *pollutionDegreeView;

@property (nonatomic, strong) NSDateFormatter *dayFormatter;
@property (nonatomic, strong) NSDateFormatter *timeFormatter;

@end

@implementation WeatherHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self initTimeLabel];
        [self initTemperatureLabel];
        [self initDescribeLabel];
        [self initPollutionDegreeView];
        
        self.dayFormatter = [[NSDateFormatter alloc] init];
        self.dayFormatter.dateFormat = @"MM月dd日";
        
        self.timeFormatter = [[NSDateFormatter alloc] init];
        self.timeFormatter.dateFormat = @"HH:mm";
    }
    return self;
}

- (void)initTimeLabel
{
    static const NSInteger fontSize = 14;
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.frame = CGRectMake(kMargin, self.bounds.size.height - fontSize * 2, 160, fontSize);
    self.timeLabel.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    self.timeLabel.text = @"[11月17日 21:50发布]";
    self.temperatureLabel.adjustsFontSizeToFitWidth = YES;
    self.timeLabel.textColor = [UIColor whiteColor];
    self.timeLabel.font = [UIFont fontWithName:LIGHT_FONT size:fontSize];
    [self addSubview:self.timeLabel];
}

- (void)initTemperatureLabel
{
    static const NSInteger fontSize = 100;
    self.temperatureLabel = [[UILabel alloc] init];
    self.temperatureLabel.frame = CGRectMake(kMargin, self.timeLabel.frame.origin.y - fontSize, 160, fontSize);
    self.temperatureLabel.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    self.temperatureLabel.text = @"19°";
    self.temperatureLabel.adjustsFontSizeToFitWidth = YES;
    self.temperatureLabel.textColor = [UIColor whiteColor];
    self.temperatureLabel.font = [UIFont fontWithName:ULTRALIGHT_FONT size:fontSize];
    [self addSubview:self.temperatureLabel];
}

- (void)initDescribeLabel
{
    static const NSInteger fontSize = 24;
    self.describeLabel = [[UILabel alloc] init];
    self.describeLabel.frame = CGRectMake(kMargin, self.temperatureLabel.frame.origin.y - fontSize, 160, fontSize);
    self.describeLabel.text = @"晴天";
    self.temperatureLabel.adjustsFontSizeToFitWidth = YES;
    self.describeLabel.textColor = [UIColor whiteColor];
    self.describeLabel.font = [UIFont fontWithName:LIGHT_FONT size:fontSize];
    [self addSubview:self.describeLabel];
}

- (void)initPollutionDegreeView
{
    CGSize size = [PollutionDegreeView size];
    CGFloat x = self.bounds.size.width - kMargin - size.width;
    CGFloat y = CGRectGetMaxY(self.timeLabel.frame) - size.height;
    self.pollutionDegreeView = [[PollutionDegreeView alloc] initWithFrame:CGRectMake(x, y, 0, 0)];
    [self addSubview:self.pollutionDegreeView];
}

- (void)setDailyCondition:(DailyCondition *)dailyCondition
{
    _dailyCondition = dailyCondition;
    
    self.describeLabel.text = dailyCondition.des;
    self.temperatureLabel.text = [NSString stringWithFormat:@"%d°", dailyCondition.currentTemperature.celsius];
    
    NSString *time = [NSString stringWithFormat:@"[%@ %@发布]", [self.dayFormatter stringFromDate:dailyCondition.date], [self.timeFormatter stringFromDate:dailyCondition.postTime]];
    self.timeLabel.text = time;
    
    self.pollutionDegreeView.degree = dailyCondition.airQualityIndex;
}

@end
