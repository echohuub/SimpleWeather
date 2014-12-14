//
//  AirQualityCell.h
//  SimpleWeather
//
//  Created by HeQingbao on 14/11/18.
//  Copyright (c) 2014年 HeQingbao. All rights reserved.
//
// 空气污染指数

#import "BaseCell.h"

@class DailyCondition;
@interface AirQualityCell : BaseCell

@property (weak, nonatomic) IBOutlet UILabel *degreeLabel;
@property (weak, nonatomic) IBOutlet UILabel *levelLabel;
@property (weak, nonatomic) IBOutlet UIImageView *pointerView;

@property (nonatomic, strong) DailyCondition *dailyCondition;

+ (CGFloat)height;

@end
