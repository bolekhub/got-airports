//
//  WarriorDataView.h
//  DragonRides
//
//  Created by Boris Chirino on 02/03/16.
//  Copyright © 2016 Boris Chirino. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WarriorDataViewController;

@interface WarriorDataView : UIView
@property NSArray       *currencies ;
@property NSString      *selectedCurrency;
@property UIDatePicker  *dobPicker;
@property UIPickerView  *currencyPicker;
@property UITableView   *tableView;
@property (nonatomic) WarriorDataViewController *controller;


@end
