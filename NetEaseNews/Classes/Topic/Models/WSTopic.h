//
//  WSTopic.h
//  网易新闻
//
//  Created by WackoSix on 16/1/10.
//  Copyright © 2016年 WackoSix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSGetDataTool.h"
#import "YHCoderObject.h"

@interface WSTopic : YHCoderObject

/**专题标识*/
@property (copy, nonatomic) NSString *expertId;

/**个人介绍*/
@property (copy, nonatomic) NSString *alias;

/**图片url*/
@property (copy, nonatomic) NSString *picurl;

/**姓名*/
@property (copy, nonatomic) NSString *name;

/**详细描述*/
@property (copy, nonatomic) NSString *desc;

/**头像url*/
@property (copy, nonatomic) NSString *headpicurl;

/**专题分类*/
@property (copy, nonatomic) NSString *classification;

@property (copy, nonatomic) NSString *state;

@property (copy, nonatomic) NSString *expertState;

/**关注人数*/
@property (copy, nonatomic) NSString *concernCount;

@property (copy, nonatomic) NSString *createTime;

/**专题人身份*/
@property (copy, nonatomic) NSString *title;

+ (void)topicWithIndex:(NSInteger)index isCache:(BOOL)cache getDataSuccess:(GetDataSuccessBlock)success getDataFaileure:(GetDataFailureBlock)failure;
+ (NSArray *)cacheTopic;



@end
