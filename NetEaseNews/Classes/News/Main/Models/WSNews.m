//
//  WSContent.m
//  网易新闻
//
//  Created by WackoSix on 15/12/29.
//  Copyright © 2015年 WackoSix. All rights reserved.
//

#import "WSNews.h"
#import "WSAds.h"


@implementation WSNews

+ (void)newsListDataWithNewsID:(NSString *)newsID newsCache:(BOOL)isCache getDataSuccess:(GetDataSuccessBlock)success getFailure:(GetDataFailureBlock)failure{
    
    
    [WSGetDataTool GETJSON:newsID GetDataType:WSGETDataTypeBaseURL progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dict = responseObject;
        NSEnumerator *keyEnum = dict.keyEnumerator;
        NSString *key = keyEnum.nextObject;
        NSArray *dictArr = dict[key];
    
        NSMutableArray *arrM = [NSMutableArray array];
        
        for (NSDictionary *dict in dictArr) {
            
            WSNews *news = [self contentWithDict:dict];
            [arrM addObject:news];
        }
        
        if (isCache) {
            NSString *filePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
            filePath = [filePath stringByAppendingFormat:@"/%@.plist",key];
            [dictArr writeToFile:filePath atomically:NO];
        }
        
        success(arrM.copy);
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
       
        failure(error);
        
    }];

}

+ (NSArray *)cacheFileArrWithChannelID:(NSString *)channelID{
    
    NSString *filePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    filePath = [filePath stringByAppendingFormat:@"/%@.plist",channelID];
    
    NSArray *dictArr = [NSArray arrayWithContentsOfFile:filePath];
    
    NSMutableArray *arrM = [NSMutableArray array];
    
    for (NSDictionary * dict in dictArr) {
        
        WSNews *news = [WSNews contentWithDict:dict];
        [arrM addObject:news];
    }
    
    return arrM;
}


+ (instancetype)contentWithDict:(NSDictionary *)dict{
    
    WSNews *obj = [[self alloc] init];
    
    [obj setValuesForKeysWithDictionary:dict];
    
    return obj;
}

- (void)setAds:(NSArray *)ads{
    
    NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:ads.count];
    
    for (NSDictionary *dict in ads) {
        
        WSAds *ad = [WSAds adsWithDict:dict];
        [arrM addObject:ad];
    }
    _ads = [arrM copy];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    
}

@end
