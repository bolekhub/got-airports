//
//  WarriorDataViewController.h
//  DragonRides
//
//  Created by Boris Chirino on 02/03/16.
//  Copyright © 2016 Boris Chirino. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Warrior,WarriorDataViewController, Warrior;

@protocol WarriorDataViewControllerDelegate <NSObject>

- (void)controller:(WarriorDataViewController*)controller didSaveWarrior:(Warrior*)warrior;

@end

@interface WarriorDataViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property Warrior *warrior;
@property (nonatomic, weak) id<WarriorDataViewControllerDelegate> delegate;
@end
