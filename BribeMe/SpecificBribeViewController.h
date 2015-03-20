//
//  SpecificBribeViewController.h
//  BribeMe
//
//  Created by William Gu on 3/20/15.
//  Copyright (c) 2015 William Gu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Wordpress.h"

@interface SpecificBribeViewController : UIViewController <WordpressDelegate>

@property (nonatomic, strong) NSDictionary *bribe; //must pass down bribe

@end
