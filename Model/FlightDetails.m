//
//  FlightDetails.m
//  DragonRides
//
//  Created by Boris Chirino on 01/03/16.
//  Copyright © 2016 Boris Chirino. All rights reserved.
//

#import "FlightDetails.h"

@implementation FlightDetails
- (instancetype)initWithDictionary:(NSDictionary*)dictionary{
    if (self = [super init]) {
        _airline                = dictionary[@"airline"];
        _airlineImageUrlString  = dictionary[@"airlineImage"];
        _origin                 = dictionary[@"origin"];
        _destination            = dictionary[@"destination"];
        _departureDate          = dictionary[@"departureDate"];
        _departureTime          = dictionary[@"departureTime"];
        _arrivalDate            = dictionary[@"arrivalDate"];
        _arrivalTime            = dictionary[@"arrivalTime"];
    }
    return self;
}
@end
