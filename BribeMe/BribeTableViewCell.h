//
//  BribeTableViewCell.h
//  BribeMe
//
//  Created by William Gu on 3/9/15.
//  Copyright (c) 2015 William Gu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BribeTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView *featured;
@property (nonatomic, weak) IBOutlet UIImageView *profileLogo;
@property (nonatomic, weak) IBOutlet UILabel *title;
@property (nonatomic, weak) IBOutlet UILabel *username;


@end
