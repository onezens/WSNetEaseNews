//
//  WSComment.h
//  网易新闻
//
//  Created by WackoSix on 16/1/1.
//  Copyright © 2016年 WackoSix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSGetDataTool.h"

typedef enum {
    
    WSCommentTypeContentNormal, //正常最新评论
    WSCommentTypeContentHot,  //热门评论
    WSCommentTypeImageContentNormal, //正常最新评论
    WSCommentTypeImageContentHot,  //热门评论
    
}WSCommentType;

@interface WSComment : NSObject

@property (copy, nonatomic) NSString *a;

/**用户评论*/
@property (copy, nonatomic) NSString *b;

@property (copy, nonatomic) NSString *bi;

@property (copy, nonatomic) NSString *d;

@property (copy, nonatomic) NSString *ut;
/**用户位置*/
@property (copy, nonatomic) NSString *f;

@property (copy, nonatomic) NSString *uturl;

@property (copy, nonatomic) NSString *fi;

@property (assign, nonatomic) BOOL vip;

@property (copy, nonatomic) NSString *ip;

@property (copy, nonatomic) NSString *l;

@property (copy, nonatomic) NSString *utinfo;

@property (copy, nonatomic) NSString *label;
/**用户昵称*/
@property (copy, nonatomic) NSString *n;

@property (copy, nonatomic) NSString *p;

@property (copy, nonatomic) NSString *pi;

@property (copy, nonatomic) NSString *rp;

@property (copy, nonatomic) NSString *source;

/**评论发表时间*/
@property (copy, nonatomic) NSString *t;

/**用户头像*/
@property (copy, nonatomic) NSString *timg;

@property (copy, nonatomic) NSString *u;

/**评论点赞数*/
@property (copy, nonatomic) NSString *v;

+ (instancetype)commentWithDict:(NSDictionary *)dict;

+ (void)commentWithID:(NSString *)ID index:(NSInteger)index type:(WSCommentType)type getDataSuccess:(GetDataSuccessBlock)success getDataFailure:(GetDataFailureBlock)falilure;

@end
