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

-(void)getCategoryFromIndex:(NSInteger)index
{
    if (index == FEATURED)
    {
        [self getFeatured];
    }
    else if (index == DINING)
    {
        [self getDining];
    }
    else if (index == NIGHTLIFE)
    {
        [self getNightlife];
    }
    else if (index == SHOPPING)
    {
        [self getShopping];
    }
    else if (index == SERVICES)
    {
        [self getServices];
    }
}

-(void)getMyBribes
{
    
}
-(void)getFeatured
{
    NSString *getFeatured = [NSString stringWithFormat:@"%@%@",kBMBASE_URL,GETFEATURED];
    
    NSString *featuredEncoded = [NSString stringWithUTF8String:[getFeatured UTF8String]];
    [self sendRequestFor:featuredEncoded];
}
-(void)getDining
{
    NSString *getDining = [NSString stringWithFormat:@"%@%@",kBMBASE_URL,GETDINING];
    NSString *diningEncoded = [NSString stringWithUTF8String:[getDining UTF8String]];
    [self sendRequestFor:diningEncoded];
}
-(void)getNightlife
{
    NSString *getNightlife = [NSString stringWithFormat:@"%@%@",kBMBASE_URL,GETNIGHTLIFE];
    NSString *nightlifeEncoded = [NSString stringWithUTF8String:[getNightlife UTF8String]];
    [self sendRequestFor:nightlifeEncoded];

}
-(void)getShopping
{
    NSString *getNightlife = [NSString stringWithFormat:@"%@%@",kBMBASE_URL,GETNIGHTLIFE];
    NSString *nightlifeEncoded = [NSString stringWithUTF8String:[getNightlife UTF8String]];
    [self sendRequestFor:nightlifeEncoded];
}
-(void)getServices
{
    NSString *getServices = [NSString stringWithFormat:@"%@%@",kBMBASE_URL,GETSERVICES];
    NSString *servicesEncoded = [NSString stringWithUTF8String:[getServices UTF8String]];
    [self sendRequestFor:servicesEncoded];

}
-(void)sendRequestFor:(NSString *)encodedURL
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:encodedURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [_delegate fetchCategorySuccess:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [_delegate fetchCategoryFailure:error];
    }];
}


@end
