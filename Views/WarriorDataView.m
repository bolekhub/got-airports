//
//  WarriorDataView.m
//  DragonRides
//
//  Created by Boris Chirino on 02/03/16.
//  Copyright © 2016 Boris Chirino. All rights reserved.
//

#import "WarriorDataView.h"

@interface WarriorDataView () <UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate>
@property UILabel *dateOfBirthLabel;

@end

@implementation WarriorDataView

- (instancetype)init
{
    self = [super init];
    if (self) {
    
        
        _currencies = [NSArray arrayWithObjects: @"GBP", @"USD", @"EUR", @"YJP", nil];
        self.backgroundColor = [UIColor grayColor];
        
        _scrollView = [UIScrollView new];
        _scrollView.translatesAutoresizingMaskIntoConstraints = NO;
        _scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _scrollView.layer.borderColor = [UIColor redColor].CGColor;
        _scrollView.layer.borderWidth = 1.0f;
        
        
        _dateOfBirthLabel = [UILabel new];
        [_dateOfBirthLabel setText:@"Date Of birth"];
        _dateOfBirthLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [_dateOfBirthLabel setFont:[UIFont systemFontOfSize:22.0]];
        [_dateOfBirthLabel setTextColor:[UIColor whiteColor]];
        [_dateOfBirthLabel setTextAlignment:NSTextAlignmentCenter];
        
        _nameTextField = [UITextField new];
        _nameTextField.layer.borderColor = [UIColor redColor].CGColor;
        _nameTextField.layer.borderWidth = 1.0f;
        _nameTextField.userInteractionEnabled = YES;

        _nameTextField.layer.cornerRadius = 10.0f;
        _nameTextField.delegate = self;
        _nameTextField.layer.borderColor = [UIColor blackColor].CGColor;
        _nameTextField.layer.borderWidth = 1.5f;
        _nameTextField.translatesAutoresizingMaskIntoConstraints = NO;
        _nameTextField.placeholder = @"Warrior name";
        [_nameTextField setFont:[UIFont systemFontOfSize:22.0]];
        [_nameTextField setTextColor:[UIColor whiteColor]];
        [_nameTextField setTextAlignment:NSTextAlignmentCenter];
        
        _surNameTextField = [UITextField new];
        _surNameTextField.layer.cornerRadius = 10.0f;
        _surNameTextField.layer.borderColor = [UIColor blackColor].CGColor;
        _surNameTextField.layer.borderWidth = 1.5f;
        _surNameTextField.translatesAutoresizingMaskIntoConstraints = NO;
        _surNameTextField.placeholder = @"Surname";
        [_surNameTextField setFont:[UIFont systemFontOfSize:22.0]];
        [_surNameTextField setTextColor:[UIColor whiteColor]];
        [_surNameTextField setTextAlignment:NSTextAlignmentCenter];
        
        _dobPicker = [UIDatePicker new];
        _dobPicker.translatesAutoresizingMaskIntoConstraints = NO;
        _dobPicker.datePickerMode = UIDatePickerModeDate;
        
        _currencyPicker = [UIPickerView new];
        _currencyPicker.translatesAutoresizingMaskIntoConstraints = NO;
        _currencyPicker.dataSource = self;
        _currencyPicker.delegate = self;

        
        [self addSubview:_scrollView];


        // was contentView
        [_scrollView addSubview:_nameTextField];
        [_scrollView addSubview:_surNameTextField];
        [_scrollView addSubview:_dobPicker];
        [_scrollView addSubview:_dateOfBirthLabel];
        [_scrollView addSubview:_currencyPicker];
        
        // [_scrollView addSubview:_contentView];


//        [self addSubview:_nameTextField];
//        [self addSubview:_surNameTextField];
//        [self addSubview:_dobPicker];
//        [self addSubview:_dateOfBirthLabel];
//        [self addSubview:_currencyPicker];
//
        [self updateConstraints];
    }
    return self;
}



- (void)updateConstraints{
    [super updateConstraints];
    
    UIView *_superview = self;
    NSDictionary *dictionaryView = NSDictionaryOfVariableBindings(_nameTextField, _surNameTextField, _dobPicker, _dateOfBirthLabel, _currencyPicker, _scrollView,_superview);
    

    NSArray *nameTextField_V = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_nameTextField]-(40)-[_surNameTextField]-[_dateOfBirthLabel]-[_dobPicker]-[_currencyPicker]" options:0 metrics:nil views:dictionaryView];
    
    NSArray *nameTextField_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_nameTextField]-|" options:0 metrics:nil views:dictionaryView];
    
    NSArray *datePicker_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_dobPicker]-|" options:0 metrics:nil views:dictionaryView];
    
    NSArray *dateOfBirthLabel_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_dateOfBirthLabel]-|" options:0 metrics:nil views:dictionaryView];
    
    NSArray *currencyPicker_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_currencyPicker]-|" options:0 metrics:nil views:dictionaryView];
    
    // SURNAME TEXTFIELD
    NSArray *surNameTextField_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_surNameTextField]-|" options:0 metrics:nil views:dictionaryView];
    
    
    
    //[self addConstraint:scroll_V];
    //[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_scrollView]-|" options:0 metrics:0 views:dictionaryView]];
    
    
    
   // [_scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_contentView]|" options:0 metrics:0 views:dictionaryView]];
    //[_scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_contentView]|" options:0 metrics:0 views:dictionaryView]];

    
    //_contentView
    [_scrollView addConstraints:nameTextField_H];
    [_scrollView addConstraints:nameTextField_V];
    [_scrollView addConstraints:surNameTextField_H];
    [_scrollView addConstraints:datePicker_H];
    [_scrollView addConstraints:currencyPicker_H];
    [_scrollView addConstraints:dateOfBirthLabel_H];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_scrollView]|" options:0 metrics:0 views:dictionaryView]];

    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_scrollView]-|" options:0 metrics:0 views:dictionaryView]];
    

}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.scrollView.contentInset = UIEdgeInsetsMake(84, 0, 0, 0);
    self.scrollView.contentSize = CGSizeMake(self.bounds.size.width, self.frame.origin.y + self.frame.size.height + 100);
    
    //self.scrollView.contentSize = self.bounds.size;
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

#pragma mark - UITextfieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    [[NSNotificationCenter defaultCenter] postNotificationName:kTxtFieldNotification object:textField];
    return YES;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
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
