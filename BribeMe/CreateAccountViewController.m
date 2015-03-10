//
//  CreateAccountViewController.m
//  BribeMe
//
//  Created by William Gu on 3/2/15.
//  Copyright (c) 2015 William Gu. All rights reserved.
//

#import "CreateAccountViewController.h"
#import "BribesViewController.h"
@interface CreateAccountViewController ()

@property (nonatomic, weak) IBOutlet UITextField *username;
@property (nonatomic, weak) IBOutlet UITextField *password;
@property (nonatomic, weak) IBOutlet UIDatePicker *dob;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *spinner;

@end

@implementation CreateAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(IBAction)back:(UIButton *)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
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

-(IBAction)createAccount:(UIButton *)sender
{
    NSDate *date = [_dob date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    
    [_spinner startAnimating];
    [_wordpress createAccountWithUsername:_username.text andPassword:_password.text andDOB:dateString];
    
}

-(void)createAccountSuccess
{
    
    [_wordpress loginWithUsername:_username.text andPassword:_password.text];
}
-(void)createAccountFailureWithError:(NSError *)error
{
    [_spinner stopAnimating];
    if (error.code == 101)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Uh oh.." message:@"Please enter a username and password" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [alertView show];
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Uh oh.." message:@"There seems to ben an error with our server. Please try again." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [alertView show];
    }
   
}
-(void)loginSuccessWithID:(NSString *)userID
{
    [_spinner stopAnimating];
    
    [[NSUserDefaults standardUserDefaults] setObject:userID forKey:@"user_id"];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isLoggedIn"];
    [[NSUserDefaults standardUserDefaults] setObject:_username.text forKey:@"username"];
    [[NSUserDefaults standardUserDefaults] setObject:_password.text forKey:@"password"];
    
    BribesViewController *bribesVC= [[BribesViewController alloc] initWithNibName:@"BribesViewController" bundle:nil];
    [self presentViewController:bribesVC animated:YES completion:nil];
    
}
-(void)loginFailureWithError:(NSError *)error
{
    [_spinner stopAnimating];
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

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

@end
