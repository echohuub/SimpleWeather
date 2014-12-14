//
//  WeatherDownloader.m
//  SimpleWeather
//
//  Created by HeQingbao on 14/11/15.
//  Copyright (c) 2014年 HeQingbao. All rights reserved.
//

#import "WeatherDownloader.h"
#import "Location.h"
#import "Weather.h"

@implementation WeatherDownloader

+ (WeatherDownloader *)sharedDownloader
{
    static WeatherDownloader *downloader;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (downloader == nil) {
            downloader = [[WeatherDownloader alloc] init];
        }
    });
    return downloader;
}

- (void)dataForLocation:(Location *)location completion:(WeatherDownloaderCompletion)completion
{
    if (location == nil || completion == nil) {
        return;
    }
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[self urlForLocation:location]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError) {
            completion(nil, connectionError);
        } else {
            @try {
                NSDictionary *dict = [self serializedData:data];
                Weather *weather = [[Weather alloc] initWithDict:dict location:location];
                completion(weather, nil);
            }
            @catch (NSException *exception) {
                completion(nil, [NSError errorWithDomain:@"WeatherDownloader Internal State Error" code:-1 userInfo:nil]);
            }
            @finally {
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            }
        }
    }];
}

// http://weather.ios.ijinshan.com/api/forecasts?cc=w-101280601&locale=zh_cn&tz=Asia/Shanghai&f=ksWeather&ver=1.5.17163.142&os=7.1.2&jb=0
- (NSURL *)urlForLocation:(Location *)location
{
    NSString *urlStr = [NSString stringWithFormat:@"http://weather.ios.ijinshan.com/api/forecasts?cc=%@&locale=%@&tz=%@&f=ksWeather&ver=1.5.17163.142&os=7.1.2&jb=0", location.cityCode, location.locale, location.timeZone];
    NSURL *url = [NSURL URLWithString:urlStr];
    return url;
}

- (NSDictionary *)serializedData:(NSData *)data
{
    NSError *serializationError;
    NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&serializationError];
    if (serializationError) {
        [NSException raise:@"JSON Serialization Error" format:@"Failed to parse weather data"];
    }
    return JSON;
}

@end
