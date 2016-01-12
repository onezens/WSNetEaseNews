//
//  WSContent.m
//  网易新闻
//
//  Created by WackoSix on 15/12/31.
//  Copyright © 2015年 WackoSix. All rights reserved.
//

#import "WSContent.h"

static NSString const * contentURL = @"/nc/article/<tid>/full.html";

@implementation WSContent

+ (void)contentWithNewsID:(NSString *)tid getDataSucces:(void (^)(WSContent *))success getDataFailure:(GetDataFailureBlock)failure{
    
    NSString *urlStr = [contentURL stringByReplacingOccurrencesOfString:@"<tid>" withString:tid];
    
    [WSGetDataTool GETJSON:urlStr GetDataType:WSGETDataTypeBaseURL progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        WSContent *content = [self contentWithDict:responseObject[[[responseObject keyEnumerator] nextObject]]];
        
        success(content);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        failure(error);
    }];
}

+ (instancetype)contentWithDict:(NSDictionary *)dict{
    
    id obj = [[self alloc] init];
    
    [obj setValuesForKeysWithDictionary:dict];
    
     [obj setSource:dict[@"source"] ? : @""];
    
    return obj;
}



- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    
}

@end
