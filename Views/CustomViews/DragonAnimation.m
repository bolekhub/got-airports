//
//  DragonAnimation.m
//  DragonRides
//
//  Created by Boris Chirino on 05/03/16.
//  Copyright © 2016 Boris Chirino. All rights reserved.
//

#import "DragonAnimation.h"

static const DragonAnimation *_instance  = nil;


@implementation DragonAnimation
+(id)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

+(void)showInView:(UIView*)view{
    [[self sharedInstance] showInView:view];
}

-(void)showInView:(UIView*)view{
    self.center = view.center;
    [view addSubview:self];
    [self startAnimating];
}

+(void)hideDragon{
    [[self sharedInstance] stopAnimating];
    [[self sharedInstance] removeFromSuperview];
}

- (instancetype)init{
    self = [super initWithFrame:CGRectMake(0, 0, 150, 150)];
    if (self) {
        NSMutableArray *images = [[NSMutableArray alloc] initWithCapacity:0];
        for (int i = 0; i<10; i++) {
            NSString *filename = [NSString stringWithFormat:@"frame_%i_delay-0.1s",i]; //frame_0_delay-0.1s
            UIImage *image = [UIImage imageNamed:filename];
            [images addObject:image];
        }
        self.animationDuration = 1;
        self.animationImages = images;
        //self.animationImages
    }
    return self;
}

@end
