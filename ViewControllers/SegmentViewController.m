//
//  SegmentViewController.m
//  DragonRides
//
//  Created by Boris Chirino on 03/03/16.
//  Copyright © 2016 Boris Chirino. All rights reserved.
//

#import "SegmentViewController.h"
#import "SegmentView.h"
#import "CoreDataStack.h"
#import "Segment.h"
#import "FlightDetails.h"
#import "BookingViewController.h"

#import <CoreData/CoreData.h>

@interface SegmentViewController ()<NSFetchedResultsControllerDelegate>
@property (nonatomic)  NSFetchedResultsController *fetchedResultsController;

@end

@implementation SegmentViewController



- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView{
    self.view = [SegmentView new];
    [(SegmentView*)self.view setController:self];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}


#pragma mark - TableView Datasource

-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    UITableViewHeaderFooterView * headerview = (UITableViewHeaderFooterView *)view;
    headerview.contentView.backgroundColor = [UIColor eBlueColor];
    headerview.textLabel.textColor = [UIColor whiteColor];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
        return [sectionInfo numberOfObjects];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
        return [[self.fetchedResultsController sections] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    //Segment *segmentItem = nil;
    //NSString *sectionTitle = nil;

        //segmentItem = [self.fetchedResultsController objectAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
        //NSString *stringPrice = [self.numberFormatter stringFromNumber:segmentItem.price];
        id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
        //sectionTitle = [NSString stringWithFormat:@"%@ starting at %@", [sectionInfo name], stringPrice];
    
    
    return [sectionInfo name];
    //[NSString stringWithFormat:@"%@ starting at %@",sectionTitle, stringPrice];
    //[NSString stringWithFormat:@"%@ from %@", segmentItem.outbound.destination, stringPrice];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSegmentCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kSegmentCellIdentifier];
    }
    Segment *segmentItem = segmentItem = [self.fetchedResultsController objectAtIndexPath:indexPath];

    
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@ / %@ - %@",
                           segmentItem.inbound.destination, segmentItem.inbound.origin,
                           segmentItem.outbound.destination, segmentItem.outbound.origin];
    if (self.exchangeRate != nil) {
        NSDecimalNumber *ridePrice = [[NSDecimalNumber alloc] initWithDouble:[segmentItem.price doubleValue]];
        NSDecimalNumber *convertedPrice = [ridePrice decimalNumberByMultiplyingBy: self.exchangeRate];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ .%@",NSLocalizedString(@"Price :", nil), [self.numberFormatter stringFromNumber:convertedPrice]];
    }else{
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ .%@",NSLocalizedString(@"Price :", nil), [self.numberFormatter stringFromNumber:segmentItem.price]];
    }
    
    //cell.detailTextLabel.text = [NSString stringWithFormat:@"Price : .%.2f", [segmentItem.price doubleValue]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BookingViewController *vc = [BookingViewController new];
    Segment *segmentItem = segmentItem = [self.fetchedResultsController objectAtIndexPath:indexPath];

    vc.selectedSegment = segmentItem;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - Fetched Results Controller

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil)
    {
        return _fetchedResultsController;
    }
    
    NSManagedObjectContext *moc = [CoreDataStack mainContext];
    if (moc)
    {
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Segment" inManagedObjectContext:moc];
        [fetchRequest setEntity:entity];
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"outbound.destination = %@ AND outbound.origin = %@",self.selectedSegment.outbound.destination, self.selectedSegment.outbound.origin];
        
        NSSortDescriptor *priceDescriptor = [[NSSortDescriptor alloc] initWithKey:@"price" ascending:YES];
        NSSortDescriptor *nameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"outbound.destination" ascending:YES];
        
        [fetchRequest setSortDescriptors:@[priceDescriptor,nameDescriptor]];
        [fetchRequest setPredicate:predicate];
        
        NSFetchedResultsController *frc = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                              managedObjectContext:moc
                                                                                sectionNameKeyPath:@"outbound.airline"
                                                                                         cacheName:nil];
        frc.delegate = self;
        self.fetchedResultsController = frc;
        
        NSError *error = nil;
        if (![self.fetchedResultsController performFetch:&error])
        {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        }
    }
    
    return _fetchedResultsController;
}

#pragma mark -
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView reloadData];
}




@end
