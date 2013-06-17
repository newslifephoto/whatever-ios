//
//  LoginViewController.m
//  LiveLocate 1
//
//  Created by Amornchai Kanokpullawad on 6/17/13.
//  Copyright (c) 2013 LiveLocate. All rights reserved.
//

#import "LoginViewController.h"
#import "ECSlidingViewController.h"
#import "InitialSlidingViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

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
	_usernameTextField.frame = CGRectMake(_usernameTextField.frame.origin.x, _usernameTextField.frame.origin.y, _usernameTextField.frame.size.width, 40);
    _passwordTextField.frame = CGRectMake(_passwordTextField.frame.origin.x, _passwordTextField.frame.origin.y, _passwordTextField.frame.size.width, 40);
    [_loginButton setBackgroundImage:[[UIImage imageNamed:@"orangeButton"] resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)] forState:UIControlStateNormal];
    
    //prepare for animation
    _loginView.alpha = 0;
    _contentView.frame = CGRectMake((self.view.bounds.size.width/2) - (_contentView.bounds.size.width/2),
                                 (self.view.bounds.size.height/2) - (_logoView.bounds.size.height/2),
                                 _contentView.bounds.size.width, _contentView.bounds.size.height);
}

-(void)viewDidAppear:(BOOL)animated{
    [UIView animateWithDuration:0.5 delay:2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _contentView.frame = CGRectMake((self.view.bounds.size.width/2) - (_contentView.bounds.size.width/2),
                                        (self.view.bounds.size.height/2) - (_contentView.bounds.size.height/2),
                                        _contentView.bounds.size.width, _contentView.bounds.size.height);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1 animations:^{
            _loginView.alpha = 1;
        }];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginButtonPressed:(id)sender {
    [UIView transitionWithView:[[[UIApplication sharedApplication] delegate] window]
                      duration:0.7
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^(void) {
                        BOOL oldState = [UIView areAnimationsEnabled];
                        [UIView setAnimationsEnabled:NO];
                        InitialSlidingViewController *initVC = [self.storyboard instantiateViewControllerWithIdentifier:@"initVC"];
                        [[UIApplication sharedApplication].delegate window].rootViewController = initVC;
                        [UIView setAnimationsEnabled:oldState];
                    }
                    completion:nil];
}

@end
