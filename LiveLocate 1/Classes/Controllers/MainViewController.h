//
//  MainViewController.h
//  LiveLocate 1
//
//  Created by amornchai kanokpullwad on 6/9/13.
//  Copyright (c) 2013 LiveLocate. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
