//
//  WSTopicDetailCell.m
//  网易新闻
//
//  Created by WackoSix on 16/1/11.
//  Copyright © 2016年 WackoSix. All rights reserved.
//

#import "WSTopicDetailCell.h"
#import "UIImageView+WebCache.h"
#import "WSTopicDetail.h"
#import "WSQuesiton.h"
#import "WSAnswer.h"

@interface WSTopicDetailCell ()

@property (weak, nonatomic) IBOutlet UIImageView *questionIcon;
@property (weak, nonatomic) IBOutlet UILabel *questionTitleLbl;
@property (weak, nonatomic) IBOutlet UILabel *quesitonLbl;


@property (weak, nonatomic) IBOutlet UIImageView *answerIcon;
@property (weak, nonatomic) IBOutlet UILabel *answerTitleLbl;
@property (weak, nonatomic) IBOutlet UILabel *answerLbl;
@property (weak, nonatomic) IBOutlet UILabel *timeLbl;

@end

@implementation WSTopicDetailCell


- (void)setTopicDetail:(WSTopicDetail *)topicDetail{
    
    _topicDetail = topicDetail;
    
    [self.questionIcon sd_setImageWithURL:[NSURL URLWithString:topicDetail.question.userHeadPicUrl] placeholderImage:[UIImage imageNamed:@"comment_profile_default"]];
    self.questionTitleLbl.text = topicDetail.question.userName;
    self.quesitonLbl.text = topicDetail.question.content;
    
    [self.answerIcon sd_setImageWithURL:[NSURL URLWithString:topicDetail.answer.specialistHeadPicUrl] placeholderImage:[UIImage imageNamed:@"comment_profile_default"]];
    self.answerTitleLbl.text = topicDetail.answer.specialistName;
    self.answerLbl.text = topicDetail.answer.content;
    self.timeLbl.text = topicDetail.answer.cTime;

}


+ (instancetype)topicDetalWithTableView:(UITableView *)tableView{
    
    WSTopicDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"topicDetalCell"];
    
    cell.questionIcon.layer.cornerRadius = cell.questionIcon.bounds.size.width * 0.5;
    cell.questionIcon.layer.masksToBounds = YES;
    cell.answerIcon.layer.cornerRadius = cell.answerIcon.bounds.size.width * 0.5;
    cell.answerIcon.layer.masksToBounds = YES;
    
    return cell;
}

@end
