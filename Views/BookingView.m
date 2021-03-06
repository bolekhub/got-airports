//
//  BookingView.m
//  DragonRides
//
//  Created by Boris Chirino on 03/03/16.
//  Copyright © 2016 Boris Chirino. All rights reserved.
//

#import "BookingView.h"
#import "BookingViewController.h"

@interface BookingView ()
@property UIImageView *backgroundView ;
@end

@implementation BookingView

- (instancetype)init
{
    self = [super init];
    if (self) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        _tableView.backgroundColor = [UIColor clearColor];

        _tableView.translatesAutoresizingMaskIntoConstraints = NO;
        [_tableView setShowsVerticalScrollIndicator:NO];
        _tableView.allowsSelection = NO;
        _backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background"]];
        _backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
        _backgroundView.contentMode = UIViewContentModeScaleToFill;
        
        self.backgroundColor = [UIColor grayColor];
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
}


- (void)updateConstraints{
    [super updateConstraints];
    
    NSDictionary *dictionaryView = NSDictionaryOfVariableBindings(_tableView, _backgroundView);
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_tableView]|" options:0 metrics:0 views:dictionaryView]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_backgroundView]|" options:0 metrics:0 views:dictionaryView]];

    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_tableView]-|" options:0 metrics:0 views:dictionaryView]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_backgroundView]|" options:0 metrics:0 views:dictionaryView]];

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
