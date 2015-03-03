//
//  SettingsUIViewController.m
//  BribeMe
//
//  Created by William Gu on 3/2/15.
//  Copyright (c) 2015 William Gu. All rights reserved.
//

#import "SettingsUIViewController.h"

@interface SettingsUIViewController ()

@end

@implementation SettingsUIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)logout:(UIButton *)sender
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Not configured yet!" message:@"Will be soon" delegate:nil cancelButtonTitle:@"Okay!" otherButtonTitles:nil];
    [alertView show];
}
-(IBAction)back:(UIButton *)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
