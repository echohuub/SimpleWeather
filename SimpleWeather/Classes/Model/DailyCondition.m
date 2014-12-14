//
//  DailyCondition.m
//  SimpleWeather
//
//  Created by HeQingbao on 14/11/15.
//  Copyright (c) 2014年 HeQingbao. All rights reserved.
//

#import "DailyCondition.h"

@implementation DailyCondition

- (instancetype)initWithDict:(NSDictionary *)dict
{
    NSInteger weatherCode = [[[dict objectForKey:@"wc"] firstObject] integerValue];
    self = [super initWithWeatherCode:weatherCode];
    if (self) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd";
        self.date = [formatter dateFromString:[dict objectForKey:@"date"]];
        
        self.timeZone = [dict objectForKey:@"tz"];
        
        self.airQualityIndex = [[dict objectForKey:@"aqi"] integerValue];
        
        self.windDirection = [[[dict objectForKey:@"wd"] firstObject] integerValue];
        self.windSpeed = [[[dict objectForKey:@"ws"] firstObject] integerValue];
        self.windVelocity = [[dict objectForKey:@"mph"] firstObject];
        
        NSInteger currentTemperatureC = [[dict objectForKey:@"tn"] integerValue];
        NSInteger currentTemperatureF = [[dict objectForKey:@"tn_f"] integerValue];
        self.currentTemperature = temperatureMake(currentTemperatureC, currentTemperatureF);
        
        NSInteger highTemperatureC = [[dict objectForKey:@"th"] integerValue];
        NSInteger highTemperatureF = [[dict objectForKey:@"th_f"] integerValue];
        self.highTemperature = temperatureMake(highTemperatureC, highTemperatureF);
        
        NSInteger lowTemperatureC = [[dict objectForKey:@"tl"] integerValue];
        NSInteger lowTemperatureF = [[dict objectForKey:@"tl_f"] integerValue];
        self.lowTemperature = temperatureMake(lowTemperatureC, lowTemperatureF);
        
        NSInteger outdoorTemperatureC = [[dict objectForKey:@"fl"] integerValue];
        NSInteger outdoorTemperatureF = [[dict objectForKey:@"fl_f"] integerValue];
        self.outdoorTemperature = temperatureMake(outdoorTemperatureC, outdoorTemperatureF);
        
        self.relativeHumidity = [[dict objectForKey:@"rh"] integerValue];
        self.visibility = [[dict objectForKey:@"v_km"] integerValue];
        self.uvIndex = [[dict objectForKey:@"pt"] integerValue];
        
        // 发布时间
        NSTimeInterval interval = [[dict objectForKey:@"up"] doubleValue];
        self.postTime = [NSDate dateWithTimeIntervalSince1970:interval];
    }
    return self;
}

#pragma mark - NSCoding
- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super initWithCoder:decoder];
    if (self) {
        self.date = [decoder decodeObjectForKey:@"date"];
        self.timeZone = [decoder decodeObjectForKey:@"timeZone"];
        self.airQualityIndex = [decoder decodeIntegerForKey:@"airQualityIndex"];
        self.windDirection = [decoder decodeIntegerForKey:@"windDirection"];
        self.windSpeed = [decoder decodeIntegerForKey:@"windSpeed"];
        self.windVelocity = [decoder decodeObjectForKey:@"windVelocity"];
        self.currentTemperature = temperatureMake([decoder decodeIntForKey:@"current_temp_c"], [decoder decodeIntForKey:@"current_temp_f"]);
        self.highTemperature = temperatureMake([decoder decodeIntForKey:@"high_temp_c"], [decoder decodeIntForKey:@"high_temp_f"]);
        self.lowTemperature = temperatureMake([decoder decodeIntForKey:@"low_temp_c"], [decoder decodeIntForKey:@"low_temp_f"]);
        self.outdoorTemperature = temperatureMake([decoder decodeIntForKey:@"outdoor_temp_c"], [decoder decodeIntForKey:@"ourdoor_temp_f"]);
        self.relativeHumidity = [decoder decodeIntegerForKey:@"relativeHumidity"];
        self.visibility = [decoder decodeIntegerForKey:@"visibility"];
        self.uvIndex = [decoder decodeIntegerForKey:@"uvIndex"];
        self.postTime = [decoder decodeObjectForKey:@"postTime"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [super encodeWithCoder:coder];
    
    [coder encodeObject:self.date forKey:@"date"];
    [coder encodeObject:self.timeZone forKey:@"timeZone"];
    [coder encodeInteger:self.airQualityIndex forKey:@"airQualityIndex"];
    [coder encodeInteger:self.windDirection forKey:@"windDirection"];
    [coder encodeInteger:self.windSpeed forKey:@"windSpeed"];
    [coder encodeObject:self.windVelocity forKey:@"windVelocity"];
    
    [coder encodeInt:self.currentTemperature.celsius forKey:@"current_temp_c"];
    [coder encodeInt:self.currentTemperature.fahrenheit forKey:@"current_temp_f"];
    
    [coder encodeInt:self.highTemperature.celsius forKey:@"high_temp_c"];
    [coder encodeInt:self.highTemperature.fahrenheit forKey:@"high_temp_f"];
    
    [coder encodeInt:self.lowTemperature.celsius forKey:@"low_temp_c"];
    [coder encodeInt:self.lowTemperature.fahrenheit forKey:@"low_temp_f"];
    
    [coder encodeInt:self.outdoorTemperature.celsius forKey:@"outdoor_temp_c"];
    [coder encodeInt:self.outdoorTemperature.fahrenheit forKey:@"ourdoor_temp_f"];
    
    [coder encodeInteger:self.relativeHumidity forKey:@"relativeHumidity"];
    [coder encodeInteger:self.visibility forKey:@"visibility"];
    [coder encodeInteger:self.uvIndex forKey:@"uvIndex"];
    [coder encodeObject:self.postTime forKey:@"postTime"];
}

@end
