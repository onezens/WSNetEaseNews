//
//  WSContainerController.h
//  WSContainViewController
//
//  Created by WackoSix on 16/1/6.
//  Copyright © 2016年 WackoSix. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WSContainerController : UIViewController

@property (strong, nonatomic) UIViewController *parentController;

@property (strong, nonatomic) UIColor *navigationBarBackgrourdColor;

+ (instancetype) containerControllerWithSubControlers:(NSArray<UIViewController *> *)viewControllers parentController:(UIViewController *)vc;


@end
