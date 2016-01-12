//
//  WSContent.h
//  网易新闻
//
//  Created by WackoSix on 15/12/29.
//  Copyright © 2015年 WackoSix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSGetDataTool.h"


@interface WSNews : NSObject

@property (assign, nonatomic) NSInteger upTimes;

@property (strong, nonatomic) NSArray *unlikeReason;

@property (copy, nonatomic) NSString *recReason;

@property (copy, nonatomic) NSString *specialID;

@property (copy, nonatomic) NSString *specialtip;

@property (strong, nonatomic) NSDictionary *live_info;

@property (strong, nonatomic) NSArray *imgnewextra;

@property (copy, nonatomic) NSString *videoID;

@property (copy, nonatomic) NSString *specialadlogo;

@property (copy, nonatomic) NSString *tname;

@property (copy, nonatomic) NSString *hasImg;

@property (assign, nonatomic) NSInteger hasCover;

@property (assign, nonatomic) NSInteger hasIcon;

@property (copy, nonatomic) NSString *cid;

@property (copy, nonatomic) NSString *ename;

@property (copy, nonatomic) NSString *url_3w;

@property (copy, nonatomic) NSString *boardid;

@property (copy, nonatomic) NSString *url;

@property (copy, nonatomic) NSString *order;

@property (copy, nonatomic) NSString *alias;

@property (copy, nonatomic) NSString *priority;

@property (copy, nonatomic) NSString *votecount;

@property (copy, nonatomic) NSString *editor;

/**广告数组*/
@property (strong, nonatomic) NSArray *ads;

/**内容的标题*/
@property (copy, nonatomic) NSString *title;

@property (copy, nonatomic) NSString *template;

@property (copy, nonatomic) NSString *source;

@property (copy, nonatomic) NSString *replyid;

/**内容回复的人数*/
@property (assign, nonatomic) NSInteger replyCount;

@property (assign, nonatomic) NSInteger recType;

@property (copy, nonatomic) NSString *ptime;

@property (copy, nonatomic) NSString *program;

@property (assign, nonatomic) NSInteger picCount;

@property (copy, nonatomic) NSString *lmodify;

@property (copy, nonatomic) NSString *interest;
/**内容的类型标识*/
@property (copy, nonatomic) NSString *tag;

@property (copy, nonatomic) NSString *skipID;

@property (copy, nonatomic) NSString *skipType;
/**图片内容的标识*/
@property (copy, nonatomic) NSString *photosetID;

@property (copy, nonatomic) NSString *hasHead;

@property (copy, nonatomic) NSString *prompt;

@property (copy, nonatomic) NSString *pixel;

@property (copy, nonatomic) NSString *videosource;

/**图片数组*/
@property (strong, nonatomic) NSArray *imgextra;

/**内容图片标识*/
@property (assign, nonatomic) NSInteger imgType;

/**内容图片URL*/
@property (copy, nonatomic) NSString *imgsrc;

/**内容图片URL*/
@property (copy, nonatomic) NSString *img;

@property (copy, nonatomic) NSString *id;

/**内容下载次数*/
@property (assign, nonatomic) NSInteger downTimes;

@property (copy, nonatomic) NSString *docid;

@property (copy, nonatomic) NSString *subtitle;

/**内容的描述*/
@property (copy, nonatomic) NSString *digest;

@property (copy, nonatomic) NSString *hasAD;

/**内容图片标识*/
@property (copy, nonatomic) NSString *TAG;

@property (copy, nonatomic) NSString *TAGS;

@property (assign, nonatomic) NSInteger clkNum;


+ (void)newsListDataWithNewsID:(NSString *)newsID newsCache:(BOOL)isCache getDataSuccess:(GetDataSuccessBlock)success getFailure:(GetDataFailureBlock)failure;

+ (NSArray *)cacheFileArrWithChannelID:(NSString *)channelID;

@end
