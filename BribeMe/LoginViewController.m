//
//  LoginViewController.m
//  BribeMe
//
//  Created by William Gu on 3/2/15.
//  Copyright (c) 2015 William Gu. All rights reserved.
//

#import "LoginViewController.h"
#import "BribesViewController.h"
#import "CreateAccountViewController.h"
@interface LoginViewController ()

@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *spinner;
@property (nonatomic, weak) IBOutlet UITextField *username;
@property (nonatomic, weak) IBOutlet UITextField *password;
@property (nonatomic, strong) Wordpress *wordpress;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _wordpress = [[Wordpress alloc] init];
}

-(void)viewWillAppear:(BOOL)animated
{
    _wordpress.delegate = self;
    [_spinner stopAnimating];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)login:(UIButton *)sender
{
    [_spinner startAnimating];
    [_wordpress loginWithUsername:_username.text andPassword:_password.text];
}
-(IBAction)createAccount:(UIButton *)sender
{
    CreateAccountViewController *createAccountVC = [[CreateAccountViewController alloc] init];
    createAccountVC.wordpress = _wordpress;
    [self presentViewController:createAccountVC animated:YES completion:nil];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    return YES;
}

-(void)loginSuccessWithID:(NSString *)userID
{
    //TODO: Save userID to...
    [_spinner stopAnimating];
    BribesViewController *bribesVC = [[BribesViewController alloc] initWithNibName:@"BribesViewController" bundle:nil];
    [self presentViewController:bribesVC animated:YES completion:nil];
}
-(void)loginFailureWithError:(NSError *)error
{
    [_spinner stopAnimating];
    NSLog(@"Error: %@", error);
    if (error.code == 101)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Uh oh.." message:@"Please enter a username and password." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [alert show];
    } else if (error.code == 120) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Uh oh.." message:@"The username/password appears to be incorrect." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [alert show];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Uh oh.." message:@"There seems to be an error with our server, please try again." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [alert show];
    }
}

@end
