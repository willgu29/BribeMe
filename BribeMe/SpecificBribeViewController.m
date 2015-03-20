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
@property (nonatomic, weak) IBOutlet UIButton *bribeButton;

@property (nonatomic, strong) Wordpress *wordpress;

@end

@implementation SpecificBribeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _wordpress = [[Wordpress alloc] init];
    _wordpress.delegate = self;
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
    [self setupBribeButton];
    _postTitle.text = @"Not yet available";
    _postContent.text = [_bribe valueForKey:B_post_content];
    _businessName.text = [_bribe valueForKey:B_author_name];
    
    NSArray *profileIconURL = [_bribe valueForKey:B_author_image];
    NSURL *encodedProfileURL = [NSURL URLWithString:[profileIconURL firstObject]];
    [_profileIcon sd_setImageWithURL:encodedProfileURL];
    
    NSURL *featuredImage = [_bribe valueForKey:B_featured_image];
    [_featuredImage sd_setImageWithURL:featuredImage];
}
-(void)setupBribeButton
{
    if ([self isMyBribe])
    {
        [_bribeButton setTitle:@"Redeem Bribe" forState:UIControlStateNormal];
    }
    else
    {
        [_bribeButton setTitle:@"Accept Bribe" forState:UIControlStateNormal];
    }
}
-(BOOL)isMyBribe
{
    NSNumber *isBribe = [_bribe objectForKey:B_is_mybribe];
    if ([isBribe isEqualToNumber:[NSNumber numberWithInt:1]])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

#pragma mark -IBActions

-(IBAction)acceptBribe:(UIButton *)sender
{
    sender.enabled = NO;
    if ([self isMyBribe] || [_bribeButton.titleLabel.text isEqualToString:@"Redeem Bribe"])
    {
        [_wordpress postToCategory:REDEEMBRIBE andPostID:[_bribe valueForKey:B_post_id]];
    }
    else
    {
        [_wordpress postToCategory:ACCEPTBRIBE andPostID:[_bribe valueForKey:B_post_id]];
    }
}

-(IBAction)share:(UIButton *)sender
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Hmm..." message:@"Sharing functionality coming soon!" delegate:nil cancelButtonTitle:@"Okay!" otherButtonTitles: nil];
    [alertView show];
}

-(IBAction)back:(UIButton *)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -Wordpress Delegates
-(void)postBribeSuccess:(id)success
{
    if ([self isMyBribe])
    {
        
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"Your bribe has been accepted and can be redeemed now!" delegate:nil cancelButtonTitle:@"Okay!"otherButtonTitles:nil];
        [alertView show];
        [_bribeButton setTitle:@"Redeem Bribe" forState:UIControlStateNormal];

    }
    NSLog(@"Success: %@", success);
    _bribeButton.enabled = YES;
}
-(void)postBribeFailure:(NSError *)error
{
    NSLog(@"Error: %@", error);
    _bribeButton.enabled = YES;
}

@end
