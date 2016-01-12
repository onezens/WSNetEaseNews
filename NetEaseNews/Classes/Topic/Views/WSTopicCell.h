//
//  WSTopicCell.h
//  网易新闻
//
//  Created by WackoSix on 16/1/10.
//  Copyright © 2016年 WackoSix. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WSTopic;

@interface WSTopicCell : UITableViewCell

@property (strong, nonatomic) WSTopic *topic;

+ (CGFloat)rowHeight;

+ (instancetype)topicCellWithTableView:(UITableView *)tableView;

@end
