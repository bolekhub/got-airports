//
//  CommonViewController.h
//  DragonRides
//
//  Created by Boris Chirino on 05/03/16.
//  Copyright © 2016 Boris Chirino. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Warrior;
@interface CommonViewController : UIViewController
@property NSDecimalNumber *exchangeRate;
@property NSNumberFormatter *numberFormatter;
@property Warrior *currentUser;
@property (nonatomic) UITableView *tableView;
@end
