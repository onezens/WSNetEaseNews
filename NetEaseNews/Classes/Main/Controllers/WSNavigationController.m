//
//  WSNavigationController.m
//  网易新闻
//
//  Created by WackoSix on 15/12/25.
//  Copyright © 2015年 WackoSix. All rights reserved.
//

#import "WSNavigationController.h"
#define kNavgationBarColor [UIColor colorWithRed:213/255.0 green:40/255.0 blue:43/255.0 alpha:1]


@interface WSNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation WSNavigationController


-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    //设置导航控制器的左边拖动返回效果
    self.interactivePopGestureRecognizer.delegate = self;
    
    //导航条的属性设置
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    self.navigationBar.tintColor = [UIColor whiteColor]; //控件颜色
    
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"top_navigation_background"] forBarMetrics:UIBarMetricsDefault];

}

- (UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    viewController.hidesBottomBarWhenPushed = YES;
    [super pushViewController:viewController animated:animated];
}

///  手势协议
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    
    if (self.viewControllers.count == 1) {
        return false;
    }
    
    return true;
}


@end
