//
//  PEACoreDataManager.h
//  PedroRSSReader
//
//  Created by Pedro Antunes on 17/12/2014.
//  Copyright (c) 2014 Antunes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class NewsInfo;

@interface PEACoreDataManager : NSObject

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

+ (id)sharedInstance;

- (BOOL)addNewsRegister:(NewsInfo*)newsInfo;

- (BOOL)cleanNewsTable;

- (NSArray *)loadNewsEntityAsNewsInfo;

@end
