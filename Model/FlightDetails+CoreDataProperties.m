//
//  FlightDetails+CoreDataProperties.m
//  DragonRides
//
//  Created by Boris Chirino on 04/03/16.
//  Copyright © 2016 Boris Chirino. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "FlightDetails+CoreDataProperties.h"

@implementation FlightDetails (CoreDataProperties)

@dynamic airline;
@dynamic airlineImageUrlString;
@dynamic arrivalDate;
@dynamic arrivalTime;
@dynamic departureDate;
@dynamic departureTime;
@dynamic destination;
@dynamic origin;
@dynamic inboundSegment;
@dynamic outboundSegment;

@end
