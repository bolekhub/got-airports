//
//  FlightsViewController.m
//  DragonRides
//
//  Created by Boris Chirino on 02/03/16.
//  Copyright © 2016 Boris Chirino. All rights reserved.
//

#import "FlightsViewController.h"
#import "FlightsView.h"
#import "FlightDetails.h"
#import "Segment.h"
#import "CoreDataStack.h"

static NSString *kSegmentCellIdentifier = @"segmentCell";

@interface FlightsViewController ()<NSFetchedResultsControllerDelegate>
@property NSArray *filteredList;
@property NSNumberFormatter *numberFormatter;
@property (nonatomic)  UITableView *tableView;
@property (nonatomic)  UISearchController *searchController;

@property (nonatomic)  NSFetchedResultsController *fetchedResultsController;
@property (nonatomic) NSFetchRequest *searchFetchRequest;


@end

@implementation FlightsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.definesPresentationContext = YES;
    
    _numberFormatter = [NSNumberFormatter new];
    _numberFormatter.numberStyle = kCFNumberFormatterCurrencyStyle;
//    _numberFormatter.currencyCode
    
    // Do any additional setup after loading the view.
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(closeController:)]];

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

#pragma mark - Private Methods
- (void)searchForText:(NSString *)searchText
{

        NSString *predicateFormat = @"%K BEGINSWITH[cd] %@";
        NSString *searchAttribute = @"outbound.destination";
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:predicateFormat, searchAttribute, searchText];
    [self.searchFetchRequest setPredicate:predicate];
    
    NSError *error = nil;
    NSManagedObjectContext *moc = [CoreDataStack mainContext];
    self.filteredList = [moc executeFetchRequest:self.searchFetchRequest error:&error];
    if (error)
    {
        NSLog(@"searchFetchRequest failed: %@",[error localizedDescription]);
    }
}


#pragma mark - UISearchResultsUpdating Delegate
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    NSString *searchString = searchController.searchBar.text;
        [self searchForText:searchString];
        [self.tableView reloadData];
}

#pragma mark - UISearchController Delegate
- (void)willPresentSearchController:(UISearchController *)searchController{
    _filteredList = [[NSMutableArray alloc] initWithCapacity:0];
}

-(void)didDismissSearchController:(UISearchController *)searchController{
    _filteredList = nil;
}

#pragma mark UIActions
-(void)closeController:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark -TableViewDataSOurce

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([self.searchController isActive]) {
        return [self.filteredList count];
    }else{
        id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
        return [sectionInfo numberOfObjects];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if ([self.searchController isActive]) {
        return 1;
        //[self.filteredList count];
    }else{
        return [[self.fetchedResultsController sections] count];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    Segment *segmentItem = nil;
    NSString *sectionTitle = nil;
    if ([self.searchController isActive]) {
//        segmentItem = self.filteredList[section];
//        NSString *stringPrice = [self.numberFormatter stringFromNumber:segmentItem.price];
//        sectionTitle = [NSString stringWithFormat:@"starting at %@", stringPrice];
    }else{
        segmentItem = [self.fetchedResultsController objectAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
        NSString *stringPrice = [self.numberFormatter stringFromNumber:segmentItem.price];
        id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
        sectionTitle = [NSString stringWithFormat:@"%@ starting at %@", [sectionInfo name], stringPrice];
    }
    
    return sectionTitle;
    //[NSString stringWithFormat:@"%@ starting at %@",sectionTitle, stringPrice];
    //[NSString stringWithFormat:@"%@ from %@", segmentItem.outbound.destination, stringPrice];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSegmentCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kSegmentCellIdentifier];
    }
    Segment *segmentItem = nil;
    if ([self.searchController isActive]) {
        segmentItem = [self.filteredList objectAtIndex:indexPath.row];
    }else{
        segmentItem = [self.fetchedResultsController objectAtIndexPath:indexPath];
        //self.sections[indexPath.section][indexPath.row];
    }
    
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@ / %@ - %@",
                           segmentItem.inbound.destination, segmentItem.inbound.origin,
                           segmentItem.outbound.destination, segmentItem.outbound.origin];
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Price : .%.2f", [segmentItem.price doubleValue]];
    return cell;
}

#pragma mark - ComputedProperties
- (UITableView *)tableView{
    return [(FlightsView*)self.view tableView];
}

- (UISearchController *)searchController{
    return [(FlightsView*)self.view searchController];
}


#pragma mark === Fetched Results Controller ===
#pragma mark -

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
        
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"price" ascending:YES];
        [fetchRequest setSortDescriptors:@[sortDescriptor]];
        
        NSFetchedResultsController *frc = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                              managedObjectContext:moc
                                                                                sectionNameKeyPath:@"outbound.destination"
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


- (NSFetchRequest *)searchFetchRequest
{
    if (_searchFetchRequest != nil)
    {
        return _searchFetchRequest;
    }
    
    NSManagedObjectContext *moc = [CoreDataStack mainContext];

    _searchFetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Segment" inManagedObjectContext:moc];
    [_searchFetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"price" ascending:YES];
    [_searchFetchRequest setSortDescriptors:@[sortDescriptor]];
    
    return _searchFetchRequest;
}

#pragma mark == FetchedResultController Delegate ==
#pragma mark -
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView reloadData];
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
