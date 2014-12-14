//
//  WeatherStateManager.h
//  SimpleWeather
//
//  Created by HeQingbao on 14/11/15.
//  Copyright (c) 2014年 HeQingbao. All rights reserved.
//

typedef enum {
    CelsiusScale = 0,
    FahrenheitScale
} TemperatureScale;

@interface WeatherStateManager : NSObject

+ (NSArray *)weatherTags;
+ (void)setWeatherTags:(NSArray *)tags;

+ (NSDictionary *)weatherData;
+ (void)setWeatherData:(NSDictionary *)weatherData;

+ (TemperatureScale)temperatureScale;
+ (void)setTemperatureScale:(TemperatureScale)scale;

@end
