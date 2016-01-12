//
//  WSTopicDetail.h
//  网易新闻
//
//  Created by WackoSix on 16/1/11.
//  Copyright © 2016年 WackoSix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSGetDataTool.h"
#import "YHCoderObject.h"
@class WSAnswer, WSQuesiton;

@interface WSTopicDetail : YHCoderObject

@property (strong, nonatomic) WSQuesiton *question;
@property (strong, nonatomic) WSAnswer *answer;

+ (void)topDetailWithIndex:(NSInteger)index isCache:(BOOL)cache expertID:(NSString *)ID getDataSuccess:(GetDataSuccessBlock)success getDataFailure:(GetDataFailureBlock)failure;

+ (NSArray *)cacheWithExpertID:(NSString *)ID;
@end
