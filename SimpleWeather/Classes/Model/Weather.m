//
//  Weather.m
//  SimpleWeather
//
//  Created by HeQingbao on 14/11/15.
//  Copyright (c) 2014年 HeQingbao. All rights reserved.
//

#import "Weather.h"
#import "Location.h"
#import "SunPhase.h"
#import "DailyCondition.h"
#import "HourlyCondition.h"

@implementation Weather

- (instancetype)initWithDict:(NSDictionary *)dict location:(Location *)location
{
    self = [super init];
    if (self) {
        self.location = location;
        
        NSMutableArray *dailyArray = [NSMutableArray array];
        NSDictionary *dailyDict = [[dict objectForKey:@"forecast"] objectForKey:location.cityCode];
        for (NSDictionary *d in dailyDict) {
            DailyCondition *condition = [[DailyCondition alloc] initWithDict:d];
            [dailyArray addObject:condition];
        }
        self.dailyForecast = [dailyArray copy];
        
        NSMutableArray *hourlyArray = [NSMutableArray array];
        NSDictionary *hourlyDict = [[dict objectForKey:@"hourly_forecast"] objectForKey:location.cityCode];
        for (NSDictionary *d in hourlyDict) {
            HourlyCondition *condition = [[HourlyCondition alloc] initWithDict:d];
            [hourlyArray addObject:condition];
        }
        self.hourlyForecast = [hourlyArray copy];
        
        NSDictionary *sunPhaseDict = [[[dict objectForKey:@"sun_phase"] objectForKey:location.cityCode] objectForKey:@"td"];
        self.sunPhase = [[SunPhase alloc] initWithDict:sunPhaseDict];
    }
    return self;
}

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self) {
        self.dailyForecast = [decoder decodeObjectForKey:@"dailyForecast"];
        self.hourlyForecast = [decoder decodeObjectForKey:@"hourlyForecast"];
        self.location = [decoder decodeObjectForKey:@"location"];
        self.sunPhase = [decoder decodeObjectForKey:@"sunPhase"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.dailyForecast forKey:@"dailyForecast"];
    [coder encodeObject:self.hourlyForecast forKey:@"hourlyForecast"];
    [coder encodeObject:self.location forKey:@"location"];
    [coder encodeObject:self.sunPhase forKey:@"sunPhase"];
}

@end
