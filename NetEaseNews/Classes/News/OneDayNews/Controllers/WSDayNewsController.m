//
//  WSDayNewsController.m
//  网易新闻
//
//  Created by WackoSix on 16/1/10.
//  Copyright © 2016年 WackoSix. All rights reserved.
//

#import "WSDayNewsController.h"
#import "WSDayNewsCell.h"
#import "YiRefreshFooter.h"
#import "YiRefreshHeader.h"
#import "WSNews.h"
#import "MBProgressHUD.h"
#import "WSContentController.h"
#import "WSImageContentController.h"

@interface WSDayNewsController ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *news;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (assign, nonatomic) NSInteger newsIndex;

@property (strong, nonatomic) YiRefreshFooter *refreshFooter;

@property (strong, nonatomic) YiRefreshHeader *refreshHeader;


@end

NSString * dayNewsID = @"T1429173683626";

@implementation WSDayNewsController


+ (instancetype)dayNews{
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"DayNews" bundle:nil];
    
    return [sb instantiateInitialViewController];
}

- (IBAction)back {
    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - view

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
    
    typeof(self) __weak weakSelf = self;
    
    YiRefreshHeader *refreshHeader = [[YiRefreshHeader alloc] init];
    refreshHeader.scrollView = self.tableView;
    _refreshHeader = refreshHeader;
    refreshHeader.beginRefreshingBlock = ^(){
        
        weakSelf.newsIndex = 0;
        [weakSelf loadData];
        
    };
    [refreshHeader header];
    [refreshHeader beginRefreshing];
    
    YiRefreshFooter *refreshFooter = [[YiRefreshFooter alloc] init];
    refreshFooter.scrollView = self.tableView;
    refreshFooter = refreshFooter;
    refreshFooter.beginRefreshingBlock = ^(){
      
        [weakSelf loadData];
        
    };
    [refreshFooter footer];
}

- (void)loadData{
    
    typeof(self) __weak weakSelf = self;

    [WSNews newsListDataWithNewsID:[self urlStr] newsCache:weakSelf.newsIndex==0 getDataSuccess:^(NSArray *dataArr) {
        
        if(weakSelf.newsIndex == 0)  [weakSelf.news removeAllObjects];
        if (dataArr.count > 0) {
            
            [weakSelf.news addObjectsFromArray:dataArr];
            [weakSelf.tableView reloadData];
            weakSelf.newsIndex += 20;
            [weakSelf.refreshHeader endRefreshing];
            [weakSelf.refreshFooter endRefreshing];
            
        }

    } getFailure:^(NSError *error) {
        
        NSLog(@"%@",error);
        [weakSelf.refreshHeader endRefreshing];
        [weakSelf.refreshFooter endRefreshing];
    }];
}

- (NSString *)urlStr{
    
    NSString *urlStr = [NSString stringWithFormat:@"/nc/article/list/T1429173683626/%ld-%ld.html",self.newsIndex, self.newsIndex + 20];
    
    return urlStr;
}

#pragma mark - tableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WSNews *news = self.news[indexPath.row];
    
    if (news.photosetID) {
        
        WSImageContentController *imageVC = [[WSImageContentController alloc] init];
        imageVC.photosetID = news.photosetID;
        imageVC.replycount = news.replyCount;
        [self.navigationController pushViewController:imageVC animated:YES];
       
    }else if (news.docid){
        
        WSContentController *content = [WSContentController contentControllerWithID:news.docid];
        [self.navigationController pushViewController:content animated:YES];
    }
    
}


#pragma mark - tableview datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [WSDayNewsCell rowHeightWithIndexPath:indexPath];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [MBProgressHUD hideAllHUDsForView:self.tableView animated:YES];
    
    WSDayNewsCell *cell = [WSDayNewsCell dayNewsCellWithTableView:tableView indexPath:indexPath];
    cell.news = self.news[indexPath.row];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.news.count;
    
}

- (NSMutableArray *)news{
    
    if (!_news) {
        
        _news = [NSMutableArray arrayWithArray:[WSNews cacheFileArrWithChannelID:dayNewsID]] ? : [NSMutableArray array];
        
    }
    return _news;
}


- (UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
}

@end