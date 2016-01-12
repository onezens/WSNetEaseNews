//
//  WSRollController.m
//  网易新闻
//
//  Created by WackoSix on 16/1/9.
//  Copyright © 2016年 WackoSix. All rights reserved.
//

#import "WSRollController.h"
#import "WSRollCell.h"
#import "Masonry.h"
#import "WSAds.h"

@interface WSRollController ()

@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;

@property (assign, nonatomic) NSInteger currentIndex;

@property (weak, nonatomic) UIImageView *typeView;

@property (weak, nonatomic) UIPageControl *pageControl;

@property (weak, nonatomic) UILabel *titleLbl;

@property (copy, nonatomic) SelectedItemBlock selectedItem;

@end

@implementation WSRollController


- (void)rollControllerWithAds:(NSArray *)ads selectedItem:(SelectedItemBlock)sel{
    
    self.ads = ads;
    self.selectedItem = sel;
}

static NSString * const reuseIdentifier = @"rollCell";
#define kSectionCount 3

- (void)viewDidLoad {
    [super viewDidLoad];
    
   self.flowLayout.minimumLineSpacing = 0;
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    [self loadSubViews];
}

- (void)loadSubViews{
    
    CGFloat margin = 8;
    CGFloat height = 20;
    
    
    //uiview
    UIView *shadowView = [[UIView alloc] init];
    shadowView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"headnewscell_banner_shadow"]];
    
    [self.view addSubview:shadowView];
    [shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.height.equalTo(@(height * 3));
        make.bottom.left.right.equalTo(self.view);
        
    }];
    
    //imageView
    UIImage *image = [UIImage imageNamed:@"cell_tag_photo"];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIImageView *typeView = [[UIImageView alloc] initWithImage:image];
    [self.view addSubview:typeView];
    _typeView = typeView;
    typeView.contentMode = UIViewContentModeCenter;
    [typeView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.view).offset(margin);
        make.bottom.equalTo(self.view).offset(-margin);
        make.width.height.equalTo(@(height));
        
    }];
    typeView.tintColor = [UIColor whiteColor];
    
    //label
    UILabel *titleLbl = [[UILabel alloc] init];
    [self.view addSubview:titleLbl];
    _titleLbl = titleLbl;
    titleLbl.textColor = [UIColor whiteColor];
    titleLbl.font = [UIFont systemFontOfSize:14];
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(typeView.mas_right).offset(margin-4);
        make.bottomMargin.equalTo(typeView);
        make.height.equalTo(@(height));
        
    }];
    
    //pagecontrol
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    [self.view addSubview:pageControl];
    _pageControl = pageControl;
    [pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.view).offset(-margin);
        make.bottomMargin.equalTo(self.view).offset(-margin);
        
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.flowLayout.itemSize = self.collectionView.bounds.size;
    self.currentIndex = 0;
}

- (void)setAds:(NSArray *)ads{
    
    _ads = ads;
    [self.collectionView reloadData];
    self.pageControl.numberOfPages = ads.count;
    self.pageControl.hidden = !(ads.count > 1);
    self.collectionView.scrollEnabled = ads.count > 1 ;
}

#pragma mark - collection delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    

    NSInteger index = scrollView.contentOffset.x / scrollView.bounds.size.width;
    
    self.currentIndex = index % self.ads.count;
}

- (void)setCurrentIndex:(NSInteger)currentIndex{
    
    _currentIndex = currentIndex;
    
    self.collectionView.contentOffset = CGPointMake(self.collectionView.bounds.size.width * currentIndex + self.collectionView.bounds.size.width * self.ads.count, 0);
    
    self.pageControl.currentPage = currentIndex;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
     
    if (self.selectedItem) {
    
        self.selectedItem(self.ads[indexPath.item]);
    }
    
}


#pragma mark - collection datasource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return kSectionCount;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.ads.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    WSRollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.ad = self.ads[indexPath.item];
    
    self.titleLbl.text = [self.ads[indexPath.item] title];
    
    return cell;
}




@end