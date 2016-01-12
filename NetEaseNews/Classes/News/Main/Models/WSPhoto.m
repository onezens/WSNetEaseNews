


//
//  WSImage.m
//  网易新闻
//
//  Created by WackoSix on 16/1/2.
//  Copyright © 2016年 WackoSix. All rights reserved.
//

#import "WSPhoto.h"

@implementation WSPhoto

+ (instancetype)imageWithDict:(NSDictionary *)dict{
    
    id obj = [[self alloc] init];
    
    [obj setValuesForKeysWithDictionary:dict];
    
    return obj;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    
}

@end
