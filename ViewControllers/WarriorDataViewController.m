//
//  WarriorDataViewController.m
//  DragonRides
//
//  Created by Boris Chirino on 02/03/16.
//  Copyright © 2016 Boris Chirino. All rights reserved.
//

#import "WarriorDataViewController.h"
#import "WarriorDataView.h"
#import "CoreDataStack.h"
#import "AppDelegate.h"
#import "Warrior.h"
#import "WebService.h"
#import "TextFieldTableViewCell.h"
#import "FlightsViewController.h"

static NSString *kNameTextFieldIdentifier    = @"nameCellIdentifier";
static NSString *kSurnameTextFieldIdentifier = @"surNameCellIdentifier";
static NSString *kDobTextFieldIdentifier     = @"dobCellIdentifier";
static NSString *kCurrencyFieldIdentifier    = @"currencyCellIdentifier";
static NSString *kTripsFieldIdentifier       = @"tripsCellIdentifier";

NSString *kExchangeRateValue = @"EXCHANGE_RATE_VALUE";

@interface WarriorDataViewController ()<UITextFieldDelegate>
@property (nonatomic) WarriorDataView *dataView;
@property (nonatomic) UITableView *tableView;
@property (nonatomic) UIToolbar *keyboardToolBar;
@property (nonatomic) NSDateFormatter *dateFormatter;
@end

@implementation WarriorDataViewController


#pragma mark - ViewLifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:NO];
    
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(closeController:)]];
    
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveData:)]];

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.dataView.dobPicker addTarget:self action:@selector(datePickerFinishedRotation:) forControlEvents:UIControlEventValueChanged];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadView{
    self.view = [WarriorDataView new];
    self.dataView.controller = self;
}


#pragma mark - TableView Datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
   return @"Account details";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = nil;
    
    
    switch (indexPath.row) {
        case 0:{
            cell = [self.tableView dequeueReusableCellWithIdentifier:kNameTextFieldIdentifier];
            if (cell == nil) {
                cell = (TextFieldTableViewCell*)[[TextFieldTableViewCell alloc]
                                                 initWithText:self.warrior.name
                                                 textFieldTag:TAGIDENTIFIER_NAMETXTFIELD
                                              reuseIdentifier:kNameTextFieldIdentifier];
                [(TextFieldTableViewCell*)cell textField].placeholder = @"Name";
            }
        }
            break;
        case 1:{
            cell = [self.tableView dequeueReusableCellWithIdentifier:kSurnameTextFieldIdentifier];
            if (cell == nil) {
                cell = (TextFieldTableViewCell*)[[TextFieldTableViewCell alloc]
                                                 initWithText:self.warrior.surname
                                                 textFieldTag:TAGIDENTIFIER_SURNAMETXTFIELD
                                              reuseIdentifier:kSurnameTextFieldIdentifier];
                [(TextFieldTableViewCell*)cell textField].placeholder = @"Surname";
            }
        }
            break;
        case 2:{
            cell = [self.tableView dequeueReusableCellWithIdentifier:kDobTextFieldIdentifier];
            if (cell == nil) {
                NSDate *dob = self.warrior.dob;
                NSString *dateString = [self.dateFormatter stringFromDate:dob];

                cell = (TextFieldTableViewCell*)[[TextFieldTableViewCell alloc]
                                                 initWithText:dateString
                                                 textFieldTag:TAGIDENTIFIER_DOBTXTFIELD
                                              reuseIdentifier:kDobTextFieldIdentifier];
                [(TextFieldTableViewCell*)cell textField].placeholder = @"Date of birth";
                [(TextFieldTableViewCell*)cell textField].delegate = self;
            }
        }
            break;
        case 3:{
            cell = [self.tableView dequeueReusableCellWithIdentifier:kCurrencyFieldIdentifier];
            if (cell == nil) {
                cell = (TextFieldTableViewCell*)[[TextFieldTableViewCell alloc]
                                                 initWithText:self.warrior.currency
                                                 textFieldTag:TAGIDENTIFIER_CURRENCYTXTFIELD
                                                 reuseIdentifier:kCurrencyFieldIdentifier];
                [(TextFieldTableViewCell*)cell textField].placeholder = @"Currency";
                [(TextFieldTableViewCell*)cell textField].delegate = self;
            }
        }
            break;
        case 4:{
            cell = [self.tableView dequeueReusableCellWithIdentifier:kTripsFieldIdentifier];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kTripsFieldIdentifier];
                cell.textLabel.text = @"Previous trips";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
        }
            break;

        default:
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 4) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        FlightsViewController *vc = [FlightsViewController new];
        vc.userSettings = YES;
        [self.navigationController pushViewController:vc
                                             animated:YES];
    }
}


#pragma mark UIActions
- (void)datePickerFinishedRotation:(id)sender{
    NSDate *selectedDate = [(UIDatePicker*)sender date];
    TextFieldTableViewCell *dobCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    [dobCell.textField setText:[self.dateFormatter stringFromDate:selectedDate]];

}

