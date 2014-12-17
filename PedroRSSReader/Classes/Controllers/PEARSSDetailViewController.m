//
//  PEARSSDetailViewController.m
//  PedroRSSReader
//
//  Created by Pedro Antunes on 17/12/2014.
//  Copyright (c) 2014 Antunes. All rights reserved.
//

#import "PEARSSDetailViewController.h"
#import "NewsInfo.h"

@interface PEARSSDetailViewController ()

@property (nonatomic, strong) NewsInfo *newsInfo;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descriptionLabel;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *linkButton;
@end

@implementation PEARSSDetailViewController

- (instancetype) initWithNewsInfo:(NewsInfo*)newsInfo{
    if (self = [self init]){
        self.newsInfo = newsInfo;
        [self configureView];

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) configureView{
    self.title = @"Detail";
    self.view.backgroundColor = [UIColor whiteColor];
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.scrollView];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.scrollView.frame), CGRectGetMinY(self.scrollView.frame)+5, self.scrollView.frame.size.width, 70.0f)];
    self.titleLabel.font = [UIFont fontWithName:@"Arial" size:30.0f];
    self.titleLabel.numberOfLines = 2;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.text = self.newsInfo.title;
    [self.scrollView addSubview:self.titleLabel];
    UIImage *image ;
    if (self.newsInfo.thumbnailLarge){
        image = self.newsInfo.thumbnailLarge;
    }else{
        image = [PEARequestManager imageFromURL:self.newsInfo.thumbnailLargeUrl];
    }
    self.imageView = [[UIImageView alloc] initWithImage:image];
    self.imageView.frame = CGRectMake(CGRectGetMidX(self.scrollView.frame)-(image.size.width*0.5), 80.0f, image.size.width, image.size.height);
    [self.scrollView addSubview:self.imageView];
    
    self.descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.scrollView.frame.size.width*0.05, 90.0f + image.size.height, self.scrollView.frame.size.width*0.90, 200)];
    self.descriptionLabel.numberOfLines = 0;
    self.descriptionLabel.font = [UIFont fontWithName:@"Arial" size:20.0f];
//    self.descriptionLabel.textColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.8f alpha:1.0f];

    self.descriptionLabel.text = self.newsInfo.text;
    [self.descriptionLabel sizeToFit];
    
    [self.scrollView addSubview:self.descriptionLabel];
    
    self.linkButton = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.scrollView.frame) - 100.0f, 300, 200, 60)];
    self.linkButton.text = @"Open in Browser";
    self.linkButton.textColor = [UIColor blueColor];

    self.linkButton.textAlignment = NSTextAlignmentCenter;
    [self.scrollView addSubview:self.linkButton];
    
    UITapGestureRecognizer* gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTappedOnLink:)];
    [self.linkButton addGestureRecognizer:gesture];
    [self.linkButton setUserInteractionEnabled:YES];
    [self.linkButton addGestureRecognizer:gesture];
    
}

-(void)userTappedOnLink:(UIGestureRecognizer*)gestureRecognizer{
    NSLog(@"link tapped");
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.newsInfo.link]];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
