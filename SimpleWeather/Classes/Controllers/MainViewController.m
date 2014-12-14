//
//  MainViewController.m
//  SimpleWeather
//
//  Created by HeQingbao on 14/6/23.
//  Copyright (c) 2014年 HeQingbao. All rights reserved.
//

#import "MainViewController.h"
#import "SettingsViewController.h"
#import "AddLocationViewController.h"
#import "PagingScrollView.h"
#import "PagingNavigationTitleView.h"
#import "WeatherView.h"
#import "Location.h"
#import "Weather.h"
#import "WeatherDownloader.h"
#import "UIImage+ImageEffects.h"

#define kLOCAL_WEATHER_VIEW_TAG         0
#define kDEFAULT_BACKGROUND_GRADIENT    @"gradient5"

@interface MainViewController () <SettingsViewControllerDelegate, AddLocationViewControllerDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) UINavigationBar *navigationBar;
@property (nonatomic, strong) PagingNavigationTitleView *pagingTitleView;
@property (nonatomic, strong) PagingScrollView *pagingScrollView;

@property (nonatomic, strong) NSMutableArray *weatherTags;
@property (nonatomic, strong) NSMutableDictionary *weatherData;

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSArray *cachedWeatherTags = [WeatherStateManager weatherTags];
        if (cachedWeatherTags) {
            self.weatherTags = [NSMutableArray arrayWithArray:cachedWeatherTags];
        } else {
            self.weatherTags = [NSMutableArray array];
        }
        
        NSDictionary *cachedWeatherData = [WeatherStateManager weatherData];
        if (cachedWeatherData) {
            self.weatherData = [NSMutableDictionary dictionaryWithDictionary:cachedWeatherData];
        } else {
            self.weatherData = [NSMutableDictionary dictionary];
        }
        
        [self initNavigationBar];
        [self initPagingScrollView];
        
        // test
        [self initNonLocalWeatherViews];
        
        [self.view bringSubviewToFront:self.navigationBar];
    }
    return self;
}

// 初始化UINavigationBar
- (void)initNavigationBar
{
    self.navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 64)];
    self.navigationBar.translucent = YES;
    [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:20]}];
    self.navigationBar.tintColor = [UIColor whiteColor];
    
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0, self.navigationBar.bounds.size.height, self.navigationBar.bounds.size.width, 0.5);
    bottomBorder.backgroundColor = [UIColor lightGrayColor].CGColor;
    [self.navigationBar.layer addSublayer:bottomBorder];
    
    // Settings Button
    UIButton *settingsButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 26, 26)];
    [settingsButton setBackgroundImage:[UIImage imageNamed:@"weather_set"] forState:UIControlStateNormal];
    [settingsButton addTarget:self action:@selector(settingsButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    // Add Location Button
    UIButton *addLocationButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 26, 26)];
    [addLocationButton setBackgroundImage:[UIImage imageNamed:@"weather_add"] forState:UIControlStateNormal];
    [addLocationButton addTarget:self action:@selector(addLocationButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    UINavigationItem *navigationItem = [[UINavigationItem alloc] init];
    navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:settingsButton];
    navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:addLocationButton];
    
    // 可滚动的titleView
    self.pagingTitleView = [[PagingNavigationTitleView alloc] initWithFrame:CGRectMake(0, 0, 0.5 * CGRectGetWidth(self.view.bounds), 44)];
    navigationItem.titleView = self.pagingTitleView;
    
    self.navigationBar.items = @[navigationItem];
    [self.view addSubview:self.navigationBar];
}

- (void)initPagingScrollView
{
    self.pagingScrollView = [[PagingScrollView alloc] init];
    self.pagingScrollView.frame = (CGRect){{0, 0}, self.view.bounds.size};
    self.pagingScrollView.delegate = self;
    [self.view addSubview:self.pagingScrollView];
}

- (void)initNonLocalWeatherViews
{
    NSMutableArray *titles = [NSMutableArray array];
    for (NSNumber *tag in self.weatherTags) {
        Weather *weather = [self.weatherData objectForKey:tag];
        if (weather) {
            WeatherView *weatherView = [[WeatherView alloc] init];
            weatherView.tag = tag.integerValue;
            [self.pagingScrollView addWeatherView:weatherView isLaunch:YES];
            weatherView.weather = weather;
            
            [titles addObject:weather.location.region];
        }
    }
    
    if (titles.count > 0) {
        [self.pagingTitleView addTitles:titles];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"gradient0"]];
}

#pragma mark - 设置
- (void)settingsButtonPressed
{
    NSMutableArray *locations = [NSMutableArray array];
    [self.pagingScrollView.subviews enumerateObjectsUsingBlock:^(WeatherView *weatherView, NSUInteger idx, BOOL *stop) {
        if (weatherView.tag != kLOCAL_WEATHER_VIEW_TAG) {
#warning 如果天气数据还没加成成功，weather可能为null
            NSArray *locationMetaData = @[weatherView.weather.location.region, @(weatherView.tag)];
            [locations addObject:locationMetaData];
        }
    }];
    
    SettingsViewController *settingsViewController = [[SettingsViewController alloc] init];
    settingsViewController.locations = locations;
    settingsViewController.delegate = self;
    [self presentViewController:settingsViewController animated:YES completion:nil];
}

