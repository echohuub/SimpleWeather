//
//  PollutionDegreeView.m
//  SimpleWeather
//
//  Created by HeQingbao on 14/11/22.
//  Copyright (c) 2014年 HeQingbao. All rights reserved.
//

#import "PollutionDegreeView.h"

#define kSizeWidth  112
#define kSizeHeight 32

@interface PollutionDegreeView ()

@property (nonatomic, strong) UILabel *pmLabel;
@property (nonatomic, strong) UIImageView *expressionView;

@end

@implementation PollutionDegreeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.image = [UIImage imageNamed:@"Warning_blue"];
        
        [self initPMView];
        [self initExpressionView];
    }
    return self;
}

- (void)initPMView
{
    self.pmLabel = [[UILabel alloc] initWithFrame:CGRectMake(4, 0, 74, 32)];
    self.pmLabel.backgroundColor = [UIColor clearColor];
    self.pmLabel.textColor = [UIColor whiteColor];
    self.pmLabel.textAlignment = NSTextAlignmentCenter;
    self.pmLabel.adjustsFontSizeToFitWidth = YES;
    self.pmLabel.font = [UIFont fontWithName:LIGHT_FONT size:16];
    self.pmLabel.text = @"PM2.5: 41";
    [self addSubview:self.pmLabel];
}

- (void)initExpressionView
{
    self.expressionView = [[UIImageView alloc] initWithFrame:CGRectMake(82, 0, 28, 29)];
    self.expressionView.backgroundColor = [UIColor clearColor];
    self.expressionView.center = CGPointMake(self.expressionView.center.x, CGRectGetMidY(self.bounds));
    self.expressionView.image = [UIImage imageNamed:@"PollutionDegree_Excellent"];
    [self addSubview:self.expressionView];
}

- (void)setFrame:(CGRect)frame
{
    frame.size.width = kSizeWidth;
    frame.size.height = kSizeHeight;
    [super setFrame:frame];
}

- (void)setDegree:(NSInteger)degree
{
    _degree = degree;
    
    NSString *imageName;
    NSString *expressionImageName;
    if (degree >= 0 && degree <= 50) { // 优
        imageName = @"Warning_blue";
        expressionImageName = @"PollutionDegree_Excellent";
    } else if (degree > 50 && degree <= 100) { // 良
        imageName = @"Warning_gray";
        expressionImageName = @"PollutionDegree_Excellent";
    } else if (degree > 100 && degree <= 150) { // 轻度污染
        imageName = @"Warning_yellow";
        expressionImageName = @"PollutionDegree_Mild";
    } else if (degree > 150 && degree <= 200) { // 中度污染
        imageName = @"Warning_yellow";
        expressionImageName = @"PollutionDegree_Moderate";
    } else if (degree > 200 && degree <= 300) { //重度污染
        imageName = @"Warning_red";
        expressionImageName = @"PollutionDegree_Severe";
    } else { // 严重污染
        imageName = @"Warning_red";
        expressionImageName = @"PollutionDegree_Severe";
    }
    
    self.image = [UIImage imageNamed:imageName];
    self.expressionView.image = [UIImage imageNamed:expressionImageName];
    self.pmLabel.text = [NSString stringWithFormat:@"PM2.5: %d", degree];
}

+ (CGSize)size
{
    return CGSizeMake(kSizeWidth, kSizeHeight);
}

@end
