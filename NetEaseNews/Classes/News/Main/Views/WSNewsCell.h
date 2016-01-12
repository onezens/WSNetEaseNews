//
//  WSNewsCell.h
//  网易新闻
//
//  Created by WackoSix on 16/1/9.
//  Copyright © 2016年 WackoSix. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WSNews;

typedef enum {
    
    WSNewsCellTypeNormal, //正常显示
    WSNewsCellTypeBigImage,  //大图展示
    WSNewsCellTypeThreeImage //三张图片展示
    
}WSNewsCellType;

@interface WSNewsCell : UITableViewCell

@property (strong, nonatomic) WSNews *news;

+ (instancetype)newsCellWithTableView:(UITableView *)tableview cellNews:(WSNews *)news;

+ (CGFloat)rowHeighWithCellType:(WSNewsCellType)type;

@end
