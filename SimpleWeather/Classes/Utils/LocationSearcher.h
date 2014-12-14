//
//  LocationSearcher.h
//  SimpleWeather
//
//  Created by HeQingbao on 14/11/15.
//  Copyright (c) 2014年 HeQingbao. All rights reserved.
//

typedef void(^SearchCompletion)(NSArray *locations, NSError *error);

@interface LocationSearcher : NSObject

+ (LocationSearcher *)sharedLocationSearcher;

- (void)locationForString:(NSString *)search completion:(SearchCompletion)completion;

@end
