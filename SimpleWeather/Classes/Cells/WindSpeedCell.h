//
//  WindSpeedCell.h
//  SimpleWeather
//
//  Created by HeQingbao on 14/11/19.
//  Copyright (c) 2014年 HeQingbao. All rights reserved.
//
// 风速

#import "BaseCell.h"

@class DailyCondition;
@interface WindSpeedCell : BaseCell

@property (weak, nonatomic) IBOutlet UIImageView *windmillBigView;
@property (weak, nonatomic) IBOutlet UIImageView *windmillSmallView;
@property (weak, nonatomic) IBOutlet UILabel *windDirectionLabel;
@property (weak, nonatomic) IBOutlet UILabel *windLevelLabel;
@property (weak, nonatomic) IBOutlet UILabel *windSpeedLabel;
@property (weak, nonatomic) IBOutlet UILabel *windDescriptionLabel;

@property (nonatomic, strong) DailyCondition *dailyCondition;

+ (CGFloat)height;

@end
