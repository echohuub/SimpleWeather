//
//  PagingNavigationTitleView.m
//  SimpleWeather
//
//  Created by HeQingbao on 14/11/16.
//  Copyright (c) 2014年 HeQingbao. All rights reserved.
//

#import "PagingNavigationTitleView.h"

#define kBaseLabelTag   1000

@interface PagingNavigationTitleView ()

@property (nonatomic, strong) NSMutableArray *titles;

@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSMutableArray *titleLabels;

@end

@implementation PagingNavigationTitleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initPageControl];
        
        self.titles = [NSMutableArray array];
        self.titleLabels = [NSMutableArray array];
    }
    return self;
}

- (void)initPageControl
{
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 36, CGRectGetWidth(self.bounds), 0)];
    self.pageControl.hidesForSinglePage = YES;
    self.pageControl.currentPage = self.currentPage;
    self.pageControl.currentPageIndicatorTintColor = [UIColor colorWithWhite:1.0 alpha:0.8];
    self.pageControl.pageIndicatorTintColor = [UIColor colorWithWhite:1.0 alpha:0.3];
    [self addSubview:self.pageControl];
}

- (void)addTitle:(NSString *)title
{
    [self.titles addObject:title];
    [self reloadData];
}

- (void)addTitles:(NSArray *)titles
{
    [self.titles addObjectsFromArray:titles];
    [self reloadData];
}

- (void)removeTitle:(NSString *)title
{
    NSUInteger index = [self.titles indexOfObject:title];
    if (index != NSNotFound) {
        [self.titles removeObject:title];
        
        UILabel *label = [self.titleLabels objectAtIndex:index];
        [label removeFromSuperview];
        [self.titleLabels removeObject:label];
        
        [self reloadData];
    }
}

- (void)moveTitleFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex
{
    NSString *title = [self.titles objectAtIndex:fromIndex];
    [self.titles removeObject:title];
    [self.titles insertObject:title atIndex:toIndex];
    
    [self reloadData];
}

- (void)reloadData
{
    if (self.titles.count == 0) {
        return;
    }
    
    [self.titles enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx, BOOL *stop) {
        CGRect titleLabelFrame = CGRectMake(idx * 100, 8, CGRectGetWidth(self.bounds), 20);
        UILabel *titleLabel = (UILabel *)[self viewWithTag:kBaseLabelTag + idx];
        if (!titleLabel) {
            titleLabel = [[UILabel alloc] init];
            titleLabel.tag = kBaseLabelTag + idx;
            titleLabel.font = [UIFont boldSystemFontOfSize:20];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.textColor = [UIColor whiteColor];
            titleLabel.backgroundColor = [UIColor clearColor];
            [self addSubview:titleLabel];
            [self.titleLabels addObject:titleLabel];
        }
        titleLabel.text = title;
        titleLabel.frame = titleLabelFrame;
        if (self.currentPage == idx) {
            titleLabel.alpha = 1.0;
        } else {
            titleLabel.alpha = 0.0;
        }
    }];
    
    self.pageControl.numberOfPages = self.titles.count;
    
    self.contentOffset = CGPointMake(self.currentPage * CGRectGetWidth([UIScreen mainScreen].bounds), 0);
}

#pragma mark - Setter/Getter

- (void)setCurrentPage:(NSUInteger)currentPage
{
    if (_currentPage == currentPage) {
        return;
    }
    
    _currentPage = currentPage;
    self.pageControl.currentPage = currentPage;
}

- (void)setContentOffset:(CGPoint)contentOffset
{
    _contentOffset = contentOffset;
    
    CGFloat xOffset = contentOffset.x;
    
    CGFloat normalWidth = CGRectGetWidth([UIScreen mainScreen].bounds);
    
    [self.titleLabels enumerateObjectsUsingBlock:^(UILabel *titleLabel, NSUInteger idx, BOOL *stop) {
        if ([titleLabel isKindOfClass:[UILabel class]]) {
            
            // frame
            CGRect titleLabelFrame = titleLabel.frame;
            titleLabelFrame.origin.x = idx * 100 - xOffset / 3.2;
            titleLabel.frame = titleLabelFrame;
            
            // alpha
            CGFloat alpha;
            if(xOffset < normalWidth * idx) {
                alpha = (xOffset - normalWidth * (idx - 1)) / normalWidth;
            }else{
                alpha = 1 - ((xOffset - normalWidth * idx) / normalWidth);
            }
            titleLabel.alpha = alpha;
        }
    }];
}

@end
