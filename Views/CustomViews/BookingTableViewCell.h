//
//  BookingTableViewCell.h
//  DragonRides
//
//  Created by Boris Chirino on 03/03/16.
//  Copyright © 2016 Boris Chirino. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Segment;
typedef NS_ENUM(NSUInteger, BOOKINGCELLUSE) {
    BOOKINGCELLUSE_ARRIVAL,
    BOOKINGCELLUSE_DEPARTURE
};

@interface BookingTableViewCell : UITableViewCell
@property Segment *segment;
@property UILabel *flightDurationLabel;

/**
 *  Build a cell to show in the BookingViewController view
 *
 *  @param segment         Segment entity used to fill cell data
 *  @param reuseIdentifier identifier used to retrieve cell on TableView reciclyng proccess
 *  @param cellPurpose     used to layout content according to arrival or destination.
 *
 *  @return BookingTableViewCell
 */
- (instancetype)initWithSegment:(Segment*)segment reuseIdentifier:(NSString*)reuseIdentifier cellPurpose:(BOOKINGCELLUSE)cellPurpose;

@end
