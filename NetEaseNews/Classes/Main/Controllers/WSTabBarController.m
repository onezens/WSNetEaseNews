//
//  WSTabBarController.m
//  网易新闻
//
//  Created by WackoSix on 15/12/25.
//  Copyright © 2015年 WackoSix. All rights reserved.
//

#import "WSTabBarController.h"
#import "WSTabBar.h"

@interface WSTabBarController ()

@end

@implementation WSTabBarController


- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self loadViewControllers];
    
    [self loadTabBarItems];
    
}

- (void)loadViewControllers {
    
    UIStoryboard *sb1 = [UIStoryboard storyboardWithName:@"News" bundle:nil];
    UIViewController *vc1 = [sb1 instantiateInitialViewController];
    
    UIStoryboard *sb2 = [UIStoryboard storyboardWithName:@"Reader" bundle:nil];
    UIViewController *vc2 = [sb2 instantiateInitialViewController];
    
    UIStoryboard *sb3 = [UIStoryboard storyboardWithName:@"Media" bundle:nil];
    UIViewController *vc3 = [sb3 instantiateInitialViewController];
    
    UIStoryboard *sb4 = [UIStoryboard storyboardWithName:@"Topic" bundle:nil];
    UIViewController *vc4 = [sb4 instantiateInitialViewController];
    
    UIStoryboard *sb5 = [UIStoryboard storyboardWithName:@"Me" bundle:nil];
    UIViewController *vc5 = [sb5 instantiateInitialViewController];
    
    self.viewControllers = @[vc1, vc2, vc3, vc4, vc5];
}


- (void)loadTabBarItems {
    
    WSTabBarItem *item1 = [WSTabBarItem tabBarItemWithTitle:@"新闻" itemImage:[UIImage imageNamed:@"tabbar_icon_news_normal"] selectedImage:[UIImage imageNamed:@"tabbar_icon_news_highlight"]];
    
    WSTabBarItem *item2 = [WSTabBarItem tabBarItemWithTitle:@"阅读" itemImage:[UIImage imageNamed:@"tabbar_icon_reader_normal"] selectedImage:[UIImage imageNamed:@"tabbar_icon_reader_highlight"]];
    
    WSTabBarItem *item3 = [WSTabBarItem tabBarItemWithTitle:@"视听" itemImage:[UIImage imageNamed:@"tabbar_icon_media_normal"] selectedImage:[UIImage imageNamed:@"tabbar_icon_media_highlight"]];
    
    WSTabBarItem *item4 = [WSTabBarItem tabBarItemWithTitle:@"话题" itemImage:[UIImage imageNamed:@"tabbar_icon_bar_normal"] selectedImage:[UIImage imageNamed:@"tabbar_icon_bar_highlight"]];
    
    WSTabBarItem *item5 = [WSTabBarItem tabBarItemWithTitle:@"我" itemImage:[UIImage imageNamed:@"tabbar_icon_me_normal"] selectedImage:[UIImage imageNamed:@"tabbar_icon_me_highlight"]];
    
    WSTabBar *tabBar = [WSTabBar tabBarWithItems:@[item1, item2, item3, item4, item5] itemClick:^(NSInteger index) {
        
        self.selectedIndex = index;
        
    } ];
    tabBar.frame = self.tabBar.bounds;
    [self.tabBar addSubview:tabBar];
    
}


@end
