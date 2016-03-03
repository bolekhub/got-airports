//
//  BookingTableViewCell.h
//  DragonRides
//
//  Created by Boris Chirino on 03/03/16.
//  Copyright © 2016 Boris Chirino. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Segment;

@interface BookingTableViewCell : UITableViewCell
@property Segment *segment;

- (instancetype)initWithSegment:(Segment*)segment reuseIdentifier:(NSString*)reuseIdentifier;

@end