#pragma mark - SettingsViewControllerDelegate
- (void)settingsViewController:(UIViewController *)controller didChangeTemperatureScale:(TemperatureScale)scale
{
    //
}

- (void)settingsViewController:(UIViewController *)controller didRemoveWeatherViewWithTag:(NSInteger)tag
{
    [self.pagingScrollView.subviews enumerateObjectsUsingBlock:^(WeatherView *weatherView, NSUInteger idx, BOOL *stop) {
        if (weatherView.tag == tag) {
            [self.pagingTitleView removeTitle:weatherView.weather.location.region];
            [self.pagingScrollView removeWeatherView:weatherView];
            *stop = YES;
        }
    }];
    
    [self.weatherData removeObjectForKey:@(tag)];
    [self.weatherTags removeObject:@(tag)];
    
    [WeatherStateManager setWeatherData:self.weatherData];
    [WeatherStateManager setWeatherTags:self.weatherTags];
}

- (void)settingsViewController:(UIViewController *)controller didMoveWeatherViewAtIndex:(NSUInteger)sourceIndex toIndex:(NSUInteger)destinationIndex
{
    // 改变WeatherTag里面的顺序
    NSNumber *weatherTag = [self.weatherTags objectAtIndex:sourceIndex];
    [self.weatherTags removeObjectAtIndex:sourceIndex];
    [self.weatherTags insertObject:weatherTag atIndex:destinationIndex];
    
    // Save Data
    [WeatherStateManager setWeatherTags:self.weatherTags];
    
    if ([self.weatherData objectForKey:@(kLOCAL_WEATHER_VIEW_TAG)]) {
        destinationIndex += 1;
    }
    
    [self.pagingScrollView.subviews enumerateObjectsUsingBlock:^(WeatherView *weatherView, NSUInteger idx, BOOL *stop) {
        if (weatherView.tag == weatherTag.integerValue) {
            [self.pagingScrollView removeWeatherView:weatherView];
            [self.pagingScrollView insertWeatherView:weatherView atIndex:destinationIndex];
            
            [self.pagingTitleView moveTitleFromIndex:sourceIndex toIndex:destinationIndex];
            *stop = YES;
        }
    }];
}

#pragma mark - 添加位置
- (void)addLocationButtonPressed
{
    AddLocationViewController *addLocationViewController = [[AddLocationViewController alloc] init];
    addLocationViewController.delegate = self;
    [self presentViewController:addLocationViewController animated:YES completion:nil];
}

#pragma mark - AddLocationViewControllerDelegate
- (void)addLocationViewController:(AddLocationViewController *)controller didAddLocation:(Location *)location
{
    NSUInteger tag = location.region.hash;
    Weather *weather = [self.weatherData objectForKey:@(tag)];
    if (weather) {
        NSUInteger index = [self.weatherTags indexOfObject:@(tag)];
        [self.pagingScrollView scrollToIndex:index];
        return;
    }
    
    WeatherView *weatherView = [[WeatherView alloc] init];
    weatherView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:kDEFAULT_BACKGROUND_GRADIENT]];
    weatherView.tag = tag;
    
    [self.pagingTitleView addTitle:location.region];
    [self.pagingScrollView addWeatherView:weatherView isLaunch:false];
    
    [self.weatherTags addObject:@(tag)];
    [WeatherStateManager setWeatherTags:self.weatherTags];
    
    [weatherView showLoading];
    
    [[WeatherDownloader sharedDownloader] dataForLocation:location completion:^(Weather *weather, NSError *error) {
        if (weather) {
            // Success
            [self downloadDidFinishWithData:weather withTag:weatherView.tag];
        } else {
            // Failure
            [self downloadDidFailForTag:weatherView.tag];
        }
    }];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.pagingTitleView.contentOffset = scrollView.contentOffset;
    
    float fractionalPage = scrollView.contentOffset.x / scrollView.frame.size.width;
    self.pagingTitleView.currentPage = lroundf(fractionalPage);
}

- (void)downloadDidFinishWithData:(Weather *)weather withTag:(NSInteger)tag
{
    [self.pagingScrollView.subviews enumerateObjectsUsingBlock:^(WeatherView *weatherView, NSUInteger idx, BOOL *stop) {
        if (weatherView.tag == tag) {
            [self.weatherData setObject:weather forKey:@(tag)];
            
            weatherView.weather = weather;
            [weatherView hideLoading];
            *stop = YES;
        }
    }];
    
    [WeatherStateManager setWeatherData:self.weatherData];
}

- (void)downloadDidFailForTag:(NSInteger)tag
{
    [self.pagingScrollView.subviews enumerateObjectsUsingBlock:^(WeatherView *weatherView, NSUInteger idx, BOOL *stop) {
        if (weatherView.tag == tag) {
            // TODO 区分当前是否已有数据
            [weatherView hideLoading];
        }
    }];
}

@end
