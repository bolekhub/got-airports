//
//  FlightsViewController.m
//  DragonRides
//
//  Created by Boris Chirino on 02/03/16.
//  Copyright © 2016 Boris Chirino. All rights reserved.
//

#import "FlightsViewController.h"
#import "FlightsView.h"
#import "Segment.h"
#import "CoreDataStack.h"

static NSString *kSegmentCellIdentifier = @"segmentCell";

@interface FlightsViewController ()
@property NSMutableArray *sections;
@property NSNumberFormatter *numberFormatter;
@end

@implementation FlightsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _numberFormatter = [NSNumberFormatter new];
    _numberFormatter.numberStyle = kCFNumberFormatterCurrencyStyle;
//    _numberFormatter.currencyCode
    
    _sections = [[NSMutableArray alloc] initWithCapacity:0];
    // Do any additional setup after loading the view.
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(closeController:)]];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_apply([self.availableFlights count], queue, ^(size_t i) {
        Segment *segment = self.availableFlights[i];
        NSString *destination = segment.outbound.destination;
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"outbound.destination == %@",destination];
        NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"price" ascending:YES];
        NSArray *destinationGrouped = [self.availableFlights filteredArrayUsingPredicate:predicate];
        [self.sections addObject:[destinationGrouped sortedArrayUsingDescriptors:@[sortDescriptor]]];
    });
    
//    for (Segment *segment in self.availableFlights) {
//        NSString *destination = segment.outbound.destination;
//        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"outbound.destination == %@",destination];
//        NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"price" ascending:YES];
//        NSArray *destinationGrouped = [self.availableFlights filteredArrayUsingPredicate:predicate];
//        [self.sections addObject:[destinationGrouped sortedArrayUsingDescriptors:@[sortDescriptor]]];
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)loadView{
    self.view = [FlightsView new];
    [(FlightsView*)self.view setController:self];
}


#pragma mark UIActions
-(void)closeController:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark -TableViewDataSOurce

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.sections[section] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.sections count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    Segment *segmentItem = self.sections[section][0];
    NSString *stringPrice = [self.numberFormatter stringFromNumber:segmentItem.price];
    return [NSString stringWithFormat:@"%@ from %@", segmentItem.outbound.destination, stringPrice];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSegmentCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kSegmentCellIdentifier];
    }
    Segment *segmentItem = self.sections[indexPath.section][indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@ / %@ - %@",
                           segmentItem.inbound.destination, segmentItem.inbound.origin,
                           segmentItem.outbound.destination, segmentItem.outbound.origin];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Price : .%.2f", [segmentItem.price doubleValue]];
    return cell;
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
