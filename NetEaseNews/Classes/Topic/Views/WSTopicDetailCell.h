//
//  WSTopicDetailCell.h
//  网易新闻
//
//  Created by WackoSix on 16/1/11.
//  Copyright © 2016年 WackoSix. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WSTopicDetail;

@interface WSTopicDetailCell : UITableViewCell

@property (strong, nonatomic) WSTopicDetail *topicDetail;

+ (instancetype)topicDetalWithTableView:(UITableView *)tableView;

@end
