//
//  BaseCondition.m
//  SimpleWeather
//
//  Created by HeQingbao on 14/11/22.
//  Copyright (c) 2014年 HeQingbao. All rights reserved.
//

#import "BaseCondition.h"

@implementation BaseCondition

- (instancetype)initWithWeatherCode:(NSInteger)code
{
    self = [super init];
    if (self) {
        if (code >= 1 && code <= 8) {
            self.iconIndex = 2;
            self.des = @"大雨";
        } else if (code >= 9 && code <= 10) {
            self.iconIndex = 1;
            self.des = @"中雨";
        } else if (code >= 11 && code <= 12) {
            self.iconIndex = 0;
            self.des = @"小雨";
        } else if (code >= 13 && code <= 15) {
            self.iconIndex = 1;
            self.des = @"中雨";
        } else if (code >= 16 && code <= 23) {
            self.iconIndex = 3;
            self.des = @"雷雨";
        } else if (code >= 24 && code <= 27) {
            self.iconIndex = 4;
            self.des = @"晴天";
        } else if (code >= 28 && code <= 30) {
            self.iconIndex = 5;
            self.des = @"多云";
        } else if (code >= 31 && code <= 32) { //
            self.iconIndex = 6;
            self.des = @"阴天";
        } else if (code >= 33 && code <= 35) {
            self.iconIndex = 7;
            self.des = @"有雾";
        } else if (code >= 36 && code <= 38) {
            self.iconIndex = 8;
            self.des = @"沙尘";
        } else if (code >= 40 && code <= 58) {
            self.iconIndex = 9;
            self.des = @"下雪";
        } else if (code >= 59 && code <= 61) {
            self.iconIndex = 10;
            self.des = @"飓风";
        } else if (code >= 62 && code <= 69) {
            self.iconIndex = 11;
            self.des = @"冻雨";
        } else if (code >= 70 && code <= 71) {
            self.iconIndex = 12;
            self.des = @"冰雹";
        }
    }
    return self;
}

#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeInteger:self.iconIndex forKey:@"iconIndex"];
    [coder encodeObject:self.des forKey:@"des"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self) {
        self.iconIndex = [decoder decodeIntegerForKey:@"iconIndex"];
        self.des = [decoder decodeObjectForKey:@"des"];
    }
    return self;
}

@end
