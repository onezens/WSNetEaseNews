//
//  WSMediaController.m
//  网易新闻
//
//  Created by WackoSix on 16/1/10.
//  Copyright © 2016年 WackoSix. All rights reserved.
//

#import "WSMediaController.h"
#import "WSContainerController.h"
#import "WSAudioController.h"
#import "WSVideoController.h"


@interface WSMediaController ()

@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;

@property (strong, nonatomic) NSArray *viewControllers;

@end

static NSString * ID = @"MediaCell";

@implementation WSMediaController


#pragma mark- collectionView datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.viewControllers.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    UIView *view = [self.viewControllers[indexPath.item] view];
    
    [cell.contentView addSubview:view];
    
    view.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    
    return cell;
}


#pragma mark - view


- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.flowLayout.itemSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height - 64 - 49);
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.flowLayout.minimumLineSpacing = 0;
    self.flowLayout.minimumInteritemSpacing = 0;
    
    self.collectionView.pagingEnabled = YES;
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ID];
    
}


#pragma mark - lazy loading

- (NSArray *)viewControllers{
    
    if (!_viewControllers) {
        
        WSAudioController *vc1 = [WSAudioController audioController];
        WSVideoController *vc2 = [WSVideoController videoController];
        
        _viewControllers = @[vc2, vc1];
    }
    return _viewControllers;
}



@end
