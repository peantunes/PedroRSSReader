//
//  PEARequestManager.m
//  PedroRSSReader
//
//  Created by Pedro Antunes on 17/12/2014.
//  Copyright (c) 2014 Antunes. All rights reserved.
//

#import "PEARequestManager.h"
#import "XMLDictionary.h"

@implementation PEARequestManager

+ (UIImage*) imageFromURL:(NSString*)path{
    NSURL *url = [NSURL URLWithString:path];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *img = [[UIImage alloc] initWithData:data];
//    CGSize size = img.size;
    
    return img;
}

+ (NSDate*) formatDate:(NSString*)stringDate{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"EEE, dd MMM yyyy hh:mm:ss v"];//Wed, Dec 14 2011 22:50:12 GMT
    NSLog(@"format - %@, %@", stringDate, [dateFormat dateFromString:stringDate]);
    return [dateFormat dateFromString:stringDate];
}

+(NSDictionary *)loadRSSData:(NSString *)path{
    
    NSURL *url = [NSURL URLWithString:path];
    NSString *xmlString = [[NSString alloc] initWithContentsOfURL:url encoding:NSUTF8StringEncoding error:NULL];
    return [NSDictionary dictionaryWithXMLString:xmlString];
    
}

@end
