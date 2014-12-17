//
//  PEARSSCellTableViewCell.m
//  PedroRSSReader
//
//  Created by Pedro Antunes on 17/12/2014.
//  Copyright (c) 2014 Antunes. All rights reserved.
//

#import "PEARSSTableViewCell.h"

@interface PEARSSTableViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descriptionLabel;
@property (nonatomic, strong) UIImageView *newsImageView;

@end

@implementation PEARSSTableViewCell


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        [self configure];
    }
    
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setNewsInfo:(News *)newsInfo{
    _newsInfo = newsInfo;
    self.titleLabel.text = newsInfo.title;
    self.descriptionLabel.text = newsInfo.text;
    self.imageView.image = [UIImage imageWithData:newsInfo.thumbnailSmall];
}

#pragma mark Layout creator

/**
 Title           |-----|
 Description     |     |
                 |-----|
 
 */
- (void) configure{
    //Configure Title
    CGRect titleFrame = CGRectMake(CGRectGetMinX(self.frame)+10, CGRectGetMinY(self.frame)+10, self.frame.size.width*0.62f, self.frame.size.height*0.3f);
    self.titleLabel = [[UILabel alloc] initWithFrame:titleFrame];
    self.titleLabel.layer.anchorPoint = CGPointMake(0, 0);
    [self addSubview:self.titleLabel];
    
    //Configure Description
    CGRect descriptionFrame = CGRectMake(CGRectGetMinX(self.frame)+10, CGRectGetMaxY(self.frame)-10, self.frame.size.width*0.62f, self.frame.size.height*0.6f);
    self.descriptionLabel = [[UILabel alloc] initWithFrame:descriptionFrame];
    self.descriptionLabel.layer.anchorPoint = CGPointMake(0, 1);
    [self addSubview:self.descriptionLabel];
    
    //Configure Image
    CGRect imageFrame = CGRectMake(CGRectGetMaxX(self.frame)-10, CGRectGetMidY(self.frame)+10, self.frame.size.width*0.33f, self.frame.size.height*0.9f);
    self.newsImageView = [[UIImageView alloc] initWithFrame:imageFrame];
    self.newsImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.newsImageView.layer.anchorPoint = CGPointMake(0, 0.5);
    self.newsImageView.image = [UIImage imageNamed:@"no_image.gif"];
    
    [self addSubview:self.newsImageView];
    
}

@end
