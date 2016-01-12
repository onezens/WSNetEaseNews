//
//  WSContent.h
//  网易新闻
//
//  Created by WackoSix on 15/12/31.
//  Copyright © 2015年 WackoSix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSGetDataTool.h"

@interface WSContent : NSObject

@property (copy, nonatomic) NSString *ptime;

@property (copy, nonatomic) NSString *source;

@property (copy, nonatomic) NSString *ec;

@property (strong, nonatomic) NSArray *link;

@property (copy, nonatomic) NSString *title;

@property (copy, nonatomic) NSString *sourceinfo;

@property (copy, nonatomic) NSString *source_url;

@property (copy, nonatomic) NSString *tid;

@property (strong, nonatomic) NSArray *boboList;

@property (strong, nonatomic) NSArray *apps;

@property (strong, nonatomic) NSArray *img;

@property (strong, nonatomic) NSArray *topiclist_news;

@property (strong, nonatomic) NSArray *ydbaike;

@property (copy, nonatomic) NSString *docid;

@property (assign, nonatomic) NSInteger picnews;

@property (assign, nonatomic) NSInteger replyBoard;

@property (assign, nonatomic) NSInteger replyCount;

@property (copy, nonatomic) NSString *template;

@property (strong, nonatomic)  NSArray *video;

@property (assign, nonatomic) BOOL hasNext;

@property (strong, nonatomic) NSArray *topiclist;

@property (copy, nonatomic) NSString *body;

@property (strong, nonatomic) NSArray *keyword_search;

@property (strong, nonatomic) NSArray *votes;

@property (assign, nonatomic) NSInteger threadAgainst;

@property (copy, nonatomic) NSString *voicecomment;

@property (copy, nonatomic) NSString *dkeys;

/**语音*/
@property (copy, nonatomic) NSString *rewards;

@property (strong, nonatomic) NSArray *users;

@property (strong, nonatomic) NSArray *spinfo;

@property (assign, nonatomic) NSInteger threadVote;

@property (strong, nonatomic) NSArray *relative_sys;

@property (copy, nonatomic) NSString *digest;

+ (instancetype)contentWithDict:(NSDictionary *)dict;

+ (void)contentWithNewsID:(NSString *)tid getDataSucces:(void (^)(WSContent *content))success getDataFailure:(GetDataFailureBlock)failure;

@end
