//
//  PagingNavigationTitleView.h
//  SimpleWeather
//
//  Created by HeQingbao on 14/11/16.
//  Copyright (c) 2014年 HeQingbao. All rights reserved.
//

@interface PagingNavigationTitleView : UIView

@property (nonatomic, assign) NSUInteger currentPage;
@property (nonatomic, assign) CGPoint contentOffset;

- (void)addTitle:(NSString *)title;
- (void)addTitles:(NSArray *)titles;

- (void)removeTitle:(NSString *)title;
- (void)moveTitleFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;

@end
