//
//  CommonViewController.m
//  DragonRides
//
//  Created by Boris Chirino on 05/03/16.
//  Copyright © 2016 Boris Chirino. All rights reserved.
//

#import "CommonViewController.h"
#import "Warrior.h"
#import "CoreDataStack.h"
#import "FlightsView.h"
#import "SegmentView.h"
#import "BookingView.h"
#import "SegmentViewController.h"
#import "FlightsViewController.h"
#import "BookingViewController.h"

@implementation CommonViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.numberFormatter = [NSNumberFormatter new];
    self.numberFormatter.numberStyle = kCFNumberFormatterCurrencyStyle;
    
    if ([self isKindOfClass:[SegmentViewController class]]) {
        self.title = @"Segments";
    }else if ([self isKindOfClass:[FlightsViewController class]]){
        self.title = @"Available Dragon's rides";
    }else if ([self isKindOfClass:[BookingViewController class]]){
        self.title = @"Your ride details";
    }

    Warrior *registeredUser = [CoreDataStack getWarriorInContext:[CoreDataStack mainContext]];
    if (registeredUser) {
        self.currentUser = registeredUser;
        self.numberFormatter.currencyCode = registeredUser.currency;
        NSNumber *xchangeAsNumber = [[NSUserDefaults standardUserDefaults] valueForKey:kExchangeRateValue];
        self.exchangeRate = [[NSDecimalNumber alloc] initWithDouble:[xchangeAsNumber doubleValue]];
    }else{
        self.numberFormatter.currencyCode = @"EUR";
    }
}

-(id)tableView{
    UITableView *tableView = [self.view performSelector:@selector(tableView)];
    return tableView;
}

@end