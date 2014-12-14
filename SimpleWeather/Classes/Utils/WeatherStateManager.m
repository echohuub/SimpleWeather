//
//  WeatherStateManager.m
//  SimpleWeather
//
//  Created by HeQingbao on 14/11/15.
//  Copyright (c) 2014年 HeQingbao. All rights reserved.
//

#import "WeatherStateManager.h"

@implementation WeatherStateManager

#pragma mark - Weather Tags
+ (NSArray *)weatherTags
{
    NSData *encodedWeatherTags = [[NSUserDefaults standardUserDefaults] objectForKey:@"weather_tags"];
    if (encodedWeatherTags) {
        return (NSArray *)[NSKeyedUnarchiver unarchiveObjectWithData:encodedWeatherTags];
    }
    return nil;
}

+ (void)setWeatherTags:(NSArray *)tags
{
    NSData *encodedWeatherTags = [NSKeyedArchiver archivedDataWithRootObject:tags];
    [[NSUserDefaults standardUserDefaults] setObject:encodedWeatherTags forKey:@"weather_tags"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - Weather Data
+ (NSDictionary *)weatherData
{
    NSData *encodedWeatherData = [[NSUserDefaults standardUserDefaults] objectForKey:@"weather_data"];
    if (encodedWeatherData) {
        return (NSDictionary *)[NSKeyedUnarchiver unarchiveObjectWithData:encodedWeatherData];
    }
    return nil;
}

+ (void)setWeatherData:(NSDictionary *)weatherData
{
    NSData *encodedWeatherData = [NSKeyedArchiver archivedDataWithRootObject:weatherData];
    [[NSUserDefaults standardUserDefaults] setObject:encodedWeatherData forKey:@"weather_data"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - Temperature Scale
+ (TemperatureScale)temperatureScale
{
    return (TemperatureScale)[[NSUserDefaults standardUserDefaults] integerForKey:@"temp_scale"];
}

+ (void)setTemperatureScale:(TemperatureScale)scale
{
    [[NSUserDefaults standardUserDefaults] setInteger:scale forKey:@"temp_scale"];
}

@end
