//
//  WSNavigationController.m
//  网易新闻
//
//  Created by WackoSix on 15/12/25.
//  Copyright © 2015年 WackoSix. All rights reserved.
//

#import "WSNavigationController.h"
#define kNavgationBarColor [UIColor colorWithRed:213/255.0 green:40/255.0 blue:43/255.0 alpha:1]


@interface WSNavigationController ()

@end

@implementation WSNavigationController


-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    self.navigationBar.tintColor = [UIColor whiteColor]; //控件颜色
    
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"top_navigation_background"] forBarMetrics:UIBarMetricsDefault];
//    self.navigationBar.backgroundColor = kNavgationBarColor;
//    self.navigationBar.barTintColor = kNavgationBarColor;
//    self.navigationBar.backgroundColor = kNavgationBarColor;
//    [self.navigationBar setBarTintColor:kNavgationBarColor];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    viewController.hidesBottomBarWhenPushed = YES;
    [super pushViewController:viewController animated:animated];
}


@end
