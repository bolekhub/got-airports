//
//  BookingView.h
//  DragonRides
//
//  Created by Boris Chirino on 03/03/16.
//  Copyright © 2016 Boris Chirino. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BookingViewController;
@interface BookingView : UIView
@property UITableView *tableView;
@property (nonatomic, weak) BookingViewController *controller;
@end
