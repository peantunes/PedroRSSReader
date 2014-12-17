//
//  PEARSSDetailViewController.h
//  PedroRSSReader
//
//  Created by Pedro Antunes on 17/12/2014.
//  Copyright (c) 2014 Antunes. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewsInfo;

@interface PEARSSDetailViewController : UIViewController

- (instancetype) initWithNewsInfo:(NewsInfo*)newsInfo;

@end
