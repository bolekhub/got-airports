//
//  Segment+CoreDataProperties.h
//  DragonRides
//
//  Created by Boris Chirino on 03/03/16.
//  Copyright © 2016 Boris Chirino. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Segment.h"

NS_ASSUME_NONNULL_BEGIN

@interface Segment (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *currency;
@property (nullable, nonatomic, retain) NSDecimalNumber *price;
@property (nullable, nonatomic, retain) FlightDetails *inbound;
@property (nullable, nonatomic, retain) FlightDetails *outbound;

@end

NS_ASSUME_NONNULL_END
