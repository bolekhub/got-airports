//
//  FlightsView.h
//  DragonRides
//
//  Created by Boris Chirino on 02/03/16.
//  Copyright © 2016 Boris Chirino. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FlightsViewController;
@interface FlightsView : UIView
@property UITableView *tableView;
@property (nonatomic, weak) FlightsViewController *controller;
@end
