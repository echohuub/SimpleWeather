//
//  SettingsViewController.m
//  SimpleWeather
//
//  Created by HeQingbao on 14/6/23.
//  Copyright (c) 2014年 HeQingbao. All rights reserved.
//

#import "SettingsViewController.h"
#import "WeatherStateManager.h"

@interface SettingsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UINavigationBar *navigationBar;
@property (nonatomic, strong) UISegmentedControl *temperatureControl;
@property (nonatomic, strong) UITableView *locationsTableView;
@property (nonatomic, strong) UILabel *locationsTableViewTitleLabel;
@property (nonatomic, strong) UIView *tableSeparatorView;

@end

@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"gradient3"]];
        [self initNavigationBar];
        [self initTemperatureControl];
        [self initLocationsTableView];
        [self initLocationsTableViewTitleLabel];
        [self initCreditLabel];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.locationsTableView setEditing:YES animated:YES];
    
    CGFloat animationDuration = (self.locations.count > 0) ? 0.3 : 0.0;
    [UIView animateWithDuration:animationDuration animations:^{
        self.tableSeparatorView.alpha = (self.locations.count > 0) ? 1.0 : 0.0;
        self.locationsTableViewTitleLabel.alpha = self.tableSeparatorView.alpha;
    }];
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
    bottomBorder.frame = CGRectMake(0.0, self.navigationBar.bounds.size.height, self.navigationBar.bounds.size.width, 0.5);
    bottomBorder.backgroundColor = [UIColor lightGrayColor].CGColor;
    [self.navigationBar.layer addSublayer:bottomBorder];
    
    UINavigationItem *navigationItem = [[UINavigationItem alloc] initWithTitle:@"设置"];
    navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(doneButtonPressed)];
    self.navigationBar.items = @[navigationItem];
    [self.view addSubview:self.navigationBar];
}

- (void)initTemperatureControl
{
    self.temperatureControl = [[UISegmentedControl alloc] initWithItems:@[@"C°", @"F°"]];
    self.temperatureControl.frame = CGRectMake(0, 0, 0.8 * CGRectGetWidth(self.view.bounds), 44);
    self.temperatureControl.center = CGPointMake(self.view.center.x, 0.5 * self.view.center.y);
    self.temperatureControl.tintColor = [UIColor whiteColor];
    self.temperatureControl.selectedSegmentIndex = [WeatherStateManager temperatureScale];
    [self.temperatureControl addTarget:self action:@selector(temperatureControlChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.temperatureControl];
}

- (void)initLocationsTableView
{
    self.locationsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0.9 * self.view.center.y, CGRectGetWidth(self.view.bounds), self.view.center.y) style:UITableViewStylePlain];
    self.locationsTableView.dataSource = self;
    self.locationsTableView.delegate = self;
    self.locationsTableView.backgroundColor = [UIColor clearColor];
    self.locationsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.locationsTableView];
}

- (void)initLocationsTableViewTitleLabel
{
    static const CGFloat fontSize = 20;
    
    // "Locations"
    self.locationsTableViewTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0.775 * self.view.center.y, CGRectGetWidth(self.view.bounds), 1.5 * fontSize)];
    self.locationsTableViewTitleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:fontSize];
    self.locationsTableViewTitleLabel.textColor = [UIColor whiteColor];
    self.locationsTableViewTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.locationsTableViewTitleLabel.text = @"Locations";
    [self.view addSubview:self.locationsTableViewTitleLabel];
    
    // 分割线
    self.tableSeparatorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds) - 32, 0.5)];
    self.tableSeparatorView.center = CGPointMake(self.view.center.x, 0.9 * self.view.center.y);
    self.tableSeparatorView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
    [self.view addSubview:self.tableSeparatorView];
}

- (void)initCreditLabel
{
    static const CGFloat fontSize = 14;
    UILabel *creaditLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.bounds) - 2.0 * fontSize, self.view.bounds.size.width, 1.5 * fontSize)];
    creaditLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:fontSize];
    creaditLabel.textColor = [UIColor whiteColor];
    creaditLabel.textAlignment = NSTextAlignmentCenter;
    creaditLabel.text = @"Created By HeQingbao";
    [self.view addSubview:creaditLabel];
}

- (void)doneButtonPressed
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)temperatureControlChanged:(UISegmentedControl *)control
{
    TemperatureScale scale = (TemperatureScale)[control selectedSegmentIndex];
    [WeatherStateManager setTemperatureScale:scale];
    [self.delegate settingsViewController:self didChangeTemperatureScale:scale];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.locations.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    NSArray *locationMetaData = [self.locations objectAtIndex:indexPath.row];
    cell.textLabel.text = [locationMetaData firstObject];
    return cell;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    NSArray *locationMetaData = [self.locations objectAtIndex:sourceIndexPath.row];
    [self.locations removeObjectAtIndex:sourceIndexPath.row];
    [self.locations insertObject:locationMetaData atIndex:destinationIndexPath.row];
    [self.delegate settingsViewController:self didMoveWeatherViewAtIndex:sourceIndexPath.row toIndex:destinationIndexPath.row];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSArray *locationMetaData = [self.locations objectAtIndex:indexPath.row];
        NSNumber *weatherViewTag = [locationMetaData lastObject];
        [self.delegate settingsViewController:self didRemoveWeatherViewWithTag:weatherViewTag.integerValue];
        
        [self.locations removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [tableView reloadData];
        
        [UIView animateWithDuration:0.3 animations:^{
            self.locationsTableViewTitleLabel.alpha = (self.locations.count > 0) ? 1.0 : 0.0;
            self.tableSeparatorView.alpha = self.locationsTableViewTitleLabel.alpha;
        }];
    }
}

#pragma mark - UITableViewDelegate

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

@end
