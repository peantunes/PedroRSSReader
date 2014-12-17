//
//  ViewController.m
//  PedroRSSReader
//
//  Created by Pedro Antunes on 17/12/2014.
//  Copyright (c) 2014 Antunes. All rights reserved.
//

#import "PEARSSListViewController.h"
#import "PEARSSDetailViewController.h"
#import "PEARSSListTableView.h"
#import "NewsInfo.h"
#import "XMLDictionary.h"


#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

@interface PEARSSListViewController ()

@property (nonatomic, strong) NSArray *listNews;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation PEARSSListViewController

#pragma mark Initialization methods
/*
 Setting the view and definig the delegate
 */
-(instancetype)init{
    if (self = [super init]){
        self.title = @"RSS Feed";
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Initialize the refresh control.
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor darkGrayColor];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self
                            action:@selector(refreshRSS)
                  forControlEvents:UIControlEventValueChanged];
    
    [self refreshRSS];
}

- (void) refreshRSS{
    
    __weak typeof(self) weakSelf = self;
    [PEARequestManager checkInternet:^(BOOL value) {
        if (value){
            [weakSelf loadRSS];
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Internet" message:@"Verify your internet connection" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Close", nil];
            [alert show];
        }
        // End the refreshing
        if (weakSelf.refreshControl) {
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"MMM d, h:mm a"];
            NSString *title = [NSString stringWithFormat:@"Last update: %@", [formatter stringFromDate:[NSDate date]]];
            NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:[UIColor whiteColor]
                                                                        forKey:NSForegroundColorAttributeName];
            NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attrsDictionary];
            weakSelf.refreshControl.attributedTitle = attributedTitle;
            
            [weakSelf.refreshControl endRefreshing];
        }
    }];
}

- (void) loadRSS{
    
    NSDictionary *content = [PEARequestManager loadRSSData:[PEARequestManager feedURL]];
    NSArray *list = [content valueForKeyPath:@"channel.item"];
    NSMutableArray *rssFeed = [NSMutableArray new];
    for (NSDictionary *item in list){
        [rssFeed addObject:[[NewsInfo alloc] initFromDictionary:item]];
    }
    self.listNews = [rssFeed copy];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark TableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90.0f;
}

#pragma mark TableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listNews.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"RSSItemCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    NewsInfo *newsInfo = self.listNews[indexPath.row];
    cell.textLabel.text = newsInfo.title;
    cell.detailTextLabel.text = newsInfo.text;
    cell.imageView.image = [UIImage imageNamed:@"no_image.gif"];
    
    if (newsInfo.thumbnailSmallUrl){
        dispatch_async(kBgQueue, ^{
            UIImage *image = [PEARequestManager imageFromURL:newsInfo.thumbnailSmallUrl];
            if (image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    UITableViewCell *updateCell = (id)[tableView cellForRowAtIndexPath:indexPath];
                    if (updateCell){
                        updateCell.imageView.image = image;
                        [updateCell.imageView setNeedsDisplay];
                        [updateCell.textLabel setNeedsDisplay];
                        [updateCell.detailTextLabel setNeedsDisplay];
                        [updateCell setNeedsDisplay];
                    }
                });
            }
        });
    }

    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PEARSSDetailViewController *detail = [[PEARSSDetailViewController alloc] initWithNewsInfo:self.listNews[indexPath.row]];
    
    [self.navigationController pushViewController:detail animated:YES];
}

@end
