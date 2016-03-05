//
//  BookingFooterView.m
//  DragonRides
//
//  Created by Boris Chirino on 04/03/16.
//  Copyright © 2016 Boris Chirino. All rights reserved.
//

#import "BookingFooterView.h"
#import "MaterialControl.h"

@implementation BookingFooterView

- (instancetype)init
{
    self = [super init];
    if (self) {
        _resumeLabel = [UILabel new];
        _resumeLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [_resumeLabel setTextAlignment:NSTextAlignmentCenter];
        [_resumeLabel setFont:[UIFont boldSystemFontOfSize:30.0]];
       // [_resumeLabel setBackgroundColor:[UIColor blackColor]];
        [_resumeLabel setTextColor:[UIColor blackColor]];
        
        _bookButton = [MaterialControl new];
        _bookButton.translatesAutoresizingMaskIntoConstraints = NO;
        NSDictionary *textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                        [UIFont fontWithName:@"HelveticaNeue-Bold" size:20.3],NSFontAttributeName,
                                        [UIColor whiteColor],NSForegroundColorAttributeName,
                                        nil];
        
        [[UINavigationBar appearance] setTitleTextAttributes:textAttributes];
        
        NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"Book now" attributes:textAttributes];
        [_bookButton setAttributedTitle:attrString forState:UIControlStateNormal];
        [_bookButton setTitle:@"Book now" forState:UIControlStateNormal];
        [_bookButton setBackgroundColor:[UIColor eBlueColor]];
        _bookButton.layer.cornerRadius = 8;
        
        [self addSubview:_resumeLabel];
        [self addSubview:_bookButton];
        [self updateConstraints];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];

    
}
- (void)updateConstraints{
    [super updateConstraints];
    
    NSDictionary *dictionaryView = NSDictionaryOfVariableBindings(_resumeLabel,_bookButton);
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(20)-[_resumeLabel(30)]-[_bookButton(60)]" options:0 metrics:0 views:dictionaryView]];
    
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_resumeLabel]|" options:0 metrics:0 views:dictionaryView]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_bookButton]-|" options:0 metrics:0 views:dictionaryView]];

}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
