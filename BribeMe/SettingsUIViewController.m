//
//  SettingsUIViewController.m
//  BribeMe
//
//  Created by William Gu on 3/2/15.
//  Copyright (c) 2015 William Gu. All rights reserved.
//

#import "SettingsUIViewController.h"
#import "LoginViewController.h"

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
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"user_id"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"username"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"password"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isLoggedIn"];
    LoginViewController *loginVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    [self presentViewController:loginVC animated:YES completion:nil];
}
-(IBAction)back:(UIButton *)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
