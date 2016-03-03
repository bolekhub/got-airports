//
//  SegmentView.h
//  DragonRides
//
//  Created by Boris Chirino on 03/03/16.
//  Copyright © 2016 Boris Chirino. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SegmentViewController;
@interface SegmentView : UIView
@property UITableView *tableView;
@property (nonatomic, weak) SegmentViewController *controller;

@end
