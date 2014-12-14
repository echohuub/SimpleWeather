//
//  AddLocationViewController.m
//  SimpleWeather
//
//  Created by HeQingbao on 14/6/23.
//  Copyright (c) 2014年 HeQingbao. All rights reserved.
//

#import "AddLocationViewController.h"
#import "LocationSearcher.h"
#import "Location.h"

@interface AddLocationViewController () <UISearchBarDelegate, UISearchDisplayDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UINavigationBar *navigationBar;
@property (nonatomic, strong) UISearchDisplayController *searchController;
@property (nonatomic, strong) NSMutableArray *searchResults;

@end

@implementation AddLocationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"gradient3"]];
        [self initSearchBar];
        
        self.searchResults = [NSMutableArray array];
    }
    return self;
}

// 初始化SearchBar
- (void)initSearchBar
{
    self.navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 64)];
    self.navigationBar.translucent = YES;
    [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.tintColor = [UIColor whiteColor];
    [self.view addSubview:self.navigationBar];
    
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0, self.navigationBar.bounds.size.height, self.navigationBar.bounds.size.width, 0.5);
    bottomBorder.backgroundColor = [UIColor lightGrayColor].CGColor;
    [self.navigationBar.layer addSublayer:bottomBorder];
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 44)];
    searchBar.barStyle = UIBarStyleDefault;
    searchBar.placeholder = @"请输入城市名称";
    searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    searchBar.delegate = self;
    searchBar.showsCancelButton = YES;
    
    self.searchController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
    self.searchController.displaysSearchBarInNavigationBar = YES;
    self.searchController.delegate = self;
    self.searchController.searchResultsDataSource = self;
    self.searchController.searchResultsDelegate = self;
    self.searchController.searchResultsTitle = @"添加城市";
    
    self.navigationBar.items = @[self.searchController.navigationItem];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.searchController setActive:YES animated:YES];
    [self.searchController.searchBar becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.searchController setActive:NO animated:NO];
    [self.searchController.searchBar resignFirstResponder];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UISearchBarDelegate
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UISearchDisplayDelegate
- (void)searchDisplayController:(UISearchDisplayController *)controller willHideSearchResultsTableView:(UITableView *)tableView
{
    // 需要在willHideSearchResultsTableView或者didHideSearchResultsTableView方法里面调用此方法
    // 否则第一次打开SearchBar也会暗下去
    [self.view bringSubviewToFront:self.navigationBar];
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [[LocationSearcher sharedLocationSearcher] locationForString:searchString completion:^(NSArray *locations, NSError *error) {
        if (locations) {
            [self.searchResults removeAllObjects];
            [self.searchResults addObjectsFromArray:locations];
            [self.searchController.searchResultsTableView reloadData];
        }
    }];
    return NO;
}

- (void)searchDisplayController:(UISearchDisplayController *)controller willShowSearchResultsTableView:(UITableView *)tableView
{
    // 默认tableView.frame.origin.y == 0;并且从status bar下面开始
    if (tableView.frame.origin.y == 20) {
        return;
    }
    
    CGFloat y = CGRectGetHeight(controller.searchBar.bounds);
    [tableView setFrame:CGRectMake(0, y, CGRectGetWidth(self.view.bounds),
                                   CGRectGetHeight(self.view.bounds) - y)];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.delegate = self;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.searchResults.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor whiteColor];
    }
    
    if (tableView == self.searchController.searchResultsTableView) {
        Location *location = [self.searchResults objectAtIndex:indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@", location.region, location.city];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Location *location = self.searchResults[indexPath.row];
    [self.delegate addLocationViewController:self didAddLocation:location];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
