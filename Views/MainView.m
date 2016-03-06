//
//  MainView.m
//  DragonRides
//
//  Created by Boris Chirino on 01/03/16.
//  Copyright © 2016 Boris Chirino. All rights reserved.
//

#import "MainView.h"

@interface MainView ()
@property UIImageView *backgroundView ;
@end

@class MainViewController;
@implementation MainView

- (instancetype)init
{
    self = [super init];
    if (self) {
        _backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iron"]];
        _backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
        _backgroundView.contentMode = UIViewContentModeScaleToFill;
        
        _welcomeMessage = [UILabel new];
        [_welcomeMessage setText:NSLocalizedString(@"Hello warrior", nil)];
        [_welcomeMessage setNumberOfLines:2];
        _welcomeMessage.lineBreakMode = NSLineBreakByWordWrapping;
        _welcomeMessage.translatesAutoresizingMaskIntoConstraints = NO;
        [_welcomeMessage setFont:[UIFont systemFontOfSize:22.0]];
        [_welcomeMessage setTextColor:[UIColor whiteColor]];
        [_welcomeMessage setTextAlignment:NSTextAlignmentCenter];
        
        _userSettingButton = [[MaterialButton alloc] initWithTitle:NSLocalizedString(@"Settings", nil)];

        _searchRidesButton = [[MaterialButton alloc] initWithTitle:NSLocalizedString(@"Search rides", nil)];
        
        // target nil will forward message to responder chain till the specified method signatured is found
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        [_userSettingButton addTarget:nil action:@selector(openSettings:) forControlEvents:UIControlEventTouchUpInside];
        [_searchRidesButton addTarget:nil action:@selector(searchRides:) forControlEvents:UIControlEventTouchUpInside];
#pragma clang diagnostic pop
        
        _progressView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        //_progressView.backgroundColor = [UIColor blackColor];
        _progressView.hidesWhenStopped = YES;
        _progressView.translatesAutoresizingMaskIntoConstraints = NO;

        
        [self addSubview:_backgroundView];
        [self addSubview:_progressView];
        [self addSubview:_userSettingButton];
        [self addSubview:_searchRidesButton];
        [self addSubview:_welcomeMessage];
        [self updateConstraints];
    }
    return self;
}

- (void)updateConstraints{
    [super updateConstraints];
    UIView *_superview = self;
    
    NSDictionary *dictionaryView = NSDictionaryOfVariableBindings(_userSettingButton, _backgroundView, _superview, _searchRidesButton, _welcomeMessage);
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_backgroundView]|" options:0 metrics:0 views:dictionaryView]];

    
    NSArray *welcomeLabel= [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(<=70)-[_welcomeMessage(60)]" options:0 metrics:nil views:dictionaryView];
    
        NSArray *buttons= [NSLayoutConstraint constraintsWithVisualFormat:@"V:[_searchRidesButton(50)]-(40)-[_userSettingButton(50)]-(80)-|" options:0 metrics:nil views:dictionaryView];

    NSArray *welcomeMessage_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_welcomeMessage]-|" options:0 metrics:nil views:dictionaryView];
    
    NSArray *userSetting_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_userSettingButton]-|" options:0 metrics:nil views:dictionaryView];

    NSArray *searchRide_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_searchRidesButton]-|" options:0 metrics:nil views:dictionaryView];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_backgroundView]|" options:0 metrics:0 views:dictionaryView]];

    
    [self addConstraints:userSetting_H];
    [self addConstraints:welcomeLabel];
    [self addConstraints:buttons];
    [self addConstraints:searchRide_H];
    
    [self addConstraints:welcomeMessage_H];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
