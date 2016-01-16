//
//  MoviePlayerViewController.h
//  Player
//
//  Created by dllo on 15/11/7.
//  Copyright © 2015年 zhaoqingwen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoviePlayerViewController : UIViewController

@property (nonatomic,copy) NSString *url;

@property (copy, nonatomic) void (^playFinished)();

@end
