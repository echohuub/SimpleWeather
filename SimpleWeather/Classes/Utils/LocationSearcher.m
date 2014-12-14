//
//  LocationSearcher.m
//  SimpleWeather
//
//  Created by HeQingbao on 14/11/15.
//  Copyright (c) 2014年 HeQingbao. All rights reserved.
//

#import "LocationSearcher.h"
#import "Location.h"

@implementation LocationSearcher

+ (LocationSearcher *)sharedLocationSearcher
{
    static LocationSearcher *searcher;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (searcher == nil) {
            searcher = [[LocationSearcher alloc] init];
        }
    });
    return searcher;
}

- (void)locationForString:(NSString *)search completion:(SearchCompletion)completion
{
    if (search == nil || completion == nil) {
        return;
    }
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[self urlForSearch:search]];
    [self locationForRequest:request completion:completion];
}

- (void)locationForRequest:(NSURLRequest *)request completion:(SearchCompletion)completion
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError) {
            completion(nil, connectionError);
        } else {
            @try {
                NSDictionary *dict = [[self serializedData:data] objectForKey:@"data"];
                NSMutableArray *locations = [NSMutableArray arrayWithCapacity:dict.count];
                for (NSDictionary *d in dict) {
                    Location *location = [[Location alloc] initWithDict:d];
                    [locations addObject:location];
                }
                completion(locations, nil);
            }
            @catch (NSException *exception) {
                completion(nil, [NSError errorWithDomain:@"LocationSearcher Internal State Error" code:-1 userInfo:nil]);
            }
            @finally {
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            }
        }
    }];
}

// http://weather.ios.ijinshan.com/api/city/search?cn=%E6%88%90%E9%83%BD&locale=zh_cn&tz=Asia/Shanghai&f=ksWeather&ver=1.5.17163.142&os=7.1.2&jb=0
- (NSURL *)urlForSearch:(NSString *)search
{
    NSString *encodedSearch = [search stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *urlStr = [NSString stringWithFormat:@"http://weather.ios.ijinshan.com/api/city/search?cn=%@&locale=zh_cn&tz=Asia/Shanghai&f=ksWeather&ver=1.5.17163.142&os=7.1.2&jb=0", encodedSearch];
    return [NSURL URLWithString:urlStr];
}

- (NSDictionary *)serializedData:(NSData *)data
{
    NSError *serializationError;
    NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&serializationError];
    if (serializationError) {
        [NSException raise:@"JSON Serialization Error" format:@"Failed to parse location data"];
    }
    return JSON;
}

@end
