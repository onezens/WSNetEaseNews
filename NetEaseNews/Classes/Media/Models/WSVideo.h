//
//  WSVideo.h
//  NetEaseNews
//
//  Created by WackoSix on 16/1/12.
//  Copyright © 2016年 WackoSix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YHCoderObject.h"
#import "WSGetDataTool.h"

@interface WSVideo : YHCoderObject

/**回复人数*/
@property (assign, nonatomic) NSInteger replyCount;
/**视频来源*/
@property (copy, nonatomic) NSString *videosource;
/**视频高清url*/
@property (copy, nonatomic) NSString *mp4Hd_url;
/**视频截图*/
@property (copy, nonatomic) NSString *cover;
/**视频名称*/
@property (copy, nonatomic) NSString *title;
/**视频播放人数*/
@property (assign, nonatomic) NSInteger playCount;
/**"replyBoard": "videonews_bbs"*/
@property (copy, nonatomic) NSString *replyBoard;
@property (copy, nonatomic) NSString *replyid;
/**视频描述*/
@property (copy, nonatomic) NSString *desc;
/**视频播放的url*/
@property (copy, nonatomic) NSString *mp4_url;
/**视频长度*/
@property (assign, nonatomic) NSInteger length;
@property (assign, nonatomic) NSInteger playersize;
@property (copy, nonatomic) NSString *vid;
@property (copy, nonatomic) NSString *m3u8_url;
@property (copy, nonatomic) NSString *ptime;
@property (copy, nonatomic) NSString *m3u8Hd_url;


+ (void)videosWithIndex:(NSInteger)index cache:(BOOL)cache getDataSuccess:(GetDataSuccessBlock)success videoSidList:(void (^)(NSArray *list))list getDataFailure:(GetDataFailureBlock)failure;

+ (NSArray *)cacheData;

@end
