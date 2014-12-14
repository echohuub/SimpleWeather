//
//  SunPhase.m
//  SimpleWeather
//
//  Created by HeQingbao on 14/11/15.
//  Copyright (c) 2014年 HeQingbao. All rights reserved.
//

#import "SunPhase.h"

@implementation SunPhase

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.sunrise = [dict objectForKey:@"sr"];
        self.sunset = [dict objectForKey:@"ss"];
    }
    return self;
}

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self) {
        self.sunrise = [decoder decodeObjectForKey:@"sunrise"];
        self.sunset = [decoder decodeObjectForKey:@"sunset"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.sunrise forKey:@"sunrise"];
    [coder encodeObject:self.sunset forKey:@"sunset"];
}

@end
