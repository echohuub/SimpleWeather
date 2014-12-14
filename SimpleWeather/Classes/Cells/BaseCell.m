//
//  BaseCell.m
//  SimpleWeather
//
//  Created by HeQingbao on 14/11/20.
//  Copyright (c) 2014年 HeQingbao. All rights reserved.
//

#import "BaseCell.h"

#define kCellWidth  ([UIScreen mainScreen].bounds.size.width - kCellMargin * 2)

@implementation BaseCell

- (void)awakeFromNib
{
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.x = kCellMargin;
    frame.size.width = kCellWidth;
    [super setFrame:frame];
}

@end
