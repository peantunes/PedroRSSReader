//
//  PEACoreDataManager.m
//  PedroRSSReader
//
//  Created by Pedro Antunes on 17/12/2014.
//  Copyright (c) 2014 Antunes. All rights reserved.
//

#import "PEACoreDataManager.h"
#import "NewsInfo.h"
#import "News.h"

@interface PEACoreDataManager ()


@end

@implementation PEACoreDataManager

+ (id)sharedInstance{
    static dispatch_once_t p = 0;
    __strong static id _sharedObject = nil;
    
    dispatch_once(&p, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

- (BOOL)addNewsRegister:(NewsInfo*)newsInfo{
    NSManagedObjectContext *context = [self managedObjectContext];
    News *newsCD = [NSEntityDescription
                                       insertNewObjectForEntityForName:@"News"
                                       inManagedObjectContext:context];
    newsCD.title = newsInfo.title;
    newsCD.text = newsInfo.text;
    newsCD.link = newsInfo.link;
    newsCD.thumbnailSmall = UIImageJPEGRepresentation(newsInfo.thumbnailSmall,0.8);
    newsCD.thumbnailLarge = UIImageJPEGRepresentation(newsInfo.thumbnailLarge, 0.8);
    newsCD.pubDate = newsInfo.pubDate;
    
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        return NO;
    }
    return YES;
}

- (BOOL)cleanNewsTable{
    NSFetchRequest * allNews = [[NSFetchRequest alloc] init];
    [allNews setEntity:[NSEntityDescription entityForName:@"News" inManagedObjectContext:self.managedObjectContext]];
    [allNews setIncludesPropertyValues:NO]; //only fetch the managedObjectID
    
    NSError * error = nil;
    NSArray * newsList = [self.managedObjectContext executeFetchRequest:allNews error:&error];
    //error handling goes here
    for (NSManagedObject * news in newsList) {
        [self.managedObjectContext deleteObject:news];
    }
    NSError *saveError = nil;
    [self.managedObjectContext save:&saveError];
    if (saveError){
        return NO;
    }
    return YES;
}

- (NSArray *)loadNewsEntityAsNewsInfo{
    
    NSFetchRequest * allNews = [[NSFetchRequest alloc] init];
    [allNews setEntity:[NSEntityDescription entityForName:@"News" inManagedObjectContext:self.managedObjectContext]];
    [allNews setIncludesPropertyValues:NO]; //only fetch the managedObjectID
    
    NSError * error = nil;
    NSArray * newsList = [self.managedObjectContext executeFetchRequest:allNews error:&error];
    NSMutableArray *listInfo = [NSMutableArray new];
    //error handling goes here
    for (News * news in newsList) {
        [listInfo addObject:[[NewsInfo alloc] initWithCoreData:news]];
    }
    return [listInfo copy];
}

@end
