//
//  DetailCell.m
//  SimpleWeather
//
//  Created by HeQingbao on 14/11/17.
//  Copyright (c) 2014年 HeQingbao. All rights reserved.
//

#import "DetailCell.h"
#import "DailyCondition.h"

#define kHeight 210

@implementation DetailCell

+ (CGFloat)height
{
    return kHeight + kCellMargin;
}

- (void)setFrame:(CGRect)frame
{
    frame.size.height = kHeight;
    [super setFrame:frame];
}

- (void)setDailyCondition:(DailyCondition *)dailyCondition
{
    _dailyCondition = dailyCondition;
    
    // 室外温度
    self.outdoorTemerature.text = [NSString stringWithFormat:@"%d°", dailyCondition.outdoorTemperature.celsius];
    self.outdoorTemperatureDes.text = [self temperatureLevel:dailyCondition.outdoorTemperature.celsius];
    
    // 湿度
    self.humidity.text = [NSString stringWithFormat:@"%ld", (long)dailyCondition.relativeHumidity];
    self.humidityDes.text = [self humidityLevel:dailyCondition.relativeHumidity];
    
    // 能见度
    self.visibility.text = [NSString stringWithFormat:@"%ld", (long)dailyCondition.visibility];
    self.visibilityDes.text = [self visibilityLevel:dailyCondition.visibility];
    
    // 紫外线指数
    self.uvIndex.text = [NSString stringWithFormat:@"%ld", (long)dailyCondition.uvIndex];
    self.uvIndexDes.text = [self uvIndexLevel:dailyCondition.uvIndex];
}

- (NSString *)temperatureLevel:(NSInteger)celsius
{
    if (celsius <= 0) {
        return @"寒冷";
    } else if (celsius <= 10) {
        return @"微寒";
    } else if (celsius <= 15) {
        return @"温和";
    } else if (celsius <= 20) {
        return @"温暖";
    } else if (celsius <= 25) {
        return @"热";
    } else if (celsius <= 30) {
        return @"暑热";
    } else if (celsius <= 35) {
        return @"酷热";
    } else if (celsius <= 40) {
        return @"奇热";
    } else {
        return @"极热";
    }
}

- (NSString *)humidityLevel:(NSInteger)relativeHumidity
{
    if (relativeHumidity <= 40) {
        return @"干燥";
    } else if (relativeHumidity <= 60) {
        return @"适宜";
    } else {
        return @"潮湿";
    }
}

- (NSString *)visibilityLevel:(NSInteger)visibility
{
    if (visibility < 0.3) {
        return @"浓雾";
    } else if (visibility <= 1) {
        return @"大雾";
    } else if (visibility <= 10) {
        return @"轻雾";
    } else if (visibility <= 20) {
        return @"一般";
    } else if (visibility <= 25) {
        return @"好";
    } else {
        return @"极好";
    }
}

- (NSString *)uvIndexLevel:(NSInteger)uvIndex
{
    if (uvIndex <= 2) {
        return @"安全";
    } else if (uvIndex <= 4) {
        return @"弱";
    } else if (uvIndex <= 6) {
        return @"中等";
    } else if (uvIndex <= 9) {
        return @"较强";
    } else {
        return @"有害";
    }
}

@end
