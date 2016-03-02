//
//  Segment.h
//  DragonRides
//
//  Created by Boris Chirino on 01/03/16.
//  Copyright © 2016 Boris Chirino. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FlightDetails.h"
@interface Segment : NSObject

@property NSString *currency;
@property NSNumber *price;
@property FlightDetails *inbound;
@property FlightDetails *outbound;



@end
