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
@property NSDateFormatter *dateFormatter;
@property Warrior *currentUser;
@property (nonatomic) UITableView *tableView;

/**
 *  return time elapsed from two input dates. Asumming Earth calendar time.
 *
 *  @param departureStrDate departure date string in dd/mm/YYYY format
 *  @param arrivalStrDate   arrival date string with dd/mm/YYYY format
 *
 *  @return formatted string. ex 2 years, 3 weeks, 10 days.
 */
-(NSString*)computedTravelTimeFrom:(NSString*)departureStrDate arrival:(NSString*)arrivalStrDate;

@end
