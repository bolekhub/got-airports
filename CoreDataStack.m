//
//  CoreDataStack.m
//  DragonRides
//
//  Created by Boris Chirino on 02/03/16.
//  Copyright © 2016 Boris Chirino. All rights reserved.
//

#import "CoreDataStack.h"
#import <CoreData/CoreData.h>
#import "Warrior.h"
#import "Segment.h"
#import "FlightsView.h"
#import "FlightDetails+CoreDataProperties.h"
#import "AppDelegate.h"

@implementation CoreDataStack
+(NSManagedObjectID*)createWarriorWithData:(NSDictionary*)data inContext:(NSManagedObjectContext*)context{
   Warrior *newObject = [NSEntityDescription insertNewObjectForEntityForName:@"Warrior" inManagedObjectContext:context];
    newObject.name = data[@"name"];
    newObject.surname = data[@"surname"];
    newObject.dob = data[@"dob"];
    newObject.currency = data[@"currency"];
    [(AppDelegate*)[UIApplication sharedApplication].delegate saveContext];
    return newObject.objectID;
}

+(void)createSegmentWithData:(NSDictionary*)data inContext:(NSManagedObjectContext*)context{
    Segment *segment = [NSEntityDescription insertNewObjectForEntityForName:@"Segment" inManagedObjectContext:context];
    segment.currency = data[@"currency"];
    segment.price =  [NSDecimalNumber decimalNumberWithDecimal:[data[@"price"] decimalValue]];
    
    FlightDetails *inbound = [NSEntityDescription insertNewObjectForEntityForName:@"FlightDetails" inManagedObjectContext:context];
    [inbound fromDictionary:data[@"inbound"]];
    segment.inbound = inbound;
    inbound.inboundSegment = segment;
    
    FlightDetails *outbound = [NSEntityDescription insertNewObjectForEntityForName:@"FlightDetails" inManagedObjectContext:context];
    [outbound fromDictionary:data[@"outbound"]];
    segment.outbound = outbound;
    outbound.outboundSegment = segment;
    
}


+ (void)saveWithBlock:(void(^)(NSManagedObjectContext *localContext))block completion:(void(^)(NSError *error))completion{
    NSManagedObjectContext *localContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    [localContext setParentContext:[self mainContext]];

    [localContext performBlock:^{
        if (block) {
            block(localContext);
        }
        NSError *error = nil;
        [localContext save:&error];
        if (error) {
            NSLog(@"Error saving on %@. /n error %@", NSStringFromSelector(_cmd), error.localizedDescription);
            completion(error);
        }else{
            completion(nil);
        }
    }];
}



+ (void)saveWithBlockAndWait:(void(^)(NSManagedObjectContext *localContext))block{
    NSManagedObjectContext *localContext = [CoreDataStack mainContext];
    
    [localContext performBlockAndWait:^{
        if (block) {
            block(localContext);
        }
        NSError *error = nil;
        [localContext save:&error];
        if (error) {
            NSLog(@"Error saving on %@. /n error %@", NSStringFromSelector(_cmd), error.localizedDescription);
        }
    }];
}

+(BOOL)updateWarrior:(NSManagedObjectID*)warriorId withData:(NSDictionary*)data inContext:(NSManagedObjectContext*)context{
    Warrior *warrior = [context objectWithID:warriorId];
    if (!warrior)
        return NO;
    
    warrior.name = data[@"name"];
    warrior.surname = data[@"surname"];
    warrior.dob = data[@"dob"];
    warrior.currency = data[@"currency"];
    
    [(AppDelegate*)[UIApplication sharedApplication].delegate saveContext];
    
    return YES;

}

+(void)saveMainContext{
    [(AppDelegate*)[UIApplication sharedApplication].delegate saveContext];
}

+(NSManagedObjectContext*)mainContext{
    NSManagedObjectContext *context = [(AppDelegate*)[UIApplication sharedApplication].delegate managedObjectContext];
    return context;
}


+(NSArray*)getAllSegments:(NSManagedObjectContext*)context{
    NSError *error = nil;
    NSFetchRequest *fr = [[NSFetchRequest alloc] initWithEntityName:@"Segment"];
    fr.predicate = nil;
    NSArray *segments = [context executeFetchRequest:fr error:&error];
    return  segments;
}


+(Warrior*)getWarriorInContext:(NSManagedObjectContext*)context {
    NSError *error = nil;
    NSFetchRequest *fr = [[NSFetchRequest alloc] initWithEntityName:@"Warrior"];
    fr.predicate = nil;
    NSArray *warriors = [context executeFetchRequest:fr error:&error];
    return  warriors.lastObject;
}

@end
