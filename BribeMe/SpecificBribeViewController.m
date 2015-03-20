//
//  SpecificBribeViewController.m
//  BribeMe
//
//  Created by William Gu on 3/20/15.
//  Copyright (c) 2015 William Gu. All rights reserved.
//

#import "SpecificBribeViewController.h"
#import "Constants.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface SpecificBribeViewController ()

@property (nonatomic, weak) IBOutlet UIImageView *featuredImage;
@property (nonatomic, weak) IBOutlet UIImageView *profileIcon;
@property (nonatomic, weak) IBOutlet UILabel *postTitle;
@property (nonatomic, weak) IBOutlet UILabel *businessName;
@property (nonatomic, weak) IBOutlet UILabel *postContent;

@property (nonatomic, weak) IBOutlet UIButton *backButton;
@property (nonatomic, weak) IBOutlet UIButton *shareButton;
@property (nonatomic, weak) IBOutlet UIButton *acceptBribe;

@end

@implementation SpecificBribeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    [self setupIBOutlets];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupIBOutlets
{
    _postTitle.text = @"Not yet available";
    _postContent.text = [_bribe valueForKey:B_post_content];
    _businessName.text = [_bribe valueForKey:B_author_name];
    
    NSArray *profileIconURL = [_bribe valueForKey:B_author_image];
    NSURL *encodedProfileURL = [NSURL URLWithString:[profileIconURL firstObject]];
    [_profileIcon sd_setImageWithURL:encodedProfileURL];
    
    NSURL *featuredImage = [_bribe valueForKey:B_featured_image];
    [_featuredImage sd_setImageWithURL:featuredImage];
}

#pragma mark -IBActions

-(IBAction)share:(UIButton *)sender
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Hmm..." message:@"Sharing functionality coming soon!" delegate:nil cancelButtonTitle:@"Okay!" otherButtonTitles: nil];
    [alertView show];
}

-(IBAction)back:(UIButton *)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}


@end
