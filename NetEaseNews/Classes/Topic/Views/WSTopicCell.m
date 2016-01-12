//
//  WSTopicCell.m
//  网易新闻
//
//  Created by WackoSix on 16/1/10.
//  Copyright © 2016年 WackoSix. All rights reserved.
//

#import "WSTopicCell.h"
#import "WSTopic.h"
#import "UIImageView+WebCache.h"
#import "WSImageView.h"

@interface WSTopicCell ()

@property (weak, nonatomic) IBOutlet WSImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *detailLbl;
@property (weak, nonatomic) IBOutlet UILabel *concernCountLbl;
@property (weak, nonatomic) IBOutlet UILabel *categoryLbl;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;

@end



@implementation WSTopicCell

+ (CGFloat)rowHeight{
    
    return 240;
}

- (void)setTopic:(WSTopic *)topic{
    
    _topic = topic;
    
    self.imgView.contentMode = UIViewContentModeCenter;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:topic.picurl] placeholderImage:[UIImage imageNamed:@"cell_image_background"]];
    self.detailLbl.text = topic.alias;
    self.concernCountLbl.text = [NSString stringWithFormat:@"%@关注",topic.concernCount];
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:topic.headpicurl]];
    self.nameLbl.text = topic.name;
    self.categoryLbl.text = topic.classification;
    
}


+ (instancetype)topicCellWithTableView:(UITableView *)tableView{
    
    WSTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"topicCell"];
    
    cell.iconView.layer.cornerRadius = cell.iconView.bounds.size.width * 0.5;
    cell.iconView.layer.masksToBounds = YES;
    
    return cell;
}


@end
