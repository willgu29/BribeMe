//
//  CreateAccountViewController.h
//  BribeMe
//
//  Created by William Gu on 3/2/15.
//  Copyright (c) 2015 William Gu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Wordpress.h"

@interface CreateAccountViewController : UIViewController <WordpressDelegate>

@property (nonatomic, strong) Wordpress *wordpress;


@end
