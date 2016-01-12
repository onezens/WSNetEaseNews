


//
//  WSVideo.m
//  NetEaseNews
//
//  Created by WackoSix on 16/1/12.
//  Copyright © 2016年 WackoSix. All rights reserved.
//

#import "WSVideo.h"

@implementation WSVideo

+ (void)videosWithIndex:(NSInteger)index cache:(BOOL)cache getDataSuccess:(GetDataSuccessBlock)success videoSidList:(void (^)(NSArray *))list getDataFailure:(GetDataFailureBlock)failure{
    
    NSString *urlStr = [NSString stringWithFormat:@"nc/video/home/%ld-%ld.html",index , index+10];
    
    [WSGetDataTool GETJSON:urlStr GetDataType:WSGETDataTypeBaseURL progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        //视频模块顶部数据
        if ([responseObject[@"videoSidList"] count] > 0) {
            
            list(responseObject[@"videoSidList"]);
        }
        
        
        NSArray *dictArr = responseObject[@"videoList"];
        
        NSMutableArray *arrM = [NSMutableArray array];
        
        for (NSDictionary *dict in dictArr) {
            
            WSVideo *video = [WSVideo videoWithDict:dict];
            [arrM addObject:video];
        }
        
        if (cache && arrM.count > 0) {
            
            [NSKeyedArchiver archiveRootObject:arrM toFile:[self cachePath]];
        }
        
        success(arrM.copy);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        failure(error);
    }];
}

+ (NSString *)cachePath{
    
    NSString *filePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    
    return [filePath stringByAppendingPathComponent:@"video.data"];
}

+ (NSArray *)cacheData{
    
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[self cachePath]];
}


+ (instancetype)videoWithDict:(NSDictionary *)dict{
    
    id obj = [[self alloc] init];
    
    
    [obj setValuesForKeysWithDictionary:dict];
    [obj setDesc:dict[@"description"]];
    
    return obj;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{}

@end
