//
//  LoginViewController.m
//  BribeMe
//
//  Created by William Gu on 3/2/15.
//  Copyright (c) 2015 William Gu. All rights reserved.
//

#import "LoginViewController.h"
#import "BribesViewController.h"
@interface LoginViewController ()

@property (nonatomic, weak) IBOutlet UITextField *username;
@property (nonatomic, weak) IBOutlet UITextField *password;
@property (nonatomic, strong) Wordpress *wordpress;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _wordpress = [[Wordpress alloc] init];
    _wordpress.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)login:(UIButton *)sender
{
    [_wordpress loginWithUsername:_username.text andPassword:_password.text];
}
-(IBAction)createAccount:(UIButton *)sender
{
    
}
-(IBAction)forgotPassword:(UIButton *)sender
{
    
}

-(void)loginSuccessWithID:(NSString *)userID
{
    //TODO: Save userID to...
    BribesViewController *bribesVC = [[BribesViewController alloc] initWithNibName:@"BribesViewController" bundle:nil];
    [self presentViewController:bribesVC animated:YES completion:nil];
}
-(void)loginFailureWithError:(NSError *)error
{
    NSLog(@"Error: %@", error);
    if (error.code == 101)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Uh oh.." message:@"Please enter a username and password." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [alert show];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Uh oh.." message:@"There seems to be an error with our server, please try again." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [alert show];
    }
}

@end
