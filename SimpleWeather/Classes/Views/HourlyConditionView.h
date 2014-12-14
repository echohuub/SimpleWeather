//
//  HourlyConditionView.h
//  SimpleWeather
//
//  Created by 何清宝 on 14/12/6.
//  Copyright (c) 2014年 HeQingbao. All rights reserved.
//

#define kHourlyConditionViewWidth   50
#define kHourLyConditionViewHeight  80

@class HourlyCondition;
@interface HourlyConditionView : UIView

@property (nonatomic, strong) HourlyCondition *hourlyCondition;

@end
