//
//  BribesViewController.h
//  BribeMe
//
//  Created by William Gu on 2/27/15.
//  Copyright (c) 2015 William Gu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Wordpress.h"
#import "SwipeView.h"

@interface BribesViewController : UIViewController <WordpressDelegate, SwipeViewDataSource, SwipeViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet SwipeView *swipeView;
@property (nonatomic, weak) IBOutlet UILabel *category;
@property (nonatomic, weak) IBOutlet UIPageControl *pageControl;
@property (nonatomic, weak) IBOutlet UITextField *searchBar;


@end
