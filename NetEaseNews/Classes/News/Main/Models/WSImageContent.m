//
//  WSImageContent.m
//  网易新闻
//
//  Created by WackoSix on 16/1/2.
//  Copyright © 2016年 WackoSix. All rights reserved.
//

#import "WSImageContent.h"
#import "WSPhoto.h"

static NSString const * imageContentURL = @"/photo/api/set/";

@implementation WSImageContent

+ (void)imageContentWithPhotoID:(NSString *)photoid getDataSuccess:(void (^)(WSImageContent *))success getDataFailure:(GetDataFailureBlock)failure{
    
    NSString *one = [photoid substringFromIndex:4];
    NSArray *components = [one componentsSeparatedByString:@"|"];
    NSString *urlStr = [imageContentURL stringByAppendingFormat:@"%@/%@.json",components[0],components[1]];
    
    [WSGetDataTool GETJSON:urlStr GetDataType:WSGETDataTypeBaseURL progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
         id dict = responseObject[[[responseObject keyEnumerator] nextObject]];
        
        WSImageContent *content = [dict isKindOfClass:[NSString class]] ? [self imageContentWithDict:responseObject] : [self imageContentWithDict:dict];
        
        success(content);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        failure(error);
    }];
}

+ (instancetype)imageContentWithDict:(NSDictionary *)dict{
    
    id obj = [[self alloc] init];
    
    [obj setValuesForKeysWithDictionary:dict];
    
    return obj;
}

- (void)setPhotos:(NSArray *)photos{
    
    NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:photos.count];
    
    for (NSDictionary *dict in photos) {
        
        WSPhoto *image = [WSPhoto imageWithDict:dict];
        [arrM addObject:image];
    }
    _photos = [arrM copy];
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    
}

@end
