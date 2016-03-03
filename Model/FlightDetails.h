//
//  FlightDetails.h
//  DragonRides
//
//  Created by Boris Chirino on 03/03/16.
//  Copyright © 2016 Boris Chirino. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Segment;

NS_ASSUME_NONNULL_BEGIN

@interface FlightDetails : NSManagedObject

// Insert code here to declare functionality of your managed object subclass
- (void)fromDictionary:(NSDictionary*)dict;

@end

NS_ASSUME_NONNULL_END

#import "FlightDetails+CoreDataProperties.h"
