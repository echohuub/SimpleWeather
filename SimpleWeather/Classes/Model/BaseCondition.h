//
//  BaseCondition.h
//  SimpleWeather
//
//  Created by HeQingbao on 14/11/22.
//  Copyright (c) 2014年 HeQingbao. All rights reserved.
//

@interface BaseCondition : NSObject <NSCoding>

@property (nonatomic, assign) NSInteger iconIndex;
@property (nonatomic, copy) NSString *des;

- (instancetype)initWithWeatherCode:(NSInteger)code;

@end
