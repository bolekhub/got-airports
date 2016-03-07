//
//  TextFieldTableViewCell.m
//  DragonRides
//
//  Created by Boris Chirino on 04/03/16.
//  Copyright © 2016 Boris Chirino. All rights reserved.
//

#import "TextFieldTableViewCell.h"

@interface TextFieldTableViewCell ()
@property TAGIDENTIFIER textFieldTag;
@end

@implementation TextFieldTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithText:(NSString*)text textFieldTag:(TAGIDENTIFIER)tag reuseIdentifier:(NSString*)reuseIdentifier {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        _textField = [UITextField new];
        _textField.tag = tag;
        _textField.translatesAutoresizingMaskIntoConstraints = NO;
        _textField.text = text;
        _textFieldTag = tag;
        
        [self.contentView addSubview:_textField];
        [self updateConstraints];
        
        //this is aon observer listen to pickerview containing currencies
        //fired from WarriorDataView UIPickerView Delegates
        __weak typeof(self) weakSelf = self;
        [[NSNotificationCenter defaultCenter] addObserverForName:kPickerChangeNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
                if (weakSelf.textFieldTag == TAGIDENTIFIER_CURRENCYTXTFIELD) {
                    weakSelf.textField.text = note.object;
                }
        }];

        
    }
    return self;
}

- (void)updateConstraints{
    [super updateConstraints];
    NSDictionary *dictionaryView = NSDictionaryOfVariableBindings(_textField);

    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_textField]-|" options:0 metrics:0 views:dictionaryView]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_textField]|" options:0 metrics:0 views:dictionaryView]];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
