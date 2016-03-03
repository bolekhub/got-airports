//
//  FlightDetails.m
//  DragonRides
//
//  Created by Boris Chirino on 03/03/16.
//  Copyright © 2016 Boris Chirino. All rights reserved.
//

#import "FlightDetails.h"
#import "Segment.h"

@implementation FlightDetails

// Insert code here to add functionality to your managed object subclass
- (void)fromDictionary:(NSDictionary *)dict{
    self.airline                = dict[@"airline"];
    self.airlineImageUrlString  = dict[@"airlineImage"];
    self.origin                 = dict[@"origin"];
    self.destination            = dict[@"destination"];
    self.departureDate          = dict[@"departureDate"];
    self.departureTime          = dict[@"departureTime"];
    self.arrivalDate            = dict[@"arrivalDate"];
    self.arrivalTime            = dict[@"arrivalTime"];
}
@end
