//
//  WSContentController.h
//  网易新闻
//
//  Created by WackoSix on 15/12/30.
//  Copyright © 2015年 WackoSix. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WSContentController : UIViewController

/**新闻内容标识*/
@property (copy, nonatomic) NSString *docid;

+ (instancetype)contentControllerWithID:(NSString *)docID;

@end
