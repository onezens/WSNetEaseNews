

//
//  WSAudioController.m
//  网易新闻
//
//  Created by WackoSix on 16/1/11.
//  Copyright © 2016年 WackoSix. All rights reserved.
//

#import "WSAudioController.h"

@implementation WSAudioController



#pragma mark - init

+ (instancetype)audioController{
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Media" bundle:nil];
    
   return [sb instantiateViewControllerWithIdentifier:@"audioController"];
}

@end
