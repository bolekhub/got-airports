//
//  CoreDataStack.h
//  DragonRides
//
//  Created by Boris Chirino on 02/03/16.
//  Copyright © 2016 Boris Chirino. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Warrior,NSManagedObjectID,NSManagedObjectContext;
@interface CoreDataStack : NSObject

+(NSManagedObjectID*)createWarriorWithData:(NSDictionary*)data inContext:(NSManagedObjectContext*)context;

+(BOOL)updateWarrior:(NSManagedObjectID*)warriorId withData:(NSDictionary*)data inContext:(NSManagedObjectContext*)context;

+(Warrior*)getWarriorInContext:(NSManagedObjectContext*)context ;
@end
