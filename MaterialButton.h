//
//  MaterialControl.h
//  DragonRides
//
//  Created by Boris Chirino on 05/03/16.
//  Copyright © 2016 Boris Chirino. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MaterialButton : UIButton

/**
 *  Create a UIButton object styled blue with rounded corners and has an animation when tapped.
 *
 *  @param title caption of the button
 *
 *  @return MaterialButton instance
 */
-(instancetype)initWithTitle:(NSString*)title;
@end
