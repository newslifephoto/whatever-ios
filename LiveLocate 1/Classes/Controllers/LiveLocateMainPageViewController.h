//
//  LiveLocateMainPageViewController.h
//  LiveLocate 1
//
//  Created by x5mobile on 4/23/56 BE.
//  Copyright (c) 2556 LiveLocate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ControllerInterface.h"

@interface LiveLocateMainPageViewController : ControllerInterface <UITableViewDataSource,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *upcommingTableView;
@property (weak, nonatomic) IBOutlet UITableView *coverTableView;

@end
