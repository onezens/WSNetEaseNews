

//
//  WSTopic.m
//  网易新闻
//
//  Created by WackoSix on 16/1/10.
//  Copyright © 2016年 WackoSix. All rights reserved.
//

#import "WSTopic.h"

@implementation WSTopic


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{}

+ (void)topicWithIndex:(NSInteger)index isCache:(BOOL)cache getDataSuccess:(GetDataSuccessBlock)success getDataFaileure:(GetDataFailureBlock)failure{
    
    NSString *urlStr = [NSString stringWithFormat:@"newstopic/list/expert/%ld-%ld.html",index, index+10];
    
    [WSGetDataTool GETJSON:urlStr GetDataType:WSGETDataTypeBaseURL progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSArray *dictArr = responseObject[@"data"][@"expertList"];
        
        NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:dictArr.count];
        
        for (NSDictionary *dict in dictArr) {
            
            WSTopic *topic = [WSTopic topicWithDict:dict];
            [arrM addObject:topic];
        }
        
        if(cache && arrM.copy>0){
            
            NSString *filePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
            filePath  = [filePath stringByAppendingPathComponent:@"topic.data"];
            [NSKeyedArchiver archiveRootObject:arrM toFile:filePath];
        }
        
        
        success(arrM.copy);
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        failure(error);
        
    }];
}

+ (NSArray *)cacheTopic{
    
    NSString *filePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    filePath  = [filePath stringByAppendingPathComponent:@"topic.data"];
    
    return [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
}


+ (instancetype)topicWithDict:(NSDictionary *)dict{
    
    id obj = [[self alloc] init];
    
    [obj setDesc:dict[@"description"]];
    
    [obj setValuesForKeysWithDictionary:dict];
    
    return obj;
}

@end
