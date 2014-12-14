//
//  HourlyCondition.h
//  SimpleWeather
//
//  Created by HeQingbao on 14/11/15.
//  Copyright (c) 2014年 HeQingbao. All rights reserved.
//

#import "BaseCondition.h"
#import "Temperature.h"

@interface HourlyCondition : BaseCondition

@property (nonatomic, assign) NSInteger hour;
@property (nonatomic, assign) Temperature temperature;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
