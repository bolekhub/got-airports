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



/**
 *  Update a Warrior object
 *
 *  @param warriorId the NSmanagedObject ID of the entity
 *  @param data      Key: value objects where key is mapped to entity name and assigned value
 *  @param context   the context used to update this object
 *
 *  @return true if update succed
 */
+(BOOL)updateWarrior:(NSManagedObjectID*)warriorId withData:(NSDictionary*)data inContext:(NSManagedObjectContext*)context;




/**
 *  Retrieve 1 Warrior entity
 *
 *  @param context the context used to perform operation
 *
 *  @return Warrior object or nil
 */
+(Warrior*)getWarriorInContext:(NSManagedObjectContext*)context ;




/**
 *  fetch all Segments entity
 *
 *  @param context the context used to perform operation
 *
 *  @return array of Segments
 */
+(NSArray*)getAllSegments:(NSManagedObjectContext*)context ;




/**
 *  Create warrior entity
 *
 *  @param data    Key: value objects where key is mapped to entity name and assigned value
 *  @param context the context used to create this object
 *
 *  @return return the objectID according to creation patterns
 */
+(NSManagedObjectID*)createWarriorWithData:(NSDictionary*)data inContext:(NSManagedObjectContext*)context;



/**
 *  Create segment Entity
 *
 *  @param data    Key: value objects where key is mapped to entity name and assigned value
 *  @param context the context used to create this object
 */
+(void)createSegmentWithData:(NSDictionary*)data inContext:(NSManagedObjectContext*)context;




/**
 *  this method return the main context created when the app starts.
 *
 *  @return the main context of the ManagedObjectModel. retrieve the value from AppDelegate managedObjectContext property
 */
+(NSManagedObjectContext*)mainContext;



/**
 *  Save main context
 */
+(void)saveMainContext;



/**
 *  Asyncronous save, you should save the parent context in order to perist data to PSC, the parent context is [CoreDataStack mainContext]
 *
 *  @param block this block is used to create objects using the given localcontext, wich is a private queue
 */
+ (void)saveWithBlock:(void(^)(NSManagedObjectContext *localContext))block completion:(void(^)(NSError *error))completion;




/**
 *  syncronous save
 *
 *  @param block this block is used to create objects using the given localcontext
 */
+ (void)saveWithBlockAndWait:(void(^)(NSManagedObjectContext *localContext))block;

@end
