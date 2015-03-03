//
//  Wordpress.m
//  BribeMe
//
//  Created by William Gu on 3/2/15.
//  Copyright (c) 2015 William Gu. All rights reserved.
//

#import "Constants.h"
#import "Wordpress.h"
#import <AFNetworking/AFNetworking.h>
@implementation Wordpress

-(void)loginWithUsername:(NSString *)username andPassword:(NSString *)password
{
    
    if ([username isEqualToString:@""] || [password isEqualToString:@""])
    {
        NSError *error = [NSError errorWithDomain:@"Please enter a username and password" code:101 userInfo:nil];
        [_delegate loginFailureWithError:error];
        return;
    }
    
    
    NSString *login = [NSString stringWithFormat:@"%@%@", kBMBASE_URL,loginAction];
    NSString *encoded = [NSString stringWithUTF8String:[login UTF8String]];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"username" : username, @"password" : password};
    [manager POST:encoded parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        NSString *errorString = responseObject[@"error"];
        if (errorString)
        {
            NSError *error = [NSError errorWithDomain:errorString code:120 userInfo:nil];
            [_delegate loginFailureWithError:error];
            return;
        }
        else
        {
            [_delegate loginSuccessWithID:responseObject[@"user_id"]];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [_delegate loginFailureWithError:error];
    }];
    
}

-(void)createAccountWithUsername:(NSString *)username andPassword:(NSString *)password andDOB:(NSString *)dob
{
    if ([username isEqualToString:@""] || [password isEqualToString:@""] || [dob isEqualToString:@""])
    {
        NSError *error = [NSError errorWithDomain:@"Please enter a username and password" code:101 userInfo:nil];
        [_delegate createAccountFailureWithError:error];
        return;
    }
    NSString *createAccount = [NSString stringWithFormat:@"%@%@", kBMBASE_URL,createAccountAction];
    NSString *encoded = [NSString stringWithUTF8String:[createAccount UTF8String]];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"username" : username, @"password" : password, @"dob" : dob};
    [manager POST:encoded parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        NSString *errorString = responseObject[@"error"];
        if (errorString)
        {
            NSError *error = [NSError errorWithDomain:errorString code:120 userInfo:nil];
            [_delegate createAccountFailureWithError:error];
            return;
        }
        else
        {
            [_delegate createAccountSuccess];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [_delegate createAccountFailureWithError:error];
    }];
    
}

-(void)getMyBribes
{
    
}
-(void)getFeatured
{
    NSString *getFeatured = [NSString stringWithFormat:@"%@%@",kBMBASE_URL,GETFEATURED];
    
    NSString *featuredEncoded = [NSString stringWithUTF8String:[getFeatured UTF8String]];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:featuredEncoded parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Object Success: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Fetch Failure: %@", error);
    }];

}
-(void)getDining
{
    
}
-(void)getNightlife
{
    NSString *getNightlife = [NSString stringWithFormat:@"%@%@",kBMBASE_URL,GETNIGHTLIFE];
    NSString *nightlifeEncoded = [NSString stringWithUTF8String:[getNightlife UTF8String]];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:nightlifeEncoded parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Object Success: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Fetch Failure: %@", error);
    }];

}
-(void)getShopping
{
    
}
-(void)getServices
{
    NSString *getServices = [NSString stringWithFormat:@"%@%@",kBMBASE_URL,GETSERVICES];
    NSString *servicesEncoded = [NSString stringWithUTF8String:[getServices UTF8String]];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:servicesEncoded parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Object Success: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Fetch Failure: %@", error);
    }];

}



@end
