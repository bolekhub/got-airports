//
//  BookingViewController.m
//  DragonRides
//
//  Created by Boris Chirino on 03/03/16.
//  Copyright © 2016 Boris Chirino. All rights reserved.
//

#import "BookingViewController.h"
#import "BookingView.h"
#import "Segment.h"
#import "Warrior.h"
#import "FlightDetails.h"
#import "CoreDataStack.h"
#import "BookingTableViewCell.h"
#import "WebService.h"

static NSString *kBookingCellIdentifier = @"bookingCell";


@interface BookingViewController ()
@property NSNumberFormatter *numberFormatter;
@property (nonatomic)  UITableView *tableView;

@end

@implementation BookingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _numberFormatter = [NSNumberFormatter new];
    _numberFormatter.numberStyle = kCFNumberFormatterCurrencyStyle;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView{
    self.view = [BookingView new];
    [(BookingView*)self.view setController:self];
}

#pragma mark -TableView Datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"";
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 190.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BookingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kBookingCellIdentifier];
    if (cell == nil) {
        cell = [[BookingTableViewCell alloc] initWithSegment:self.selectedSegment reuseIdentifier:kBookingCellIdentifier];
    }
    
    return cell;
}



#pragma mark - ComputedProperties
- (UITableView *)tableView{
    return [(BookingView*)self.view tableView];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
