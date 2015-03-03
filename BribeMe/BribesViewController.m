//
//  BribesViewController.m
//  BribeMe
//
//  Created by William Gu on 2/27/15.
//  Copyright (c) 2015 William Gu. All rights reserved.
//

#import "BribesViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "Constants.h"
#import "Converter.h"

@interface BribesViewController ()


@property (nonatomic, strong) Wordpress *wordpress;
@property (nonatomic, strong) NSArray *categories; //services,nightlife, etc.

@end

@implementation BribesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _wordpress = [[Wordpress alloc] init];
    _wordpress.delegate = self;
    _categories = @[@"Featured", @"Dining", @"Nightlife", @"Shopping", @"Services"];
    
    //configure swipe view
    _swipeView.alignment = SwipeViewAlignmentCenter;
    _swipeView.pagingEnabled = YES;
    _swipeView.itemsPerPage = 1;
    _swipeView.truncateFinalPage = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)settings:(UIButton *)sender
{
    
}

- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView
{
    return [_categories count]; 
}

- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    if (view == nil)
    {
        //load new item view instance from nib
        //control events are bound to view controller in nib file
        view = [[UIView alloc] initWithFrame:self.swipeView.bounds];
        //note that it is only safe to use the reusingView if we return the same nib for each
        //item view, if different items have different contents, ignore the reusingView value
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.swipeView.bounds];
        tableView.delegate = self;
        tableView.dataSource = self;
        _category.text = [Converter getCategoryFromIndex:index];
        [view addSubview:tableView];

    }
    return view;
}
- (CGSize)swipeViewItemSize:(SwipeView *)swipeView
{
    return self.swipeView.bounds.size;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *simpleTableIdentifier = [NSString stringWithFormat:@"%ld_%ld", (long)indexPath.section, (long)indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
        
    }
    
    return cell;
}

@end
