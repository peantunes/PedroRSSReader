//
//  ViewController.m
//  PedroRSSReader
//
//  Created by Pedro Antunes on 17/12/2014.
//  Copyright (c) 2014 Antunes. All rights reserved.
//

#import "PEARSSListViewController.h"
#import "PEARSSListTableView.h"
#import "NewsInfo.h"
#import "XMLDictionary.h"

@interface PEARSSListViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *listNews;

@end

@implementation PEARSSListViewController

#pragma mark Initialization methods
/*
 Setting the view and definig the delegate
 */
-(instancetype)init{
    if (self = [super init]){
        self.title = @"RSS Feed";
        self.tableView = [[UITableView alloc] init];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.frame = self.view.frame;
        self.view = self.tableView;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDictionary *content = [PEARequestManager loadRSSData:@"http://feeds.bbci.co.uk/news/rss.xml"];
    NSArray *list = [content valueForKeyPath:@"channel.item"];
    NSMutableArray *rssFeed = [NSMutableArray new];
    for (NSDictionary *item in list){
        [rssFeed addObject:[[NewsInfo alloc] initFromDictionary:item]];
    }
    self.listNews = [rssFeed copy];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark TableViewDelegate
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 90.0f;
//}

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
    cell.imageView.image = newsInfo.thumbnailSmall;
    
    return cell;
}

@end
