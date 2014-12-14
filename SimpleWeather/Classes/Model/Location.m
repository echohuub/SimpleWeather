//
//  Location.m
//  SimpleWeather
//
//  Created by HeQingbao on 14/11/15.
//  Copyright (c) 2014年 HeQingbao. All rights reserved.
//

#import "Location.h"

@implementation Location

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.country = [dict objectForKey:@"g"];
        self.province = [dict objectForKey:@"s"];
        self.city = [dict objectForKey:@"c"];
        self.region = [dict objectForKey:@"x"];
        self.timeZone = [dict objectForKey:@"tz"];
        self.cityCode = [dict objectForKey:@"cc"];
        self.locale = [dict objectForKey:@"locale"];
    }
    return self;
}

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self) {
        self.country = [decoder decodeObjectForKey:@"country"];
        self.province = [decoder decodeObjectForKey:@"province"];
        self.city = [decoder decodeObjectForKey:@"city"];
        self.region = [decoder decodeObjectForKey:@"region"];
        self.timeZone = [decoder decodeObjectForKey:@"timeZone"];
        self.cityCode = [decoder decodeObjectForKey:@"cityCode"];
        self.locale = [decoder decodeObjectForKey:@"locale"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.country forKey:@"country"];
    [coder encodeObject:self.province forKey:@"province"];
    [coder encodeObject:self.city forKey:@"city"];
    [coder encodeObject:self.region forKey:@"region"];
    [coder encodeObject:self.timeZone forKey:@"timeZone"];
    [coder encodeObject:self.cityCode forKey:@"cityCode"];
    [coder encodeObject:self.locale forKey:@"locale"];
}

@end
