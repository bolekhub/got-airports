//
//  MainView.m
//  DragonRides
//
//  Created by Boris Chirino on 01/03/16.
//  Copyright © 2016 Boris Chirino. All rights reserved.
//

#import "MainView.h"
@class MainViewController;
@implementation MainView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor blueColor];
        _welcomeMessage = [UILabel new];
        [_welcomeMessage setText:@"Hola mundo"];
        _welcomeMessage.translatesAutoresizingMaskIntoConstraints = NO;
        [_welcomeMessage setFont:[UIFont systemFontOfSize:22.0]];
        [_welcomeMessage setTextColor:[UIColor whiteColor]];
        [_welcomeMessage setTextAlignment:NSTextAlignmentCenter];
        
        _userSettingButton = [UIButton new];
        [_userSettingButton setTitle:@"Settings" forState:UIControlStateNormal];
        [_userSettingButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [_userSettingButton.titleLabel setFont:[UIFont systemFontOfSize:18.0]];
        [_userSettingButton.titleLabel setTextColor:[UIColor blackColor]];
        _userSettingButton.backgroundColor = [UIColor grayColor];
        _userSettingButton.translatesAutoresizingMaskIntoConstraints = NO;

        _searchRidesButton = [UIButton new];
        [_searchRidesButton setTitle:@"Search rides" forState:UIControlStateNormal];
        [_searchRidesButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [_searchRidesButton.titleLabel setFont:[UIFont systemFontOfSize:18.0]];
        [_searchRidesButton.titleLabel setTextColor:[UIColor blackColor]];
        _searchRidesButton.backgroundColor = [UIColor grayColor];
        _searchRidesButton.translatesAutoresizingMaskIntoConstraints = NO;
        
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
    NSDictionary *dictionaryView = NSDictionaryOfVariableBindings(_userSettingButton, _superview, _searchRidesButton, _welcomeMessage);
    
    
    
    NSArray *welcomeMessage_V = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(70)-[_welcomeMessage]" options:0 metrics:nil views:dictionaryView];
    
    //WELCOME LABEL
    NSArray *welcomeMessage_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_welcomeMessage]-|" options:0 metrics:nil views:dictionaryView];
    
    // USER SETTING BUTTON
    NSLayoutConstraint *serSetting_V = [NSLayoutConstraint constraintWithItem:self
                                                                           attribute:NSLayoutAttributeCenterY
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:_userSettingButton
                                                                           attribute:NSLayoutAttributeCenterY
                                                                          multiplier:1.0  constant:0.0];
    
    NSArray *userSetting_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_userSettingButton]-|" options:0 metrics:nil views:dictionaryView];
    
    
    //SEARCH RIDES BUTTON
    
    NSArray *searchRide_V = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[_searchRidesButton]-[_userSettingButton]" options:0 metrics:nil views:dictionaryView];
    
   NSArray *searchRide_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_searchRidesButton]-|" options:0 metrics:nil views:dictionaryView];
    
    
    // PROGRESS VIEW
    NSLayoutConstraint *centerXProgressView = [NSLayoutConstraint constraintWithItem:self
                                                               attribute:NSLayoutAttributeCenterX
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:_progressView
                                                               attribute:NSLayoutAttributeCenterX
                                                              multiplier:1.0  constant:0.0];
    
    NSLayoutConstraint *centerYProgressView = [NSLayoutConstraint constraintWithItem:self
                                                               attribute:NSLayoutAttributeCenterY
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:_progressView
                                                               attribute:NSLayoutAttributeCenterY
                                                              multiplier:1.0  constant:0.0];
    
    [self addConstraints:@[centerXProgressView, centerYProgressView, serSetting_V]];
    [self addConstraints:userSetting_H];
    [self addConstraints:searchRide_V];
    [self addConstraints:searchRide_H];
    
    [self addConstraints:welcomeMessage_H];
    [self addConstraints:welcomeMessage_V];

    //[self addConstraints:array2];


    
//    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_progressView]" options:0 metrics:nil views:dictionaryView]];
//    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_progressView]" options:0 metrics:nil views:dictionaryView]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
