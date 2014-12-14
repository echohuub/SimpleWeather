//
//  AirQualityCell.m
//  SimpleWeather
//
//  Created by HeQingbao on 14/11/18.
//  Copyright (c) 2014年 HeQingbao. All rights reserved.
//

#import "AirQualityCell.h"
#import "DailyCondition.h"

#define kHeight 146

@implementation AirQualityCell

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
    self.degreeLabel.text = [NSString stringWithFormat:@"%ld", (long)dailyCondition.airQualityIndex];
    self.degreeLabel.backgroundColor = RandomColor;
    self.levelLabel.text = [self degreeLevel:dailyCondition.airQualityIndex];
    self.pointerView.center = CGPointMake(dailyCondition.airQualityIndex, self.pointerView.center.y);
}

- (NSString *)degreeLevel:(NSInteger)degree
{
    if (degree <= 50) {
        return @"优";
    } else if (degree <= 100) {
        return @"良";
    } else if (degree <= 150) {
        return @"轻度";
    } else if (degree <= 200) {
        return @"中度";
    } else if (degree <= 300) {
        return @"重度";
    } else if (degree <= 500) {
        return @"严重";
    } else {
        return @"爆表";
    }
}

@end
