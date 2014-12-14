//
//  DetailCell.h
//  SimpleWeather
//
//  Created by HeQingbao on 14/11/17.
//  Copyright (c) 2014年 HeQingbao. All rights reserved.
//
// 天气详情

#import "BaseCell.h"

@class DailyCondition;
@interface DetailCell : BaseCell

// 室外温度
@property (weak, nonatomic) IBOutlet UILabel *outdoorTemperatureDes;
@property (weak, nonatomic) IBOutlet UILabel *outdoorTemerature;

// 湿度
@property (weak, nonatomic) IBOutlet UILabel *humidityDes;
@property (weak, nonatomic) IBOutlet UILabel *humidity;

// 能见度
@property (weak, nonatomic) IBOutlet UILabel *visibilityDes;
@property (weak, nonatomic) IBOutlet UILabel *visibility;

// 紫外线指数
@property (weak, nonatomic) IBOutlet UILabel *uvIndexDes;
@property (weak, nonatomic) IBOutlet UILabel *uvIndex;


@property (nonatomic, strong) DailyCondition *dailyCondition;

+ (CGFloat)height;

@end
