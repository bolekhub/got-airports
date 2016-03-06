//
//  FlightsViewController.h
//  DragonRides
//
//  Created by Boris Chirino on 02/03/16.
//  Copyright © 2016 Boris Chirino. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonViewController.h"

@interface FlightsViewController : CommonViewController<UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating, UISearchBarDelegate, UISearchControllerDelegate>
@property (nonatomic) BOOL userSettings;
@end
