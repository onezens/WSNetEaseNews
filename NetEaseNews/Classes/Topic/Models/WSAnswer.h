//
//  WSAnswer.h
//  网易新闻
//
//  Created by WackoSix on 16/1/11.
//  Copyright © 2016年 WackoSix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YHCoderObject.h"

@interface WSAnswer : YHCoderObject

@property (copy, nonatomic) NSString *answerId;
@property (copy, nonatomic) NSString *board;
@property (copy, nonatomic) NSString *commentId;
@property (copy, nonatomic) NSString *relatedQuestionId;
@property (copy, nonatomic) NSString *content;
@property (copy, nonatomic) NSString *specialistName;
@property (copy, nonatomic) NSString *specialistHeadPicUrl;
@property (copy, nonatomic) NSString *supportCount;
@property (copy, nonatomic) NSString *replyCount;
@property (copy, nonatomic) NSString *cTime;

+ (instancetype)answerWithDict:(NSDictionary *)dict;

@end
