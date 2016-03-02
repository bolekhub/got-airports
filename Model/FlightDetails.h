//
//  FlightDetails.h
//  DragonRides
//
//  Created by Boris Chirino on 01/03/16.
//  Copyright © 2016 Boris Chirino. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FlightDetails : NSObject
@property NSString *origin;
@property NSString *destination;
@property NSString *airline;
@property NSString *airlineImageUrlString;
@property NSString *arrivalDate;
@property NSString *arrivalTime;
@property NSString *departureDate;
@property NSString *departureTime;


- (instancetype)initWithDictionary:(NSDictionary*)dictionary;
@end
