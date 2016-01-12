//
//  WSComment.m
//  网易新闻
//
//  Created by WackoSix on 16/1/1.
//  Copyright © 2016年 WackoSix. All rights reserved.
//

#import "WSComment.h"

//http://comment.api.163.com/api/json/post/list/new/normal/news3_bbs/%@/desc/%ld/10/10/2/2
//http://comment.api.163.com/api/json/post/list/new/hot/news3_bbs/%@/0/10/10/2/2
//
//http://comment.api.163.com/api/json/post/list/new/normal/ent2_bbs/PHOTHQMD000300AJ/desc/0/10/10/2/2
//http://comment.api.163.com/api/json/post/list/new/hot/ent2_bbs/PHOTHQMD000300AJ/0/10/10/2/2

@implementation WSComment

+ (void)commentWithID:(NSString *)ID index:(NSInteger)index type:(WSCommentType)type getDataSuccess:(GetDataSuccessBlock)success getDataFailure:(GetDataFailureBlock)falilure{
    
    NSString *urlStr = nil;
    NSString *key = nil;
    
    switch (type) {
        case WSCommentTypeContentNormal:
            urlStr = [NSString stringWithFormat:@"normal/news3_bbs/%@/desc/%ld/10/10/2/2",ID, index];
            key = @"newPosts";
            break;
        case WSCommentTypeContentHot:
            urlStr = [NSString stringWithFormat:@"hot/news3_bbs/%@/0/10/10/2/2",ID];
            key = @"hotPosts";
            break;
        case WSCommentTypeImageContentNormal:
            urlStr = [NSString stringWithFormat:@"normal/ent2_bbs/%@/desc/%ld/10/10/2/2",ID, index];
            key = @"newPosts";
            break;
        case WSCommentTypeImageContentHot:
            key = @"hotPosts";
            urlStr = [NSString stringWithFormat:@"hot/ent2_bbs/%@/0/10/10/2/2",ID];
            break;
            
        default:
            break;
    }
    
//    NSLog(@"%@",urlStr);
    
    [WSGetDataTool GETJSON:urlStr GetDataType:WSGETDataTypeCommentURL progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSArray *dictArr = responseObject[key];
        
        NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:dictArr.count];
        
        for (NSDictionary *dict in dictArr) {
        
            WSComment *comment = [self commentWithDict:dict[@"1"]];
            [arrM addObject:comment];
        }
        
        success(arrM.copy);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        falilure(error);
    }];
}

- (void)setF:(NSString *)f{
    
    NSRange range;
    range.location = 2;
    range.length = [f rangeOfString:@"火星网友"].location - 2;
    if (range.length > f.length) {
        _f = @"火星";
        return;
    }
    _f = [f substringWithRange:range];
}

+ (instancetype)commentWithDict:(NSDictionary *)dict{
    
    WSComment *comment = [[self alloc] init];
    
    [comment setValuesForKeysWithDictionary:dict];
    
    return comment;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    
}

@end
