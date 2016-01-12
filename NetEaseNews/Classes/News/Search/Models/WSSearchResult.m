//
//  WSSearchResult.m
//  网易新闻
//
//  Created by WackoSix on 16/1/10.
//  Copyright © 2016年 WackoSix. All rights reserved.
//

#import "WSSearchResult.h"

@implementation WSSearchResult


+ (void)searchResultWithKey:(NSString *)key result:(GetDataSuccessBlock)result{
    
    
    NSString *urlStr = [NSString stringWithFormat:@"/search/comp/MA%%3D%%3D/20/%@.html?deviceId=NDE5NzAwMEItQTNFQi00OUVBLUI2NjktQkZEMzE0MTMxNUM1&version=NS41LjA%%3D&channel=5aS05p2h",[self base64Encoder:key]];
    
    [WSGetDataTool GETJSON:urlStr GetDataType:WSGETDataTypeBaseURL progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSArray *dictArr = responseObject[@"doc"][@"result"];
        
        NSMutableArray *arrM = [NSMutableArray array];
        for (NSDictionary *dict in dictArr) {
            
            WSSearchResult *result = [WSSearchResult resultWithDict:dict];
            [arrM addObject:result];
        }
        
        if (arrM.count>0) {
            
            result(arrM.copy);
        }
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

+(NSString *)base64Encoder:(NSString *)originalStr{
    
    NSData *data = [originalStr dataUsingEncoding:NSUTF8StringEncoding];
    
    return [data base64EncodedStringWithOptions:0];
}

+ (instancetype)resultWithDict:(NSDictionary *)dict{
    
    id obj = [[self alloc] init];
    
    [obj setValuesForKeysWithDictionary:dict];
    
    return obj;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{}

@end
