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
#import "Converter.h"
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
    if (index == MYBRIBES)
    {
        [self getMyBribes];
    }
    else if (index == FEATURED)
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
-(void)postToCategory:(NSInteger)index andPostID:(NSString *)post_id
{
    if (index == ACCEPTBRIBE)
    {
        [self acceptBribeWithID:post_id];
    }
    else if (index == REDEEMBRIBE)
    {
        [self redeemBribeWithID:post_id];
    }
}

-(void)getMyBribes
{
    NSString *getMyBribes = [NSString stringWithFormat:@"%@%@",kBMBASE_URL,GETMYBRIBES];
    NSString *myBribesEncoded = [NSString stringWithUTF8String:[getMyBribes UTF8String]];
    NSDictionary *params = @{@"user_id" : [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"]};

    [self sendRequestFor:myBribesEncoded andKeyIndex:MYBRIBES andParameters:params];
}
-(void)getFeatured
{
    NSString *getFeatured = [NSString stringWithFormat:@"%@%@",kBMBASE_URL,GETFEATURED];
    NSString *featuredEncoded = [NSString stringWithUTF8String:[getFeatured UTF8String]];
    [self sendRequestFor:featuredEncoded andKeyIndex:FEATURED andParameters:nil];
}
-(void)getDining
{
    NSString *getDining = [NSString stringWithFormat:@"%@%@",kBMBASE_URL,GETDINING];
    NSString *diningEncoded = [NSString stringWithUTF8String:[getDining UTF8String]];
    [self sendRequestFor:diningEncoded andKeyIndex:DINING andParameters:nil];
}
-(void)getNightlife
{
    NSString *getNightlife = [NSString stringWithFormat:@"%@%@",kBMBASE_URL,GETNIGHTLIFE];
    NSString *nightlifeEncoded = [NSString stringWithUTF8String:[getNightlife UTF8String]];
    [self sendRequestFor:nightlifeEncoded andKeyIndex:NIGHTLIFE andParameters:nil];

}
-(void)getShopping
{
    NSString *getShopping = [NSString stringWithFormat:@"%@%@",kBMBASE_URL,GETSHOPPING];
    NSString *shoppingEncoded = [NSString stringWithUTF8String:[getShopping UTF8String]];
    [self sendRequestFor:shoppingEncoded andKeyIndex:SHOPPING andParameters:nil];
}
-(void)getServices
{
    NSString *getServices = [NSString stringWithFormat:@"%@%@",kBMBASE_URL,GETSERVICES];
    NSString *servicesEncoded = [NSString stringWithUTF8String:[getServices UTF8String]];
    [self sendRequestFor:servicesEncoded andKeyIndex:SERVICES andParameters:nil];

}

-(void)acceptBribeWithID:(NSString *)post_id
{
    NSString *acceptBribe = [NSString stringWithFormat:@"%@%@", kBMBASE_URL,ACCEPTBRIBE_ACTION];
    NSString *acceptedEncoded = [NSString stringWithUTF8String:[acceptBribe UTF8String]];
    NSDictionary *params = @{@"user_id" : [[NSUserDefaults standardUserDefaults]objectForKey: @"user_id"],
                             @"post_id" : post_id};
    [self sendPostTo:acceptedEncoded andKeyIndex:ACCEPTBRIBE andParameters:params];
}
-(void)redeemBribeWithID:(NSString *)post_id
{
    NSString *redeemBribe = [NSString stringWithFormat:@"%@%@", kBMBASE_URL,REDEEMBRIBE_ACTION];
    NSString *redeemEncoded = [NSString stringWithUTF8String:[redeemBribe UTF8String]];
    NSDictionary *params = @{@"user_id" : [[NSUserDefaults standardUserDefaults]objectForKey: @"user_id"],
                             @"post_id" : post_id};
    [self sendPostTo:redeemEncoded andKeyIndex:REDEEMBRIBE andParameters:params];
}

-(void)sendRequestFor:(NSString *)encodedURL andKeyIndex:(NSInteger)index andParameters:(NSDictionary *)params
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:encodedURL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray *data = [[NSMutableArray alloc] init];
        for (id object in [responseObject valueForKey:[Converter getCategoryKeyFromIndex:index]])
        {
            [data addObject:object];
        }
        [_delegate fetchCategorySuccess:data withIndex:index];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [_delegate fetchCategoryFailure:error];
    }];
}

-(void)sendPostTo:(NSString *)encodedURL andKeyIndex:(NSInteger)index andParameters:(NSDictionary *)params
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:encodedURL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [_delegate postBribeSuccess:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [_delegate postBribeFailure:error];
    }];
}

@end
