//
//  MainViewController.m
//  LiveLocate 1
//
//  Created by amornchai kanokpullwad on 6/9/13.
//  Copyright (c) 2013 LiveLocate. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView DataSource & Delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    } else {
        return 10;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return self.view.bounds.size.height;
    } else {
        return 80;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"MenuCell"];
        [cell viewWithTag:1].layer.cornerRadius = 60;
        [cell viewWithTag:2].layer.cornerRadius = 60;
        [cell viewWithTag:3].layer.cornerRadius = 60;
        [cell viewWithTag:4].layer.cornerRadius = 60;
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"ItemCell"];
    }
    return cell;
}

@end
