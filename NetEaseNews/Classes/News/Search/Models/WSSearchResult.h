//
//  WSSearchResult.h
//  网易新闻
//
//  Created by WackoSix on 16/1/10.
//  Copyright © 2016年 WackoSix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSGetDataTool.h"

@interface WSSearchResult : NSObject


@property (copy, nonatomic) NSString *docid;

@property (copy, nonatomic) NSString *title;

@property (copy, nonatomic) NSString *skipID;

@property (copy, nonatomic) NSString *dkeys;

@property (copy, nonatomic) NSString *skipType;

@property (copy, nonatomic) NSString *ptime;

+ (void)searchResultWithKey:(NSString *)key result:(GetDataSuccessBlock)result;

@end
