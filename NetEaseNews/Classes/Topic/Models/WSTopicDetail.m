//
//  WSTopicDetail.m
//  网易新闻
//
//  Created by WackoSix on 16/1/11.
//  Copyright © 2016年 WackoSix. All rights reserved.
//

#import "WSTopicDetail.h"
#import "WSAnswer.h"
#import "WSQuesiton.h"

@implementation WSTopicDetail


+ (void)topDetailWithIndex:(NSInteger)index isCache:(BOOL)cache expertID:(NSString *)ID getDataSuccess:(GetDataSuccessBlock)success getDataFailure:(GetDataFailureBlock)failure{
    
    NSString *urlStr = [NSString stringWithFormat:@"newstopic/list/latestqa/%@/%ld-%ld.html",ID ,index, index+10];
    
    [WSGetDataTool GETJSON:urlStr GetDataType:WSGETDataTypeBaseURL progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSArray *dictArr = responseObject[@"data"];
        
        NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:dictArr.count];
        
        for (NSDictionary *dict in dictArr) {
            
            WSTopicDetail *td = [WSTopicDetail topicDetailWithDict:dict];
            [arrM addObject:td];
        }
        
        if(cache && arrM.count>0){
            
            NSString *filePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
            filePath  = [filePath stringByAppendingFormat:@"/%@.data",ID];
            [NSKeyedArchiver archiveRootObject:arrM toFile:filePath];
            
        }
        
        success(arrM.copy);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        failure(error);
    }];
}


+ (NSArray *)cacheWithExpertID:(NSString *)ID{
    
    NSString *filePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    filePath  = [filePath stringByAppendingFormat:@"/%@.data",ID];

    return [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
}

+ (instancetype)topicDetailWithDict:(NSDictionary *)dict{
    
    id obj = [[self alloc] init];
    
    [obj setValuesForKeysWithDictionary:dict];
    
    return obj;
}

- (void)setQuestion:(NSDictionary *)question{
    
    WSQuesiton *q = [WSQuesiton quesitonWithDict:question];
    
    _question = q;
    
}

- (void)setAnswer:(NSDictionary *)answer{
    
    WSAnswer *obj = [WSAnswer answerWithDict:answer];
    
    _answer = obj;
    
}

@end
