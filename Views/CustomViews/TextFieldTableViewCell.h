//
//  TextFieldTableViewCell.h
//  DragonRides
//
//  Created by Boris Chirino on 04/03/16.
//  Copyright © 2016 Boris Chirino. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextFieldTableViewCell : UITableViewCell
@property  UITextField *textField;

- (instancetype)initWithText:(NSString*)text textFieldTag:(TAGIDENTIFIER)tag reuseIdentifier:(NSString*)reuseIdentifier ;

@end
