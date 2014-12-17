//
//  ViewController.m
//  PedroRSSReader
//
//  Created by Pedro Antunes on 17/12/2014.
//  Copyright (c) 2014 Antunes. All rights reserved.
//

#import "PEARSSListViewController.h"
#import "PEARSSListTableView.h"
#import "PEARSSTableViewCell.h"

@interface PEARSSListViewController ()

@property (nonatomic,strong) UITableView *tableView;

@end

@implementation PEARSSListViewController

#pragma mark Initialization methods
/*
 Setting the view and definig the delegate
 */
-(instancetype)init{
    if (self = [super init]){
        self.tableView = [[PEARSSListTableView alloc] init];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.view = self.tableView;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark TableViewDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"RSSItemCell";
    
    PEARSSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[PEARSSTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    return cell;
}

@end
