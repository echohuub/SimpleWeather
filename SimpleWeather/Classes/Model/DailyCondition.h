//
//  DailyCondition.h
//  SimpleWeather
//
//  Created by HeQingbao on 14/11/15.
//  Copyright (c) 2014年 HeQingbao. All rights reserved.
//

#import "BaseCondition.h"
#import "Temperature.h"

@interface DailyCondition : BaseCondition

@property (nonatomic, copy) NSDate *date;
@property (nonatomic, copy) NSString *timeZone;
@property (nonatomic, assign) NSInteger airQualityIndex; // 空气质量指数/PM2.5
@property (nonatomic, assign) NSInteger windDirection; // 风向:西南风
@property (nonatomic, assign) NSInteger windSpeed; // 风速:2级
@property (nonatomic, copy) NSString *windVelocity; // 风速:1.6~3.3米/秒
@property (nonatomic, assign) Temperature currentTemperature;
@property (nonatomic, assign) Temperature highTemperature;
@property (nonatomic, assign) Temperature lowTemperature;
@property (nonatomic, assign) Temperature outdoorTemperature; // 室外温度
@property (nonatomic, assign) NSInteger relativeHumidity; // 湿度
@property (nonatomic, assign) NSInteger visibility; // 能见度
@property (nonatomic, assign) NSInteger uvIndex; // 紫外线指数
@property (nonatomic, strong) NSDate *postTime; // 发布时间

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
