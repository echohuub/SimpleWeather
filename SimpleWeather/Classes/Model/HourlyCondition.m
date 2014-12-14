//
//  HourlyCondition.m
//  SimpleWeather
//
//  Created by HeQingbao on 14/11/15.
//  Copyright (c) 2014年 HeQingbao. All rights reserved.
//

#import "HourlyCondition.h"

@implementation HourlyCondition

- (instancetype)initWithDict:(NSDictionary *)dict
{
    NSInteger weatherCode = [[[dict objectForKey:@"wc"] firstObject] integerValue];
    self = [super initWithWeatherCode:weatherCode];
    if (self) {
        self.hour = [[dict objectForKey:@"h"] integerValue];
        
        NSInteger temperatureC = [[dict objectForKey:@"tm"] integerValue];
        NSInteger temperatureF = [[dict objectForKey:@"tm_f"] integerValue];
        self.temperature = temperatureMake(temperatureC, temperatureF);
    }
    return self;
}

#pragma mark - NSCoding
- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super initWithCoder:decoder];
    if (self) {
        self.hour = [decoder decodeIntegerForKey:@"hour"];
        self.temperature = temperatureMake([decoder decodeIntForKey:@"temp_c"], [decoder decodeIntForKey:@"temp_f"]);
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [super encodeWithCoder:coder];
    
    [coder encodeInteger:self.hour forKey:@"hour"];
    [coder encodeInt:self.temperature.celsius forKey:@"temp_c"];
    [coder encodeInt:self.temperature.fahrenheit forKey:@"temp_f"];
}

@end
