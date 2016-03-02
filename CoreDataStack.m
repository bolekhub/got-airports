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

+(Warrior*)getWarriorInContext:(NSManagedObjectContext*)context {
    NSError *error = nil;
    NSFetchRequest *fr = [[NSFetchRequest alloc] initWithEntityName:@"Warrior"];
    fr.predicate = nil;
    NSArray *warriors = [context executeFetchRequest:fr error:&error];
    return  warriors.lastObject;
}

@end
