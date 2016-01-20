//
//  WSImageCell.m
//  网易新闻
//
//  Created by WackoSix on 16/1/5.
//  Copyright © 2016年 WackoSix. All rights reserved.
//

#import "WSImageCell.h"
#import "NSString+WS.h"
#import "WSPhoto.h"
#import "UIImageView+WebCache.h"
#import "WSImageContent.h"

@interface WSImageCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) UILabel *titleLbl;
@property (weak, nonatomic) UILabel *imageCountLbl;
@property (weak, nonatomic) UILabel *detailLbl;
@property (weak, nonatomic) UIScrollView *textScrollView;
@property (weak, nonatomic) UIView *textView;

@end

@implementation WSImageCell


- (void)setIndexPath:(NSIndexPath *)indexPath{
    
    _indexPath = indexPath;
    
    self.titleLbl.text = self.imageContent.setname;
    self.imageCountLbl.text = [NSString stringWithFormat:@"%ld/%ld",indexPath.item+1,self.imageContent.photos.count];
    self.detailLbl.text = [self.imageContent.photos[indexPath.item] note];
    

    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:[self.imageContent.photos[indexPath.item] imgurl]] placeholderImage:[UIImage imageNamed:@"contentview_imagebg_logo"] options:SDWebImageProgressiveDownload | SDWebImageHighPriority completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    }];
    
    [self loadSubViewFrame];
    
}

- (instancetype)init{
    
    if (self = [super init]) {
        
    }
    return self;
}



-(void)awakeFromNib{
    
    //加一个内容scrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    [self addSubview:scrollView];
    self.textScrollView = scrollView;
    scrollView.scrollEnabled = YES;
    scrollView.showsVerticalScrollIndicator = NO;
//    scrollView.backgroundColor = [UIColor greenColor];
    
    
    //textView
    UIView *textView = [[UIView alloc] init];
    [scrollView addSubview:textView];
    self.textView = textView;
    textView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
    
    //标题
    UILabel *titleLbl = [[UILabel alloc] init];
    [textView addSubview:titleLbl];
    self.titleLbl = titleLbl;
    titleLbl.numberOfLines = 0;
    titleLbl.textColor = [UIColor whiteColor];
    titleLbl.font = [UIFont systemFontOfSize:16];
    
    //图片索引
    UILabel *imageCountLbl = [[UILabel alloc] init];
    [textView addSubview:imageCountLbl];
    self.imageCountLbl = imageCountLbl;
    imageCountLbl.textColor = [UIColor whiteColor];
    imageCountLbl.font = [UIFont systemFontOfSize:14];
    
    //图片详情
    UILabel *detailLbl = [[UILabel alloc] init];
    [textView addSubview:detailLbl];
    self.detailLbl = detailLbl;
    detailLbl.numberOfLines = 0;
    detailLbl.textColor = [UIColor whiteColor];
    detailLbl.font = [UIFont systemFontOfSize:14];
    
}

- (void)loadSubViewFrame {
    
    CGFloat margin = 8;
    
    CGSize imageCountSize = [self.imageCountLbl.text sizeOfFont:self.imageCountLbl.font textMaxSize:CGSizeMake(100, 21)];
    self.imageCountLbl.frame = CGRectMake(kScreenWidth - margin - imageCountSize.width, margin, imageCountSize.width, imageCountSize.height);
    
    CGSize titleSize = [self.titleLbl.text sizeOfFont:self.titleLbl.font textMaxSize:CGSizeMake(kScreenWidth - imageCountSize.width - margin * 3, MAXFLOAT)];
    self.titleLbl.frame = CGRectMake(margin, margin, titleSize.width, titleSize.height);
    
    CGSize detailSize = [self.detailLbl.text sizeOfFont:self.detailLbl.font textMaxSize:CGSizeMake(kScreenWidth - margin * 2, MAXFLOAT)];
    self.detailLbl.frame = CGRectMake(margin, CGRectGetMaxY(self.titleLbl.frame) + margin, detailSize.width, detailSize.height);
    
    
    self.textView.frame = CGRectMake(0, self.textScrollView.frame.size.height - 100, kScreenWidth, CGRectGetMaxY(self.detailLbl.frame) + margin + 20);
    
    self.textScrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.textView.frame) + margin);
    
    
    
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.textScrollView.frame = CGRectMake(0, self.bounds.size.height * 0.5-20, self.bounds.size.width, self.bounds.size.height*0.5 + 20);
    
    [self loadSubViewFrame];
}


@end
