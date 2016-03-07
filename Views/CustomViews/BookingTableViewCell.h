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

- (instancetype)initWithSegment:(Segment*)segment reuseIdentifier:(NSString*)reuseIdentifier cellPurpose:(BOOKINGCELLUSE)cellPurpose;

@end
