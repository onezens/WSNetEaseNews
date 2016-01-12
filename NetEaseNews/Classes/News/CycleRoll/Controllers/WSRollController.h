//
//  WSRollController.h
//  网易新闻
//
//  Created by WackoSix on 16/1/9.
//  Copyright © 2016年 WackoSix. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^SelectedItemBlock)(id obj);
@interface WSRollController : UICollectionViewController

@property (strong, nonatomic) NSArray *ads;

-(void)rollControllerWithAds:(NSArray *)ads selectedItem:(SelectedItemBlock)sel;

@end
