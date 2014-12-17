//
//  PEARequestManager.m
//  PedroRSSReader
//
//  Created by Pedro Antunes on 17/12/2014.
//  Copyright (c) 2014 Antunes. All rights reserved.
//

#import "PEARequestManager.h"

@implementation PEARequestManager

+ (UIImage*) imageFromURL:(NSString*)path{
    NSURL *url = [NSURL URLWithString:path];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *img = [[UIImage alloc] initWithData:data];
//    CGSize size = img.size;
    
    return img;
}

@end
