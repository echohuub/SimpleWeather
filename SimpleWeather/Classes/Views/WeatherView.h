//
//  WeatherView.h
//  SimpleWeather
//
//  Created by HeQingbao on 14/11/15.
//  Copyright (c) 2014年 HeQingbao. All rights reserved.
//

@class Weather;
@interface WeatherView : UIView

@property (nonatomic, strong) Weather *weather;

- (void)showLoading;
- (void)hideLoading;

@end
