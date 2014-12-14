//
//  ForecastCell.h
//  SimpleWeather
//
//  Created by HeQingbao on 14/11/19.
//  Copyright (c) 2014年 HeQingbao. All rights reserved.
//
// 36小时天气预报

#import "BaseCell.h"

@class Weather;
@interface ForecastCell : BaseCell

@property (nonatomic, strong) Weather *weather;

+ (CGFloat)height;

@end
