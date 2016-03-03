//
//  SegmentViewController.h
//  DragonRides
//
//  Created by Boris Chirino on 03/03/16.
//  Copyright © 2016 Boris Chirino. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *kSegmentCellIdentifier = @"segmentCell";


@class Segment;
@interface SegmentViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property  Segment *selectedSegment;
@end
