//
//  FlightDetails+CoreDataProperties.h
//  DragonRides
//
//  Created by Boris Chirino on 04/03/16.
//  Copyright © 2016 Boris Chirino. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "FlightDetails.h"

NS_ASSUME_NONNULL_BEGIN

@interface FlightDetails (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *airline;
@property (nullable, nonatomic, retain) NSString *airlineImageUrlString;
@property (nullable, nonatomic, retain) NSString *arrivalDate;
@property (nullable, nonatomic, retain) NSString *arrivalTime;
@property (nullable, nonatomic, retain) NSString *departureDate;
@property (nullable, nonatomic, retain) NSString *departureTime;
@property (nullable, nonatomic, retain) NSString *destination;
@property (nullable, nonatomic, retain) NSString *origin;
@property (nullable, nonatomic, retain) Segment *inboundSegment;
@property (nullable, nonatomic, retain) Segment *outboundSegment;

@end

NS_ASSUME_NONNULL_END
