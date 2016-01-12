//
//  WSContentController.h
//  网易新闻
//
//  Created by WackoSix on 15/12/27.
//  Copyright © 2015年 WackoSix. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WSNewsController : UITableViewController

///**新闻链接标识*/
@property (copy, nonatomic) NSString *channelID;

/**频道的url*/
@property (copy, nonatomic) NSString *channelUrl;

+ (instancetype)newsController;

@end
