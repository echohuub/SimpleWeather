//
//  WindSpeedCell.m
//  SimpleWeather
//
//  Created by HeQingbao on 14/11/19.
//  Copyright (c) 2014年 HeQingbao. All rights reserved.
//

#import "WindSpeedCell.h"
#import "DailyCondition.h"

#define kHeight 168

@implementation WindSpeedCell

+ (CGFloat)height
{
    return kHeight + kCellMargin;
}

- (void)setFrame:(CGRect)frame
{
    frame.size.height = kHeight;
    [super setFrame:frame];
}

- (void)setDailyCondition:(DailyCondition *)dailyCondition
{
    _dailyCondition = dailyCondition;
//    self.windDirectionLabel.text = [NSString stringWithFormat:@"%ld", dailyCondition.windDirection];
    self.windLevelLabel.text = [NSString stringWithFormat:@"%ld级", (long)dailyCondition.windSpeed];
    self.windSpeedLabel.text = [NSString stringWithFormat:@"%@米/秒", dailyCondition.windVelocity];
    self.windDescriptionLabel.text = [self windSpeedLevel:dailyCondition.windSpeed];
    
    CABasicAnimation *animation = (CABasicAnimation *)[self.windmillBigView.layer animationForKey:@"rotationAnimation"];
    if (animation == nil) {
        CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI * 2.0];
        rotationAnimation.duration = 3;
        rotationAnimation.repeatCount = HUGE_VAL;
        [self.windmillBigView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
        
        [self.windmillSmallView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    }
}

- (NSString *)windSpeedLevel:(NSInteger)windSpeed
{
    NSString *msg;
    switch (windSpeed) {
        case 0:
            msg = @"零级无风炊烟上";
            break;
        case 1:
            msg = @"一级软风烟稍斜";
            break;
        case 2:
            msg = @"二级轻风树叶响";
            break;
        case 3:
            msg = @"三级微风树枝晃";
            break;
        case 4:
            msg = @"四级和风灰尘起";
            break;
        case 5:
            msg = @"五级清风水起波";
            break;
        case 6:
            msg = @"六级强风大树摇";
            break;
        case 7:
            msg = @"七级疾风步难行";
            break;
        case 8:
            msg = @"八级大风树枝折";
            break;
        case 9:
            msg = @"九级烈风烟囱毁";
            break;
        case 10:
            msg = @"十级狂风树根拔";
            break;
        case 11:
            msg = @"十一级暴风陆罕见";
            break;
        case 12:
            msg = @"十二级飓风浪滔天";
        default:
            msg = @"世界末日";
            break;
    }
    return msg;
}

@end
