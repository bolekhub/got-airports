//
//  BookingViewController.h
//  DragonRides
//
//  Created by Boris Chirino on 03/03/16.
//  Copyright © 2016 Boris Chirino. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Segment;
@interface BookingViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property Segment *selectedSegment;
@end
