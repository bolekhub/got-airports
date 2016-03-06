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
#import "BookingFooterView.h"
#import "WarriorDataViewController.h"

static NSString *kBookingCellArrivalIdentifier      = @"bookingCellArrival";
static NSString *kBookingCellDepartureIdentifier    = @"bookingCellDeparture";
static NSString *kBookingCellDummyIdentifier        = @"bookingCellDummy";
static NSString *kBookingCellUserDetailsIdentifier  = @"bookingCellUserIdentifier";




@interface BookingViewController ()
@property (nonatomic) BookingFooterView *footerView;
@end

@implementation BookingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.footerView.bookButton addTarget:self action:@selector(bookAction:) forControlEvents:UIControlEventTouchUpInside];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    _footerView = nil;
}

- (void)loadView{
    self.view = [BookingView new];
    [(BookingView*)self.view setController:self];
}

#pragma mark -TableView Datasource

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return self.footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 160.0f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"";
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            return 90.0f; // UserCell
            break;
        case 1:
            return 190.0f; // Outbound
            break;
        case 2:
            return 20.0f; //Space
            break;
        case 3:
            return 190.0f; // Inbound
            break;
            
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = nil;
    if (indexPath.row == 0) {
        cell = [self.tableView dequeueReusableCellWithIdentifier:kBookingCellUserDetailsIdentifier];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kBookingCellUserDetailsIdentifier];
        [cell setBackgroundColor:[UIColor clearColor]];
        if (self.currentUser) {
            cell.textLabel.text = [NSString stringWithFormat:@"Warrior :%@ %@", self.currentUser.name, self.currentUser.surname];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"Your prefed currency is : %@", self.currentUser.currency];
        }else{
            cell.textLabel.text = @"There's no warrior details";
            cell.detailTextLabel.text = @"To book a ride we need to know who are you.";
        }
    }
    else if (indexPath.row == 1)
    {
        cell = [self.tableView dequeueReusableCellWithIdentifier:kBookingCellDepartureIdentifier];
        if (cell == nil) {
            cell = [[BookingTableViewCell alloc] initWithSegment:self.selectedSegment reuseIdentifier:kBookingCellDepartureIdentifier cellPurpose:BOOKINGCELLUSE_DEPARTURE];
        }
    }
    else if (indexPath.row == 2)
    {
        cell = [self.tableView dequeueReusableCellWithIdentifier:kBookingCellDummyIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kBookingCellDummyIdentifier];
            [cell setBackgroundColor:[UIColor clearColor]];
        }
        
    }else if (indexPath.row == 3){
        cell = [self.tableView dequeueReusableCellWithIdentifier:kBookingCellArrivalIdentifier];
        if (cell == nil) {
            cell = [[BookingTableViewCell alloc] initWithSegment:self.selectedSegment reuseIdentifier:kBookingCellArrivalIdentifier cellPurpose:BOOKINGCELLUSE_ARRIVAL];
        }
    }
    
    
    return cell;
}

#pragma mark - UIactions

- (void)bookAction:(id)sender{
    if (self.currentUser) {
        [CoreDataStack saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
            [self.currentUser addMyTrypsObject:self.selectedSegment];
        }];
    }else{
        [self dialogWithTitle:@"Warning" messageBody:@"To book a ride first you need to register" actionCompletion:^(UIAlertAction * _Nonnull action) {
            NSLog(@"Perro");
            [self openSettings:self];
        }];
    }
}

-(void)openSettings:(id)sender {
    WarriorDataViewController *vc = [WarriorDataViewController new];
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
    
    vc.warrior = nil;
    [self presentViewController:nc animated:YES completion:nil];
}

#pragma mark - Private Methods
-(void)dialogWithTitle:(NSString*)title messageBody:(NSString *)messageBody actionCompletion:(void(^)(UIAlertAction * _Nonnull action))completion{
    __weak typeof(self) weakSelf = self;
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:title message:messageBody preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        //[weakSelf dismissViewControllerAnimated:YES completion:nil];
    }];
    UIAlertAction *go = [UIAlertAction actionWithTitle:@"Register" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completion(action);
    }];
    
    [controller addAction:cancel];
    [controller addAction:go];
    [self presentViewController:controller animated:YES completion:nil];
}

#pragma mark - ComputedProperties

/**
 *  Footer view must be protected because everytime the footer is scrolled out of screen and appear again the view will be created over and over. with this approach a single instance will be created
 *
 *  @return configured BookingFooterView instance
 */
- (BookingFooterView *)footerView{
    if (_footerView == nil) {
            _footerView = [BookingFooterView new];
        
        if (self.exchangeRate != nil) {
            NSDecimalNumber *ridePrice = [[NSDecimalNumber alloc] initWithDouble:[self.selectedSegment.price doubleValue]];
            NSDecimalNumber *convertedPrice = [ridePrice decimalNumberByMultiplyingBy: self.exchangeRate];
            _footerView.resumeLabel.text = [NSString stringWithFormat:@"%@ %@",NSLocalizedString(@"Ride cost :", nil), [self.numberFormatter stringFromNumber:convertedPrice]];

        }else{
            _footerView.resumeLabel.text = [NSString stringWithFormat:@"%@ %@",NSLocalizedString(@"Ride cost :", nil), [self.numberFormatter stringFromNumber:self.selectedSegment.price]];
        }
        
    }
    
    return _footerView;
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
