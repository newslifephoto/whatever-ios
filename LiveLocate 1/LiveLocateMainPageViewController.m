//
//  LiveLocateMainPageViewController.m
//  LiveLocate 1
//
//  Created by x5mobile on 4/23/56 BE.
//  Copyright (c) 2556 LiveLocate. All rights reserved.
//

#import "LiveLocateMainPageViewController.h"

@interface LiveLocateMainPageViewController ()

@end

@implementation LiveLocateMainPageViewController


#pragma mark -
#pragma mark Class Method
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
	// Do any additional setup after loading the view.
    UIImage* imageForLeftBarButton = [UIImage imageNamed:@"list"];
    CGRect frameLeftBarButton = CGRectMake(0, 0, imageForLeftBarButton.size.width, imageForLeftBarButton.size.height);
    UIButton* leftBarButton = [[UIButton alloc] initWithFrame:frameLeftBarButton];
    [leftBarButton setBackgroundImage:imageForLeftBarButton forState:UIControlStateNormal];
    [leftBarButton setShowsTouchWhenHighlighted:YES];
    UIBarButtonItem* leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBarButton];
    [self.navigationItem setLeftBarButtonItem:leftBarButtonItem];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark Table Method
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int numberOfRow;
    if(tableView.tag == 1)
    {
        numberOfRow = 1;
    }
    else
    {
        numberOfRow = 10;
    }
    return numberOfRow;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if(tableView.tag == 1)
    {
        
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 100;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString * stringFormat = [NSString stringWithFormat:@"Sesction %i",section];
    return stringFormat;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView.tag == 1)
    {
        return 300;
    }
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
}


@end
