//
//  WSGetDataTool.h
//  网易新闻
//
//  Created by WackoSix on 16/1/6.
//  Copyright © 2016年 WackoSix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef enum {
    
    WSGETDataTypeBaseURL, // 通过baseurl获取数据
    WSGETDataTypeCommentURL  //通过评论的url获取数据
    
}WSGETDataType;

typedef void(^progressBlock)(NSProgress *downloadProgress);
typedef void(^successBlock)(NSURLSessionDataTask * task, id responseObject);
typedef void(^failureBlock)(NSURLSessionDataTask * task, NSError *error);
typedef void(^GetDataSuccessBlock)(NSArray *dataArr);
typedef void(^GetDataFailureBlock)(NSError *error);


@interface WSGetDataTool : AFHTTPSessionManager


+ (NSURLSessionDataTask *)GETJSON:(NSString *)urlStr GetDataType:(WSGETDataType)type progress:(progressBlock)progress success:(successBlock)success failure: (failureBlock)failure;

@end
