//
//  WSNewsCell.m
//  网易新闻
//
//  Created by WackoSix on 16/1/9.
//  Copyright © 2016年 WackoSix. All rights reserved.
//

#import "WSNewsCell.h"
#import "UIImageView+WebCache.h"
#import "WSNews.h"
#import "WSImageView.h"
#import "NSString+WS.h"

@interface WSNewsCell ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *replyCountBtnWidth;
@property (weak, nonatomic) IBOutlet WSImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *detailLbl;
@property (weak, nonatomic) IBOutlet UIButton *replyCountBtn;
@property (strong, nonatomic) IBOutletCollection(WSImageView) NSArray *extraImageViews;
@property (assign, nonatomic) WSNewsCellType cellType;

@end

static NSString * normalID = @"normalCell";
static NSString * bigImageID = @"bigImageCell";
static NSString * threeImageID = @"threeImageCell";

@implementation WSNewsCell

+ (CGFloat)rowHeighWithCellType:(WSNewsCellType)type{
    
    switch (type) {
        case WSNewsCellTypeNormal:
            return 80;
            break;
        case WSNewsCellTypeBigImage:
            return 180;
            break;
        case WSNewsCellTypeThreeImage:
            return 120;
            break;
            
        default:
            break;
    }
}

+ (instancetype)newsCellWithTableView:(UITableView *)tableview cellNews:(WSNews *)news{
    
    WSNewsCell *cell = nil;
    
    if (news.imgextra.count == 2){
        
        cell = [tableview dequeueReusableCellWithIdentifier:threeImageID];
        cell.cellType = WSNewsCellTypeThreeImage;
        
    }else if (news.imgType){
        
        cell = [tableview dequeueReusableCellWithIdentifier:bigImageID];
        cell.cellType = WSNewsCellTypeBigImage;
    }else{
        
        cell = [tableview dequeueReusableCellWithIdentifier:normalID];
        cell.cellType = WSNewsCellTypeNormal;
    }
        
    [cell setNews:news];
    
    return cell;
}


- (void)setNews:(WSNews *)news{
    
    _news = news;
    
    self.iconView.contentMode = UIViewContentModeCenter;
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:news.imgsrc] placeholderImage:[UIImage imageNamed:@"cell_image_background"]];
    self.titleLbl.text = news.title;
    self.detailLbl.text = news.digest;
    [self.replyCountBtn setTitle:[NSString stringWithFormat:@"%ld跟帖",news.replyCount] forState:UIControlStateNormal];
    for (NSInteger i=0; i<news.imgextra.count; i++) {
        
        UIImageView *imgView = self.extraImageViews[i];
        imgView.contentMode = UIViewContentModeCenter;
        [imgView sd_setImageWithURL:[NSURL URLWithString:news.imgextra[i][@"imgsrc"]] placeholderImage:[UIImage imageNamed:@"cell_image_background"]];
    }
    
    CGSize fontSize = [self.replyCountBtn.titleLabel.text sizeOfFont:self.replyCountBtn.titleLabel.font textMaxSize:CGSizeMake(125, 21)];
    self.replyCountBtnWidth.constant = fontSize.width + 8;
}


@end
