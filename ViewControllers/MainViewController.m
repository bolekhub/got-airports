//
//  MainViewController.m
//  DragonRides
//
//  Created by Boris Chirino on 01/03/16.
//  Copyright © 2016 Boris Chirino. All rights reserved.
//

#import "MainViewController.h"
#import "WebService.h"
#import "Segment.h"
#import "MainView.h"
#import "AppDelegate.h"
#import "Warrior.h"
#import "WarriorDataViewController.h"
#import "FlightsViewController.h"
#import "CoreDataStack.h"

@interface MainViewController ()
@property NSMutableArray *flights;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _flights = [[NSMutableArray alloc] initWithCapacity:0];
    [self.navigationController setNavigationBarHidden:YES];
    
    NSManagedObjectContext *context = [(AppDelegate*)[UIApplication sharedApplication].delegate managedObjectContext];
    Warrior *p = [CoreDataStack getWarriorInContext:context];
    if (p) {
        MainView *mainView =  (MainView*)self.view;
        mainView.welcomeMessage.text = [NSString stringWithFormat:@"Welcomeback %@ %@",p.name, p.surname];
    }

    
    // Do any additional setup after loading the view.
   [self loadData];
}


-(void)loadView{
    self.view = [MainView new];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadData{
    __weak typeof(self) weakSelf = self;
    [[(MainView*)self.view progressView] startAnimating];

    [[WebService shared] getDragonFlightsWithPredicate:nil completion:^(NSArray *response, NSError *error) {
        for (NSDictionary *segmentItem in response) {
            Segment *segment = [Segment new];
            segment.currency = segmentItem[@"currency"];
            double p = [segmentItem[@"price"] doubleValue];
            segment.price = [NSNumber numberWithDouble:p];
            segment.outbound = [[FlightDetails alloc] initWithDictionary:segmentItem[@"outbound"]];
            segment.inbound = [[FlightDetails alloc] initWithDictionary:segmentItem[@"inbound"]];
            [weakSelf.flights addObject:segment];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"finished loading and parsing");
            [[(MainView*)self.view progressView] stopAnimating];
        });
    }];
}

#pragma mark - private methods


#pragma mark - UIACTIONS

-(void)openSettings:(id)sender {
    WarriorDataViewController *vc = [WarriorDataViewController new];
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
    
    NSManagedObjectContext *context = [(AppDelegate*)[UIApplication sharedApplication].delegate managedObjectContext];
    Warrior *currentWarrior = [CoreDataStack getWarriorInContext:context];
    vc.warrior = currentWarrior;
    [self presentViewController:nc animated:YES completion:nil];
}

-(void)searchRides:(id)sender {
    FlightsViewController *vc = [FlightsViewController new];

    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
    vc.availableFlights = self.flights;
    [self presentViewController:nc animated:YES completion:nil];
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
