//
//  AddLocationViewController.h
//  SimpleWeather
//
//  Created by HeQingbao on 14/6/23.
//  Copyright (c) 2014年 HeQingbao. All rights reserved.
//

@class AddLocationViewController;
@class Location;
@protocol AddLocationViewControllerDelegate <NSObject>

@required
- (void)addLocationViewController:(AddLocationViewController *)controller didAddLocation:(Location *)location;

@end

@interface AddLocationViewController : UIViewController

@property (nonatomic, weak) id<AddLocationViewControllerDelegate> delegate;

@end
