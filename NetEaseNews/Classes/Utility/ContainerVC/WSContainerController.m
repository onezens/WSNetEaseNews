//
//  WSContainerController.m
//  WSContainViewController
//
//  Created by WackoSix on 16/1/6.
//  Copyright © 2016年 WackoSix. All rights reserved.
//

#import "WSContainerController.h"
#import "WSNavigationView.h"

@interface WSContainerController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) NSArray *viewControllers;

@property (assign, nonatomic) NSInteger selectedIndex;

@property (weak, nonatomic) UICollectionView *collectionView;

@property (weak, nonatomic) UICollectionViewFlowLayout *flowLayout;

@property (weak, nonatomic) WSNavigationView *navigationView;

@end

static NSString *CellID = @"ControllerCell";

@implementation WSContainerController


#pragma mark - collectionView datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.viewControllers.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellID forIndexPath:indexPath];
    
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    UIView *view = [self.viewControllers[indexPath.item] view];
    
    [cell.contentView addSubview:view];
    
    view.frame = cell.bounds;
    
    return cell;
}

#pragma mark - collectionView delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSInteger index = scrollView.contentOffset.x / self.view.bounds.size.width;
    
    self.navigationView.selectedItemIndex = index;
}

#pragma mark - setting

- (void)setSelectedIndex:(NSInteger)selectedIndex{
    
    _selectedIndex = selectedIndex;
    
    CGFloat offsetX = self.view.bounds.size.width * selectedIndex;
    
    self.collectionView.contentOffset = CGPointMake(offsetX, 0);
}

#pragma mark - view

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    //禁用滚动到最顶部的属性
    self.collectionView.scrollsToTop = NO;
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    CGFloat width = self.view.bounds.size.width;
    CGFloat height = self.view.bounds.size.height;
    CGFloat topNav = 64;
    CGFloat bottomTab = 49;
    
    if (self.navigationController && self.tabBarController) {
        
        self.navigationView.frame = CGRectMake(0, topNav, width, 44);
        self.collectionView.frame = CGRectMake(0, topNav+self.navigationView.frame.size.height, width, height - self.navigationView.frame.size.height - bottomTab - topNav);
        
    }else{
        
        self.navigationView.frame = CGRectMake(0, 0, width, 44);
    }
    
    self.flowLayout.itemSize = self.collectionView.bounds.size;
    
}

#pragma mark - init

- (void)setParentController:(UIViewController *)parentController{
    
    _parentController = parentController;
    
    [parentController addChildViewController:self];
    [parentController.view addSubview:self.view];
}

+ (instancetype)containerControllerWithSubControlers:(NSArray<UIViewController *> *)viewControllers parentController:(UIViewController *)vc{
    
    id container = [[self alloc] init];
    
    [container setViewControllers:viewControllers];
    [container setParentController:vc];

    __block NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:viewControllers.count];
    [viewControllers enumerateObjectsUsingBlock:^(UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [container addChildViewController:obj];
        [arrM addObject:obj.title ? : @""];
    }];
    
    [container navigationView].items = arrM.copy;
    [container navigationView].selectedItemIndex = 0;
    
    return container;
}

- (instancetype)init{
    
    if (self = [super init]) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout = flowLayout;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        
        //设置collectionView的属性
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
        collectionView.pagingEnabled = YES;
        _collectionView = collectionView;
        [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:CellID];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.showsHorizontalScrollIndicator = NO;
        [self.view addSubview:collectionView];
        
        //添加导航view
        typeof(self) __weak weakObj= self;
        WSNavigationView *view = [WSNavigationView navigationViewWithItems:nil itemClick:^(NSInteger selectedIndex) {
            
            [weakObj setSelectedIndex:selectedIndex];
        }];
        view.backgroundColor = [UIColor whiteColor];
        
        [self.view addSubview:view];
        
        [self setNavigationView:view];
        
    }
    return self;
}

@end
