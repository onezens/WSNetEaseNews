//
//  WSCommentCell.m
//  网易新闻
//
//  Created by WackoSix on 16/1/1.
//  Copyright © 2016年 WackoSix. All rights reserved.
//

#import "WSCommentCell.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "WSComment.h"

@interface WSCommentCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleView;
@property (weak, nonatomic) IBOutlet UILabel *placeView;
@property (weak, nonatomic) IBOutlet UILabel *commentView;
@property (weak, nonatomic) IBOutlet UILabel *timeSpanView;
@property (weak, nonatomic) IBOutlet UILabel *supportCount;
@property (weak, nonatomic) IBOutlet UIButton *supportBtn;


@end

@implementation WSCommentCell

#pragma mark - 设置数据
- (void)setComment:(WSComment *)comment{
    
    _comment = comment;

    [self.iconView sd_setImageWithURL:[NSURL URLWithString:comment.timg] placeholderImage:[UIImage imageNamed:@"comment_profile_mars"]];
    self.titleView.text = comment.n.length >0 ? comment.n : @"火星人";
    self.placeView.text = comment.f;
    self.commentView.text = comment.b;
    self.timeSpanView.text = comment.t;
    self.supportCount.text = comment.v;
}


#pragma mark - init

- (void)awakeFromNib{
    
    self.iconView.layer.cornerRadius = self.iconView.bounds.size.width * 0.5;
    self.iconView.layer.masksToBounds = YES;
}

+ (instancetype)commentCellWithTableView:(UITableView *)tableView{
    
    static NSString *ID = @"commentCell";
    
    WSCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"WSCommentCell" owner:nil options:nil].firstObject;
    }
    
    return cell;
}



@end
