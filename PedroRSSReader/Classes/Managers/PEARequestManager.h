//
//  PEARequestManager.h
//  PedroRSSReader
//
//  Created by Pedro Antunes on 17/12/2014.
//  Copyright (c) 2014 Antunes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PEARequestManager : NSObject

+ (UIImage*) imageFromURL:(NSString*)path;
+ (NSDate*) formatDate:(NSString*)stringDate;
+ (NSDictionary*) loadRSSData:(NSString*)path;

+ (NSString*)feedURL;

@end
