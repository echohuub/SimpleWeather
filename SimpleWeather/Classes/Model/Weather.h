//
//  Weather.h
//  SimpleWeather
//
//  Created by HeQingbao on 14/11/15.
//  Copyright (c) 2014年 HeQingbao. All rights reserved.
//

@class SunPhase;
@class Location;
@interface Weather : NSObject <NSCoding>

@property (nonatomic, strong) Location *location;
@property (nonatomic, strong) NSArray *dailyForecast;
@property (nonatomic, strong) NSArray *hourlyForecast;
@property (nonatomic, strong) SunPhase *sunPhase;

- (instancetype)initWithDict:(NSDictionary *)dict location:(Location *)location;

@end
