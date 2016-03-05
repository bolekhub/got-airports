//
//  WarriorDataView.m
//  DragonRides
//
//  Created by Boris Chirino on 02/03/16.
//  Copyright © 2016 Boris Chirino. All rights reserved.
//

#import "WarriorDataView.h"
#import "WarriorDataViewController.h"

NSString *kPickerChangeNotification = @"PICKER_CHANGE";


@interface WarriorDataView () <UIPickerViewDataSource, UIPickerViewDelegate>
@property UILabel *dateOfBirthLabel;
@property UILabel *currencyLabel;
@property UIImageView *backgroundView ;


@end

@implementation WarriorDataView

- (instancetype)init
{
    self = [super init];
    if (self) {
    
        
        _currencies = [NSArray arrayWithObjects: @"GBP", @"USD", @"EUR", @"JPY", nil];
        self.backgroundColor = [UIColor grayColor];
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.translatesAutoresizingMaskIntoConstraints = NO;
        _tableView.backgroundColor = [UIColor clearColor];

        
        _backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background"]];
        _backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
        _backgroundView.contentMode = UIViewContentModeScaleToFill;
        
        _dobPicker = [UIDatePicker new];
        _dobPicker.translatesAutoresizingMaskIntoConstraints = NO;
        _dobPicker.datePickerMode = UIDatePickerModeDate;
        
        _currencyPicker = [UIPickerView new];
        _currencyPicker.translatesAutoresizingMaskIntoConstraints = NO;
        _currencyPicker.dataSource = self;
        _currencyPicker.delegate = self;

//        
        [self addSubview:_tableView];
        [self insertSubview:_backgroundView belowSubview:_tableView];

        [self updateConstraints];
    }
    return self;
}



- (void)updateConstraints{
    [super updateConstraints];
    
    NSDictionary *dictionaryView = NSDictionaryOfVariableBindings( _tableView, _backgroundView);
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_backgroundView]|" options:0 metrics:0 views:dictionaryView]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_backgroundView]|" options:0 metrics:0 views:dictionaryView]];

    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_tableView]|" options:0 metrics:0 views:dictionaryView]];

    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_tableView]-|" options:0 metrics:0 views:dictionaryView]];
    

}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.tableView.delegate = self.controller;
    self.tableView.dataSource = self.controller;
}



#pragma mark - PickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [self.currencies count];
}

#pragma mark - PickerViewDelegate
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.currencies[row];
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    [[NSNotificationCenter defaultCenter] postNotificationName:kPickerChangeNotification object:self.currencies[row]];
    self.selectedCurrency = self.currencies[row];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
