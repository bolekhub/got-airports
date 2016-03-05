//
//  BookingViewController.h
//  DragonRides
//
//  Created by Boris Chirino on 03/03/16.
//  Copyright © 2016 Boris Chirino. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonViewController.h"
@class Segment;
@interface BookingViewController :CommonViewController  <UITableViewDelegate, UITableViewDataSource>
@property Segment *selectedSegment;
@end
