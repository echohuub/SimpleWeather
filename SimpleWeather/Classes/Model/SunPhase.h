//
//  SunPhase.h
//  SimpleWeather
//
//  Created by HeQingbao on 14/11/15.
//  Copyright (c) 2014年 HeQingbao. All rights reserved.
//

@interface SunPhase : NSObject <NSCoding>

@property (nonatomic, copy) NSString *sunrise;
@property (nonatomic, copy) NSString *sunset;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
