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
#import "NSString+WS.h"

@interface WSVideoCell ()

@property (weak, nonatomic) IBOutlet UILabel *videoTitleLbl;
@property (weak, nonatomic) IBOutlet UILabel *videoDetailLbl;
@property (weak, nonatomic) IBOutlet UIImageView *videoImgView;
@property (weak, nonatomic) IBOutlet UIButton *videoTimeBtn;
@property (weak, nonatomic) IBOutlet UIButton *videoLookBtn;
@property (weak, nonatomic) IBOutlet UIButton *videoCommentBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *timeBtnWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *playCountBtnWidth;


@end

@implementation WSVideoCell

- (void)setVideo:(WSVideo *)video{
    
    _video = video;
    
    self.videoDetailLbl.text = video.desc;
    self.videoTitleLbl.text = video.title;
//    self.videoImgView.contentMode = UIViewContentModeCenter;
    [self.videoImgView sd_setImageWithURL:[NSURL URLWithString:video.cover] placeholderImage:[UIImage imageNamed:@"cell_image_background"]];
    
    [self.videoCommentBtn setTitle:[NSString stringWithFormat:@"%ld",video.replyCount] forState:UIControlStateNormal];
    [self.videoLookBtn setTitle:[NSString stringWithFormat:@"%ld",video.playCount] forState:UIControlStateNormal];
    CGFloat t = (float)video.length / 60;
    NSString *time = [NSString stringWithFormat:@"%02.f:%02.f",t,(t-(int)t)*100];
    [self.videoTimeBtn setTitle:time forState:UIControlStateNormal];
    self.timeBtnWidth.constant = [self.videoTimeBtn.titleLabel.text sizeOfFont:self.videoTimeBtn.titleLabel.font textMaxSize:CGSizeMake(125, 21)].width + 25;
    self.playCountBtnWidth.constant = [self.videoLookBtn.titleLabel.text sizeOfFont:self.videoLookBtn.titleLabel.font textMaxSize:CGSizeMake(125, 21)].width + 30;
    
}

+ (CGFloat)rowHeight{
    
    return 280;
}




+ (instancetype)videoCellWithTableView:(UITableView *)tableView{
    
    WSVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"videoCell"];

    
    return cell;
}

@end
