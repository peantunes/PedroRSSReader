//
//  NewsInfo.h
//  PedroRSSReader
//
//  Created by Pedro Antunes on 17/12/2014.
//  Copyright (c) 2014 Antunes. All rights reserved.
//

#import <Foundation/Foundation.h>

@class News;
@interface NewsInfo : NSObject

- (instancetype) initFromDictionary:(NSDictionary*)dict;
- (instancetype) initWithCoreData:(News*)news;


@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *link;
@property (nonatomic, strong) NSString *thumbnailSmallUrl;
@property (nonatomic, strong) NSString *thumbnailLargeUrl;
@property (nonatomic, strong) UIImage *thumbnailSmall;
@property (nonatomic, strong) UIImage *thumbnailLarge;
@property (nonatomic, strong) NSDate *pubDate;

@property (nonatomic, strong) UIImageView *refreshImage;


@end
