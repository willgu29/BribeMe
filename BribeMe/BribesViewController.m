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

@end

@implementation BribesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)testData:(UIButton *)sender
{
    NSString *getServices = [NSString stringWithFormat:@"%@%@",kBMBASE_URL,GETSERVICES];
    NSString *getNightlife = [NSString stringWithFormat:@"%@%@",kBMBASE_URL,GETNIGHTLIFE];
    NSString *getFeatured = [NSString stringWithFormat:@"%@%@",kBMBASE_URL,GETFEATURED];
    
    NSString *servicesEncoded = [NSString stringWithUTF8String:[getServices UTF8String]];
    NSString *nightlifeEncoded = [NSString stringWithUTF8String:[getNightlife UTF8String]];
    NSString *featuredEncoded = [NSString stringWithUTF8String:[getFeatured UTF8String]];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:nightlifeEncoded parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Object Success: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Fetch Failure: %@", error);
    }];
    [manager GET:servicesEncoded parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Object Success: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Fetch Failure: %@", error);
    }];
    [manager GET:featuredEncoded parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Object Success: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Fetch Failure: %@", error);
    }];
 
  
    

}

@end
