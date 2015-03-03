//
//  BribesViewController.m
//  BribeMe
//
//  Created by William Gu on 2/27/15.
//  Copyright (c) 2015 William Gu. All rights reserved.
//

#import "BribesViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "Constants.h"

@interface BribesViewController ()

@property (nonatomic, strong) Wordpress *wordpress;

@end

@implementation BribesViewController

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

-(IBAction)testData:(UIButton *)sender
{


}

-(void)loginSuccessWithID:(NSString *)userID
{
    NSLog(@"user id: %@", userID);
}
-(void)loginFailureWithError:(NSError *)error
{
    NSLog(@"Error login: %@", error);
}

@end
