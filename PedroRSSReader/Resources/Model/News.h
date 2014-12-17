//
//  News.h
//  PedroRSSReader
//
//  Created by Pedro Antunes on 17/12/2014.
//  Copyright (c) 2014 Antunes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface News : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSData * thumbnailSmall;
@property (nonatomic, retain) NSString * link;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSDate * pubDate;
@property (nonatomic, retain) NSData * thumbnailLarge;

@end
