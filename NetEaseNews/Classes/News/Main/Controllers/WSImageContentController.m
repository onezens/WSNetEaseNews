//
//  WSImageController.m
//  网易新闻
//
//  Created by WackoSix on 16/1/1.
//  Copyright © 2016年 WackoSix. All rights reserved.
//

#import "WSImageContentController.h"
#import "WSGetDataTool.h"
#import "WSImageContent.h"
#import "WSPhoto.h"
#import "UIImageView+WebCache.h"
#import "WSCommentController.h"
#import "NSString+WS.h"
#import "WSImageCell.h"

@interface WSImageContentController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;
@property (weak, nonatomic) IBOutlet UIButton *replyCount;

@property (strong, nonatomic) WSImageContent *imageContent;

@end

static NSString *CellID = @"imageCell_co";
@implementation WSImageContentController


#pragma mark - collectionView delegate




#pragma mark - collectionView datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.imageContent.photos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    WSImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellID forIndexPath:indexPath];
    
    cell.imageContent = self.imageContent;
    
    cell.indexPath = indexPath;

    
    return cell;
}




#pragma mark - view

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.pagingEnabled = YES;
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.flowLayout.itemSize = CGSizeMake(kScreenWidth, kScreenHeight - 49 - 64);
    self.flowLayout.minimumLineSpacing = 0;
    
    UINib *nib = [UINib nibWithNibName:@"WSImageCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:CellID];
    
    [self loadData];
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)setImageContent:(WSImageContent *)imageContent{
    
    _imageContent = imageContent;

    [self.replyCount setTitle:[NSString stringWithFormat:@"%ld跟帖",self.replycount] forState:UIControlStateNormal];

    [self.collectionView reloadData];
    
}

- (void)loadData {
    
    typeof(self) __weak weakSelf = self;
    
    [WSImageContent imageContentWithPhotoID:self.photosetID getDataSuccess:^(WSImageContent *content) {
        
        weakSelf.imageContent = content;
        
    } getDataFailure:^(NSError *error) {
        
        NSLog(@"getData failed:%@",error);
        
    }];
    
}
- (IBAction)commentBtn {
    
    WSCommentController *commentVC = [[WSCommentController alloc] init];
    commentVC.postid = self.imageContent.postid;
    [self.navigationController pushViewController:commentVC animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (IBAction)backItem {
    
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)dealloc{
    
//    NSLog(@"%s",__func__);
    
     [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
}
@end