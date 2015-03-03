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

@end


@interface Wordpress : NSObject

@property (nonatomic,assign) id delegate;
-(void)loginWithUsername:(NSString *)username andPassword:(NSString *)password;

@end
