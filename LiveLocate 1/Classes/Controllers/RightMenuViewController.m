//
//  RightMenuViewController.m
//  LiveLocate 1
//
//  Created by amornchai kanokpullwad on 6/9/13.
//  Copyright (c) 2013 LiveLocate. All rights reserved.
//

#import "RightMenuViewController.h"
#import "ECSlidingViewController.h"

@interface RightMenuViewController ()

@end

@implementation RightMenuViewController

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
	[self.slidingViewController setAnchorLeftPeekAmount:40.0f];
    self.slidingViewController.underRightWidthLayout = ECVariableRevealWidth;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
