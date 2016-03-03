//
//  FlightDetails+CoreDataProperties.m
//  DragonRides
//
//  Created by Boris Chirino on 03/03/16.
//  Copyright © 2016 Boris Chirino. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "FlightDetails+CoreDataProperties.h"

@implementation FlightDetails (CoreDataProperties)

@dynamic origin;
@dynamic destination;
@dynamic airline;
@dynamic airlineImageUrlString;
@dynamic arrivalDate;
@dynamic arrivalTime;
@dynamic departureTime;
@dynamic departureDate;
@dynamic inboundSegment;
@dynamic outboundSegment;

@end
