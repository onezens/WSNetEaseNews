//
//  WSReaderCell.m
//  网易新闻
//
//  Created by WackoSix on 16/1/10.
//  Copyright © 2016年 WackoSix. All rights reserved.
//

#import "WSReaderCell.h"
#import "WSImageView.h"
#import "WSNews.h"
#import "UIImageView+WebCache.h"

@interface WSReaderCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *detailLbl;
@property (weak, nonatomic) IBOutlet WSImageView *imgView;
@property (strong, nonatomic) IBOutletCollection(WSImageView) NSArray *images;

@end

static NSString * normalID = @"readerNormalCell";
static NSString * mulImageID = @"readerMulCell";

@implementation WSReaderCell


+ (CGFloat)rowHeightWithCellType:(WSReaderCellType)type{
    
    if (type == WSReaderCellTypeNormal) {
        
        return 100;
    }else if(type == WSReaderCellTypeMulImage){
        
        return 200;
    }
    
    return 0;
}

+ (instancetype)readerCellWithTableView:(UITableView *)tableView cellType:(WSReaderCellType)type{
    
    NSString *ID = nil;
    
    if (type == WSReaderCellTypeNormal) {
        ID = normalID;
    }else if (type == WSReaderCellTypeMulImage){
        
        ID = mulImageID;
    }
    
    WSReaderCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    
    return cell;
}

- (void)setNews:(WSNews *)news{
    
    _news = news;
    
    self.titleLbl.text = news.title;
    self.detailLbl.text = news.source;
    self.imgView.contentMode = UIViewContentModeCenter;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:news.imgsrc] placeholderImage:[UIImage imageNamed:@"cell_image_background"]];
    for (NSInteger i=0; i<news.imgnewextra.count; i++) {
        
        UIImageView *imgView = self.images[i];
        imgView.contentMode = UIViewContentModeCenter;
        [imgView sd_setImageWithURL:[NSURL URLWithString:news.imgnewextra[i][@"imgsrc"]] placeholderImage:[UIImage imageNamed:@"cell_image_background"]];
    }
}

@end
