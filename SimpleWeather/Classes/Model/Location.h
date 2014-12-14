//
//  Location.h
//  SimpleWeather
//
//  Created by HeQingbao on 14/11/15.
//  Copyright (c) 2014年 HeQingbao. All rights reserved.
//

@interface Location : NSObject <NSCoding>

@property (nonatomic, copy) NSString *country;
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *region;
@property (nonatomic, copy) NSString *timeZone;
@property (nonatomic, copy) NSString *cityCode;
@property (nonatomic, copy) NSString *locale;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end