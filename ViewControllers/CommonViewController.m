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
    
    self.dateFormatter = [NSDateFormatter new];
    [self.dateFormatter setDateFormat:@"dd/mm/YYYY"];
    
    if ([self isKindOfClass:[SegmentViewController class]]) {
        self.title = NSLocalizedString(@"Segments", nil);
    }else if ([self isKindOfClass:[FlightsViewController class]]){
        self.title = NSLocalizedString(@"Available Dragon's rides", nil);
    }else if ([self isKindOfClass:[BookingViewController class]]){
        self.title = NSLocalizedString(@"Your ride details", nil);
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
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

-(NSString*)computedTravelTimeFrom:(NSString*)departureStrDate arrival:(NSString*)arrivalStrDate{
    NSDate *date1 = [self.dateFormatter dateFromString:departureStrDate];
    NSDate *date2 = [self.dateFormatter dateFromString:arrivalStrDate];
    NSTimeInterval ti = [date2 timeIntervalSinceDate:date1];
    NSTimeInterval minutes = ti/60;
    NSTimeInterval hours = minutes/60;
    NSTimeInterval days = hours/24;
    NSTimeInterval weeks = days/7;
    NSTimeInterval months = weeks/4;
    NSTimeInterval years = months/12;
    

    
    NSString *travelTime = nil;
    if (years>0) {
        travelTime = [NSString stringWithFormat:@"%@ %.2f %@", NSLocalizedString(@"Estimated flight duration ", nil), years,  NSLocalizedString(@"years", nil)];
    }else if (months > 0){
        travelTime = [NSString stringWithFormat:@"%@ %.2f %@", NSLocalizedString(@"Estimated flight duration ", nil), months, NSLocalizedString(@"months", nil)];
    }else if (weeks > 0){
        travelTime = [NSString stringWithFormat:@"%@ %.2f %@", NSLocalizedString(@"Estimated flight duration ", nil), weeks,  NSLocalizedString(@"weeks", nil)];
    }else if (days>0){
        travelTime = [NSString stringWithFormat:@"%@ %.2f %@", NSLocalizedString(@"Estimated flight duration ", nil), days,  NSLocalizedString(@"days", nil)];
    }
    
    return travelTime;
}


-(UITableView*)tableView{
    // polimorphism . same method for multiple instance, this base class build the message but each class must respond to tableView.
    // to succed.
    UITableView *tableView = [self.view performSelector:@selector(tableView)];
    return tableView;
}

@end
