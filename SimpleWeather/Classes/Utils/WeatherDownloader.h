//
//  WeatherDownloader.h
//  SimpleWeather
//
//  Created by HeQingbao on 14/11/15.
//  Copyright (c) 2014年 HeQingbao. All rights reserved.
//

@class Weather;
typedef void(^WeatherDownloaderCompletion)(Weather *weather, NSError *error);

@class Location;
@interface WeatherDownloader : NSObject

+ (WeatherDownloader *)sharedDownloader;

- (void)dataForLocation:(Location *)location completion:(WeatherDownloaderCompletion)completion;

@end
