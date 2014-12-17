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

+(NSString *)feedURL{
    [PEARequestManager initialize];
//    NSString *settingsBundle = [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"bundle"];
//    
//    NSDictionary *settings = [NSDictionary dictionaryWithContentsOfFile:[settingsBundle stringByAppendingPathComponent:@"Root.plist"]];
//    
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"feed_url"];

}
     
+ (void)initialize{
    NSUserDefaults *defs = [NSUserDefaults standardUserDefaults];
    [defs synchronize];
    
    NSString *settingsBundle = [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"bundle"];
    
    if(!settingsBundle)
    {
        NSLog(@"Could not find Settings.bundle");
        return;
    }
    
    NSDictionary *settings = [NSDictionary dictionaryWithContentsOfFile:[settingsBundle stringByAppendingPathComponent:@"Root.plist"]];
    NSArray *preferences = [settings objectForKey:@"PreferenceSpecifiers"];
    NSMutableDictionary *defaultsToRegister = [[NSMutableDictionary alloc] initWithCapacity:[preferences count]];
    
    for (NSDictionary *prefSpecification in preferences)
    {
        NSString *key = [prefSpecification objectForKey:@"Key"];
        if (key)
        {
            // Check if value is registered or not in userDefaults
            id currentObject = [defs objectForKey:key];
            if (currentObject == nil)
            {
                // Not registered: set value from Settings.bundle
                id objectToSet = [prefSpecification objectForKey:@"DefaultValue"];
                [defaultsToRegister setObject:objectToSet forKey:key];
                NSLog(@"Setting object %@ for key %@", objectToSet, key);
            }
            else
            {
                // Already registered
                NSLog(@"Key %@ is already registered with Value: %@).", key, currentObject);
            }
        }
    }
    
    [defs registerDefaults:defaultsToRegister];
    [defs synchronize];
}


@end
