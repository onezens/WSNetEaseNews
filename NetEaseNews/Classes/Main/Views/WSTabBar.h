//
//  WSTabBar.h
//  网易新闻
//
//  Created by WackoSix on 15/12/25.
//  Copyright © 2015年 WackoSix. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WSTabBarItem;


#pragma mark -
#pragma mark WSTabBarItem
#pragma mark -
@interface WSTabBarItem : UIView

@property (assign, nonatomic, getter=isSelected) BOOL selected;

@property (copy, nonatomic) void (^_Nullable itemClick)(WSTabBarItem * _Nonnull item);

+ (nonnull instancetype)tabBarItemWithTitle:(nonnull NSString *)title itemImage:(nonnull UIImage *)image selectedImage:(nullable UIImage *)selImage;

@end


#pragma mark -
#pragma mark  WSTabBar
#pragma mark -

typedef void(^barItemClickBlock) (NSInteger);
@interface WSTabBar : UIView


@property (assign, nonatomic, readonly) NSInteger selectedIndex;

@property (strong, nonatomic, nullable,) NSArray<WSTabBarItem *> *items;

+ (nonnull instancetype)tabBarWithItems:(nullable NSArray<WSTabBarItem *> *)items itemClick:(nonnull barItemClickBlock) myblock;;


@end
