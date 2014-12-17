//
//  PEARequestManager.h
//  PedroRSSReader
//
//  Created by Pedro Antunes on 17/12/2014.
//  Copyright (c) 2014 Antunes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^connection)(BOOL);

@interface PEARequestManager : NSObject

+ (UIImage*) imageFromURL:(NSString*)path;
+ (NSDate*) formatDate:(NSString*)stringDate;
+ (NSDictionary*) loadRSSData:(NSString*)path;
+ (void)checkInternet:(connection)block;

+ (NSString*)feedURL;

@end
