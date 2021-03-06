//
//  FlightsView.m
//  DragonRides
//
//  Created by Boris Chirino on 02/03/16.
//  Copyright © 2016 Boris Chirino. All rights reserved.
//

#import "FlightsView.h"
#import "FlightsViewController.h"

@interface FlightsView ()
@property UIImageView *backgroundView ;
@end

@implementation FlightsView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor greenColor];
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.translatesAutoresizingMaskIntoConstraints = NO;
        
        _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
        _searchController.dimsBackgroundDuringPresentation = NO;
        
        _backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background"]];
        _backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
        _backgroundView.contentMode = UIViewContentModeScaleToFill;
        
        [self addSubview:_tableView];
        [self insertSubview:_backgroundView belowSubview:_tableView];
        [self updateConstraints];

    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.tableView.dataSource = self.controller;
    self.tableView.delegate = self.controller;
    if (!self.controller.userSettings) {
        self.searchController.searchResultsUpdater = self.controller;
        self.searchController.delegate = self.controller;
        self.searchController.searchBar.delegate = self.controller;
        self.tableView.tableHeaderView = self.searchController.searchBar;

    }
}


- (void)updateConstraints{
    [super updateConstraints];
    
    NSDictionary *dictionaryView = NSDictionaryOfVariableBindings(_tableView, _backgroundView);
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_tableView]|" options:0 metrics:0 views:dictionaryView]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_backgroundView]|" options:0 metrics:0 views:dictionaryView]];

    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_tableView]|" options:0 metrics:0 views:dictionaryView]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_backgroundView]|" options:0 metrics:0 views:dictionaryView]];

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
