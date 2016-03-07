//
//  DragonAnimation.h
//  DragonRides
//
//  Created by Boris Chirino on 05/03/16.
//  Copyright © 2016 Boris Chirino. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DragonAnimation : UIImageView

/**
 *  add UIImageView containing animation images to specifyied view. This class method call the singleton (not exposed) and then the instance method
 *  with the same name as this. This code is more friendly and easy to use. The imageview is created only 1 time during all app life cycle.
 *
 *  @param view view to add animation
 */
+(void)showInView:(UIView*)view;


/**
 *  Stop animations, hide UIimageView, and remove from superview
 */
+(void)hideDragon;

@end
