//
//  PagingScrollView.h
//  SimpleWeather
//
//  Created by HeQingbao on 14/11/15.
//  Copyright (c) 2014年 HeQingbao. All rights reserved.
//

@interface PagingScrollView : UIScrollView

- (void)addWeatherView:(UIView *)weatherView isLaunch:(BOOL)launch;
- (void)insertWeatherView:(UIView *)weatherView atIndex:(NSUInteger)index;
- (void)removeWeatherView:(UIView *)weatherView;
- (void)scrollToIndex:(NSUInteger)index;

@end