-(void)closeController:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)dismissKeyboard:(id)sender{
    NSArray *cells = [self.tableView visibleCells];
    for (UITableViewCell *view in cells) {
        for (UIView *item in [[view contentView] subviews]) {
            if ([item isKindOfClass:[UITextField class]]) {
                [item performSelector:@selector(resignFirstResponder)];
                break;
            }
        }
    }
}

- (void) dismissController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)saveData:(id)sender{
    [DragonAnimation showInView:self.view];
    TextFieldTableViewCell *nameCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    TextFieldTableViewCell *surNameCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    
    TextFieldTableViewCell *dobCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    
    TextFieldTableViewCell *currencyCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    
    
    if (nameCell.textField.text.length == 0 || surNameCell.textField.text.length == 0 || dobCell.textField.text == 0 || currencyCell.textField.text.length== 0) {
        
        nameCell.textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"error" attributes:@{NSForegroundColorAttributeName: [UIColor redColor]}];

        
        //NSIndexPath *ip = [self.tableView indexPathForCell:nameCell];
        //nameCell.layer.borderColor = [UIColor redColor].CGColor;
        //[nameCell setNeedsDisplay];
        //[nameCell setNeedsLayout];
        //[self.tableView reloadRowsAtIndexPaths:@[ip] withRowAnimation:UITableViewRowAnimationAutomatic];
        return;
    }

    __weak typeof(self) weakSelf = self;
    __block Warrior *newObject = nil;

    if (!self.warrior) {
        [CoreDataStack saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
            newObject = [NSEntityDescription insertNewObjectForEntityForName:@"Warrior" inManagedObjectContext:localContext];
            newObject.name = nameCell.textField.text;
            newObject.surname = surNameCell.textField.text;

            NSDate *date = [self.dateFormatter dateFromString:dobCell.textField.text];
            newObject.dob = date;
            newObject.currency = currencyCell.textField.text;
            
            //newObjectCopy = [newObject copy];
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf dismissViewControllerAnimated:YES completion:nil];
            });
        }];
        
        [[WebService shared] getExchangeRateFromCurrency:@"EUR" toCurrency:currencyCell.textField.text completion:^(NSNumber *rate, NSError *error) {
            if (error == nil) {
                [[NSUserDefaults standardUserDefaults] setObject:rate forKey:kExchangeRateValue];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [DragonAnimation hideDragon];
                    [weakSelf.delegate controller:self didSaveWarrior:newObject];
                });
            }
        }];

        
    }else{
        
        if (![self.warrior.currency isEqualToString:currencyCell.textField.text]) {
            [[WebService shared] getExchangeRateFromCurrency:@"EUR" toCurrency:currencyCell.textField.text completion:^(NSNumber *rate, NSError *error) {
                if (error == nil) {
                    [[NSUserDefaults standardUserDefaults] setObject:rate forKey:kExchangeRateValue];
                }
            }];
        }
        
        [CoreDataStack saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
            self.warrior.name = nameCell.textField.text;
            self.warrior.surname = surNameCell.textField.text;

            NSDate *date = [self.dateFormatter dateFromString:dobCell.textField.text];
            self.warrior.dob = date;
            self.warrior.currency = currencyCell.textField.text;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [DragonAnimation hideDragon];
                [self dismissViewControllerAnimated:YES completion:nil];
                [weakSelf.delegate controller:self didSaveWarrior:newObject];
            });
            
        }];
   }
}

#pragma mark - TextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField.tag == TAGIDENTIFIER_DOBTXTFIELD)
    {
        if (self.warrior)
        {
            self.dataView.dobPicker.date = self.warrior.dob;
        }
        [textField setInputView:self.dataView.dobPicker];
        [textField setInputAccessoryView:self.keyboardToolBar];
    }
    else if (textField.tag == TAGIDENTIFIER_CURRENCYTXTFIELD)
    {
        if (self.warrior)
        {
            NSUInteger currencyIndex = [self.dataView.currencies indexOfObject:self.warrior.currency];
            self.dataView.selectedCurrency = self.dataView.currencies[currencyIndex];
            [self.dataView.currencyPicker selectRow:currencyIndex inComponent:0 animated:YES];
        }
        [textField setInputView:self.dataView.currencyPicker];
        [textField setInputAccessoryView:self.keyboardToolBar];
    }
    return YES;
}

#pragma mark - ComputedProperties
- (UITableView *)tableView{
    return [(WarriorDataView*)self.view tableView];
}

- (WarriorDataView*)dataView{
    return (WarriorDataView*)self.view;
}

- (UIToolbar *)keyboardToolBar {
    if (!_keyboardToolBar) {
        _keyboardToolBar = [[UIToolbar alloc] init];
        [_keyboardToolBar sizeToFit];
        UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem *closeButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissKeyboard:)];
        
        [_keyboardToolBar setItems:@[flexSpace, closeButton]];

    }
    return _keyboardToolBar;
}

- (NSDateFormatter *)dateFormatter{
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateStyle:NSDateFormatterLongStyle];
    }
    return _dateFormatter;
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
