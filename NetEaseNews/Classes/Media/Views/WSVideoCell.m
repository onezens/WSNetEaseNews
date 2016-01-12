//
//  WSVideoCell.m
//  网易新闻
//
//  Created by WackoSix on 16/1/11.
//  Copyright © 2016年 WackoSix. All rights reserved.
//

#import "WSVideoCell.h"
#import "WSVideo.h"
#import "UIImageView+WebCache.h"

@interface WSVideoCell ()

@property (weak, nonatomic) IBOutlet UILabel *videoTitleLbl;
@property (weak, nonatomic) IBOutlet UILabel *videoDetailLbl;
@property (weak, nonatomic) IBOutlet UIImageView *videoImgView;
@property (weak, nonatomic) IBOutlet UIButton *videoTimeBtn;
@property (weak, nonatomic) IBOutlet UIButton *videoLookBtn;
@property (weak, nonatomic) IBOutlet UIButton *videoCommentBtn;


@end

@implementation WSVideoCell

- (void)setVideo:(WSVideo *)video{
    
    _video = video;
    
    self.videoDetailLbl.text = video.desc;
    self.videoTitleLbl.text = video.title;
//    self.videoImgView.contentMode = UIViewContentModeCenter;
    [self.videoImgView sd_setImageWithURL:[NSURL URLWithString:video.cover] placeholderImage:[UIImage imageNamed:@"cell_image_background"]];
//    [self.videoTimeBtn setTitle:video.ptime forState:UIControlStateNormal];
//    [self.videoCommentBtn setTitle:video.replyCount forState:UIControlStateNormal];
//    [self.videoLookBtn setTitle:video.playCount forState:UIControlStateNormal];
    
}

+ (CGFloat)rowHeight{
    
    return 280;
}


+ (instancetype)videoCellWithTableView:(UITableView *)tableView{
    
    WSVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"videoCell"];
    
    return cell;
}

@end
