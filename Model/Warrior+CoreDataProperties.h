//
//  Warrior+CoreDataProperties.h
//  DragonRides
//
//  Created by Boris Chirino on 04/03/16.
//  Copyright © 2016 Boris Chirino. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Warrior.h"

NS_ASSUME_NONNULL_BEGIN
@class Segment;
@interface Warrior (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *currency;
@property (nullable, nonatomic, retain) NSDate *dob;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *surname;
@property (nullable, nonatomic, retain) NSSet<Segment *> *myTryps;

@end

@interface Warrior (CoreDataGeneratedAccessors)

- (void)addMyTrypsObject:(Segment *)value;
- (void)removeMyTrypsObject:(Segment *)value;
- (void)addMyTryps:(NSSet<Segment *> *)values;
- (void)removeMyTryps:(NSSet<Segment *> *)values;

@end

NS_ASSUME_NONNULL_END
