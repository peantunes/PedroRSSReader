//
//  NewsInfo.m
//  PedroRSSReader
//
//  Created by Pedro Antunes on 17/12/2014.
//  Copyright (c) 2014 Antunes. All rights reserved.
//

#import "NewsInfo.h"
#import "XMLDictionary.h"
#import "News.h"

#define kTitleTag @"title"
#define kDescriptionTag @"description"
#define kLinkTag @"link"
#define kPubDateTag @"pubDate"
#define kThumbnailTag @"media:thumbnail"
#define kImageUrl @"url"


@implementation NewsInfo

/*
 
 <item>
 <title>Sony movie's NY premiere cancelled</title>
 <description>The New York premiere of The Interview, a comedy about the assassination of North Korea's president, is cancelled amid threats from hackers.</description>
 <link>http://www.bbc.co.uk/news/entertainment-arts-30507306#sa-ns_mchannel=rss&amp;ns_source=PublicRSS20-sa</link>
 <guid isPermaLink="false">http://www.bbc.co.uk/news/entertainment-arts-30507306</guid>
 <pubDate>Wed, 17 Dec 2014 08:22:21 GMT</pubDate>
 <media:thumbnail width="66" height="49" url="http://news.bbcimg.co.uk/media/images/79776000/jpg/_79776560_sony.jpg"/>
 <media:thumbnail width="144" height="81" url="http://news.bbcimg.co.uk/media/images/79776000/jpg/_79776561_sony.jpg"/>
 </item>
 */
- (instancetype)initFromDictionary:(NSDictionary *)dict{
    if (self = [self init]){
        self.title = dict[kTitleTag];
        self.text = dict[kDescriptionTag];
        self.link = dict[kLinkTag];
        self.pubDate = [PEARequestManager formatDate:dict[kPubDateTag]];
        NSDictionary *smallURL = [dict[kThumbnailTag] firstObject];
        self.thumbnailSmallUrl = [smallURL attributes][@"url"];
        NSDictionary *largeURL = [dict[kThumbnailTag] lastObject];
        self.thumbnailLargeUrl = [largeURL attributes][@"url"];
        
        [self loadImages];
    }
    return self;
}

- (void) loadImages{
    
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND,0), ^{
        UIImage *smallImage = [PEARequestManager imageFromURL:weakSelf.thumbnailSmallUrl];
        UIImage *largeImage = [PEARequestManager imageFromURL:weakSelf.thumbnailLargeUrl];
        dispatch_async(dispatch_get_main_queue(), ^(void){
            weakSelf.thumbnailSmall = smallImage;
            weakSelf.thumbnailLarge = largeImage;
            [weakSelf save];
        });
    });
}

- (void) save{
    self.refreshImage.image = self.thumbnailSmall;
    [self.refreshImage setNeedsDisplay];
    [[PEACoreDataManager sharedInstance] addNewsRegister:self];
}

- (instancetype) initWithCoreData:(News*)news{
    if (self = [self init]){
        self.title = news.title;
        self.text = news.text;
        self.link = news.link;
        self.pubDate = news.pubDate;
        self.thumbnailSmall = [UIImage imageWithData:news.thumbnailSmall];
        self.thumbnailLarge = [UIImage imageWithData:news.thumbnailLarge];
    }
    return self;
}


@end
