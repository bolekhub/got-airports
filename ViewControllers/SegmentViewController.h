//
//  SegmentViewController.h
//  DragonRides
//
//  Created by Boris Chirino on 03/03/16.
//  Copyright © 2016 Boris Chirino. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonViewController.h"

static NSString *kSegmentCellIdentifier = @"segmentCell";


@class Segment;
@interface SegmentViewController : CommonViewController<UITableViewDataSource, UITableViewDelegate>
@property  Segment *selectedSegment;


@end
