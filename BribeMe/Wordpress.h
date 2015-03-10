//
//  Wordpress.h
//  BribeMe
//
//  Created by William Gu on 3/2/15.
//  Copyright (c) 2015 William Gu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WordpressDelegate;
@protocol WordpressDelegate <NSObject>

-(void)loginSuccessWithID:(NSString *)userID;
-(void)loginFailureWithError:(NSError *)error;
-(void)createAccountSuccess;
-(void)createAccountFailureWithError:(NSError *)error;
-(void)fetchCategorySuccess:(NSArray *)data withIndex:(NSInteger)index;
-(void)fetchCategoryFailure:(NSError *)error;

@end


@interface Wordpress : NSObject

@property (nonatomic,assign) id delegate;
-(void)loginWithUsername:(NSString *)username andPassword:(NSString *)password;
-(void)createAccountWithUsername:(NSString *)username andPassword:(NSString *)password andDOB:(NSString *)dob;
-(void)getCategoryFromIndex:(NSInteger)index;

@end
