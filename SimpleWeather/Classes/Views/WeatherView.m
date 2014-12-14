//
//  WeatherView.m
//  SimpleWeather
//
//  Created by HeQingbao on 14/11/15.
//  Copyright (c) 2014年 HeQingbao. All rights reserved.
//

#import "WeatherView.h"
#import "Weather.h"
#import "Location.h"
#import "ForecastCell.h"
#import "DetailCell.h"
#import "AirQualityCell.h"
#import "WindSpeedCell.h"
#import "WeatherHeaderView.h"

@interface WeatherView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) WeatherHeaderView *headerView;

@end

@implementation WeatherView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

// 在PagingScrollView里面可能会多次调用setFrame
- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
//    if (CGRectGetWidth(frame) != 0) {
//        [self initWeatherTableView];
//        [self initWeahterHeaderView];
//    }
}

- (void)initWeatherTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.bounds.size.width, self.bounds.size.height - 64)];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.allowsSelection = NO;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self addSubview:self.tableView];
}

- (void)initWeahterHeaderView
{
    self.headerView = [[WeatherHeaderView alloc] initWithFrame:self.tableView.bounds];
    self.tableView.tableHeaderView = self.headerView;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (indexPath.row == 0) { // 36小时天气预报
        static NSString *CellIdentifier = @"ForecastCell";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ForecastCell" owner:self options:nil] firstObject];
        }
        ((ForecastCell *) cell).weather = self.weather;
    } else if (indexPath.row == 1) { // 天气详情
        static NSString *CellIdentifier = @"DetailCell";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"DetailCell" owner:self options:nil] firstObject];
        }
        ((DetailCell *) cell).dailyCondition = self.weather.dailyForecast.firstObject;
    } else if (indexPath.row == 2) { // 空气污染指数
        static NSString *CellIdentifier = @"AirQualityCell";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"AirQualityCell" owner:self options:nil] firstObject];
        }
        ((AirQualityCell *) cell).dailyCondition = self.weather.dailyForecast.firstObject;
    } else if (indexPath.row == 3) { // 风速
        static NSString *CellIdentifier = @"WindSpeedCell";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"WindSpeedCell" owner:self options:nil] firstObject];
        }
        ((WindSpeedCell *) cell).dailyCondition = self.weather.dailyForecast.firstObject;
    } else {
        static NSString *CellIdentifier = @"Cell";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.backgroundColor = [UIColor clearColor];
        }
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return [ForecastCell height];
    } else if (indexPath.row == 1) {
        return [DetailCell height];
    } else if (indexPath.row == 2) {
        return [AirQualityCell height];
    } else if (indexPath.row == 3) {
        return [WindSpeedCell height];
    }
    return 44;
}

- (void)showLoading
{
    
}

- (void)hideLoading
{
    
}

- (void)setWeather:(Weather *)weather
{
    _weather = weather;
    
    if (self.tableView == nil) {
        [self initWeatherTableView];
        [self initWeahterHeaderView];
    }
    
    self.headerView.dailyCondition = weather.dailyForecast.firstObject;
    [self.tableView reloadData];
}

@end
