

//
//  WSVideoController.m
//  网易新闻
//
//  Created by WackoSix on 16/1/11.
//  Copyright © 2016年 WackoSix. All rights reserved.
//

#import "WSVideoController.h"

@interface WSVideoController ()

@end

@implementation WSVideoController

- (void)viewDidLoad {
    [super viewDidLoad];
}


#pragma mark - init

+ (instancetype)videoController{
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Media" bundle:nil];
    
    return [sb instantiateViewControllerWithIdentifier:@"videoController"];
}

@end
