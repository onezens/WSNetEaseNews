//
//  WSDayNewsCell.m
//  网易新闻
//
//  Created by WackoSix on 16/1/10.
//  Copyright © 2016年 WackoSix. All rights reserved.
//

#import "WSDayNewsCell.h"
#import "NSString+WS.h"
#import "WSNews.h"
#import "UIImageView+WebCache.h"

@interface WSDayNewsCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLbl;

@property (weak, nonatomic) IBOutlet UILabel *detailLbl;
@property (weak, nonatomic) IBOutlet UIButton *replyCountBtn;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *replyBtnWidth;

@end

static NSString * ID1 = @"topCell";
static NSString * ID2 = @"normalNewsCell";

@implementation WSDayNewsCell

+ (CGFloat)rowHeightWithIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row ==0) return 216;
    
    return 100;
}

+ (instancetype)dayNewsCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    
    WSDayNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:indexPath.row==0 ? ID1 :ID2];
    
    return cell;
}


- (void)setNews:(WSNews *)news{
    
    _news = news;
    self.imgView.contentMode = UIViewContentModeCenter;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:news.imgsrc] placeholderImage:[UIImage imageNamed:@"cell_image_background"]];
    self.titleLbl.text = news.title;
    self.detailLbl.text = news.digest;
    [self.replyCountBtn setTitle:[NSString stringWithFormat:@"%ld",news.replyCount] forState:UIControlStateNormal];
    CGSize fontSize = [self.replyCountBtn.titleLabel.text sizeOfFont:self.replyCountBtn.titleLabel.font textMaxSize:CGSizeMake(125, 21)];
    self.replyBtnWidth.constant = fontSize.width + 8;
}


@end
