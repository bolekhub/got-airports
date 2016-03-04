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

+(NSArray*)getAllSegments:(NSManagedObjectContext*)context ;

+(void)createSegmentWithData:(NSDictionary*)data inContext:(NSManagedObjectContext*)context;

+(NSManagedObjectContext*)mainContext;

+(void)saveMainContext;

+ (void)saveWithBlock:(void(^)(NSManagedObjectContext *localContext))block completion:(void(^)(NSError *error))completion;

+ (void)saveWithBlockAndWait:(void(^)(NSManagedObjectContext *localContext))block;

@end
