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
#import "SettingsUIViewController.h"
#import "BribeTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface BribesViewController ()


@property (nonatomic, strong) Wordpress *wordpress;
@property (nonatomic, strong) NSArray *categories; //services,nightlife, etc.

@property (nonatomic, strong) NSMutableArray *categoryContainer;
@property (nonatomic, strong) NSMutableArray *featured;
@property (nonatomic, strong) NSMutableArray *dining;
@property (nonatomic, strong) NSMutableArray *nightlife;
@property (nonatomic, strong) NSMutableArray *shopping;
@property (nonatomic, strong) NSMutableArray *services;


@end

@implementation BribesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _wordpress = [[Wordpress alloc] init];
    _wordpress.delegate = self;
    _categories = @[@"Featured", @"Dining", @"Nightlife", @"Shopping", @"Services"];
    
    _featured = [[NSMutableArray alloc] init];
    _dining = [[NSMutableArray alloc] init];
    _nightlife = [[NSMutableArray alloc] init];
    _shopping = [[NSMutableArray alloc] init];
    _services = [[NSMutableArray alloc] init];
    _categoryContainer = [[NSMutableArray alloc] initWithArray:@[_featured,_dining,_nightlife,_shopping,_services]];
    for (int i = 0; i < [_categoryContainer count]; i++)
    {
        [_wordpress getCategoryFromIndex:i];
    }

    //configure swipe view
    _swipeView.alignment = SwipeViewAlignmentCenter;
    _swipeView.pagingEnabled = YES;
    _swipeView.itemsPerPage = 1;
    _swipeView.truncateFinalPage = YES;
    _swipeView.wrapEnabled = YES;
    [self swipeViewCurrentItemIndexDidChange:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)settings:(UIButton *)sender
{
    SettingsUIViewController *settingsVC = [[SettingsUIViewController alloc] initWithNibName:@"SettingsUIViewController" bundle:nil];
    [self presentViewController:settingsVC animated:YES completion:nil];
}


#pragma mark - Wordpress Delegate
-(void)fetchCategorySuccess:(NSArray *)data withIndex:(NSInteger)index
{
    NSMutableArray *category = [_categoryContainer objectAtIndex:index];
    category = data.mutableCopy;
    [_categoryContainer replaceObjectAtIndex:index withObject:category];
    
    UIView *viewItem = [_swipeView itemViewAtIndex:index];
    UITableView *tableView = [viewItem.subviews lastObject];
    [tableView reloadData];
}
-(void)fetchCategoryFailure:(NSError *)error
{
    NSLog(@"Error: %@", error);
}

#pragma mark - Swipe View

- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView
{
    return [_categories count]; 
}


-(void)swipeViewCurrentItemIndexDidChange:(SwipeView *)swipeView
{
    _category.text = [Converter getCategoryFromIndex:swipeView.currentPage];
    _pageControl.currentPage = swipeView.currentPage;
//    [_wordpress getCategoryFromIndex:swipeView.currentPage];

}
- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    NSLog(@"Index: %d", index);
    view = nil;
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
        tableView.tag = index;
        [view addSubview:tableView];
        [_wordpress getCategoryFromIndex:index];

    }

    return view;
}
- (CGSize)swipeViewItemSize:(SwipeView *)swipeView
{
    return self.swipeView.bounds.size;
}

#pragma mark - Tableview


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSMutableArray *category = [_categoryContainer objectAtIndex:tableView.tag];
    return [category count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *simpleTableIdentifier = [NSString stringWithFormat:@"%ld_%ld", (long)indexPath.section, (long)indexPath.row];
    BribeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"BribeTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    NSMutableArray *category = [_categoryContainer objectAtIndex:tableView.tag];
    NSDictionary *bribe = [category objectAtIndex:indexPath.row];
    cell.title.text = [bribe valueForKey:@"post_content"];
//    cell.username.text = [category valueForKey:@"author_name"];
//    [cell.featured sd_setImageWithURL:<#(NSURL *)#> placeholderImage:<#(UIImage *)#>]
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 230;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 230;
}



@end
