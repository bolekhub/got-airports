//
//  MaterialControl.m
//  DragonRides
//
//  Created by Boris Chirino on 05/03/16.
//  Copyright © 2016 Boris Chirino. All rights reserved.
//

#import "MaterialControl.h"



@implementation MaterialControl

- (void)sendAction:(SEL)action to:(nullable id)target forEvent:(nullable UIEvent *)event{
    [UIView animateWithDuration:0.2 delay:0 usingSpringWithDamping:0.17 initialSpringVelocity:0.58 options:UIViewAnimationOptionTransitionNone animations:^{
        //self.backgroundColor = [UIColor whiteColor];
        
        self.layer.shadowColor = [UIColor grayColor].CGColor;
        self.layer.shadowRadius = 10.0f;
        self.layer.shadowOpacity = 1.0f;
        self.layer.shadowOffset = CGSizeZero;
        self.transform = CGAffineTransformMakeScale(0.9, 0.9);


    } completion:^(BOOL finished) {
        self.layer.shadowColor = [UIColor clearColor].CGColor;
        self.layer.shadowRadius = 0.0f;
        self.layer.shadowOpacity = 1.0f;
        self.layer.shadowOffset = CGSizeZero;
        self.transform = CGAffineTransformMakeScale(1.0, 1.0);
    }];
}



@end
