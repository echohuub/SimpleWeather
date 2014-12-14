//
//  SettingsViewController.h
//  SimpleWeather
//
//  Created by HeQingbao on 14/6/23.
//  Copyright (c) 2014年 HeQingbao. All rights reserved.
//

#import "WeatherStateManager.h"

@protocol SettingsViewControllerDelegate <NSObject>

@required
- (void)settingsViewController:(UIViewController *)controller didChangeTemperatureScale:(TemperatureScale)scale;
- (void)settingsViewController:(UIViewController *)controller didRemoveWeatherViewWithTag:(NSInteger)tag;
- (void)settingsViewController:(UIViewController *)controller didMoveWeatherViewAtIndex:(NSUInteger)sourceIndex toIndex:(NSUInteger)destinationIndex;

@end

@interface SettingsViewController : UIViewController

@property (nonatomic, strong) NSMutableArray *locations;

@property (nonatomic, assign) id<SettingsViewControllerDelegate> delegate;

@end
